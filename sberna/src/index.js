// Sběrna WoWpoČesku: přijímá anglické texty nových questů od Pomocníků.
// Nic osobního se neukládá: jen číslo questu, anglický text, náhodné ID instalace a otisk IP (kvůli limitům).
//
//   POST /submit      { id, client, fields: { title, text, objectives, progress, reward, gossip } }
//   POST /fix         { id, client, field, en, cs } -> oprava překladu od hráče (čeká na schválení)
//   --- jen pro správce (Authorization: Bearer ADMIN_KEY) ---
//   GET  /confirmed                -> potvrzené texty, které ještě nebyly exportované
//   POST /ack                      [{ quest_id, field, en_hash }] -> označí jako exportované
//   GET  /corrections              -> čekající opravy (+ příznak trusted, druh)
//   POST /corrections/add          [{ quest_id, field, en, cs, kind }] -> návrh ke schválení (od zpracování)
//   POST /corrections/resolve      [{ id, status: "applied" | "rejected" }]
//   GET  /who?quest_id=N           -> kdo poslal texty / opravy k questu (pro dohledání vandala)
//   POST /ban                      { client } -> zablokuje hráče i jeho IP a zahodí vše, co poslal

// "gossip" = rozhovor s NPC (id = číslo NPC místo čísla questu), "ui" = text rozhraní (talenty…, id = 1)
const FIELDS = ["title", "text", "objectives", "progress", "reward", "gossip", "ui"];
const KINDS = ["oprava", "zmena", "filtr"];
const MAX_LEN = 5000;
const MAX_CS_LEN = 8000;
const DAY_LIMIT_CLIENT = 300;
const DAY_LIMIT_IP = 500;
const DAY_LIMIT_FIX = 100;

export default {
  async fetch(req, env) {
    const url = new URL(req.url);
    const route = `${req.method} ${url.pathname}`;
    try {
      switch (route) {
        case "POST /submit": return await submit(req, env);
        case "POST /fix": return await fix(req, env);
        case "GET /confirmed": return admin(req, env, () => confirmed(env));
        case "POST /ack": return admin(req, env, () => ack(req, env));
        case "GET /corrections": return admin(req, env, () => corrections(env));
        case "POST /corrections/add": return admin(req, env, () => addCorrections(req, env));
        case "POST /corrections/resolve": return admin(req, env, () => resolveCorrections(req, env));
        case "GET /who": return admin(req, env, () => who(url, env));
        case "POST /ban": return admin(req, env, () => ban(req, env));
        case "POST /dispatch": return admin(req, env, async () => json(await dispatchIfNeeded(env, true)));
        case "GET /dispatch-check": return admin(req, env, async () => {
          // Diagnostika klíče (bez jeho vypsání): typ, délka, zda s ním jde číst repozitář a workflow
          const t = (env.GITHUB_TOKEN || "").trim();
          const h = { Authorization: `Bearer ${t}`, Accept: "application/vnd.github+json", "User-Agent": "wowpocesku-sberna" };
          const repo = await fetch("https://api.github.com/repos/RankonRP/WoWpoCesku", { headers: h });
          const wf = await fetch("https://api.github.com/repos/RankonRP/WoWpoCesku/actions/workflows/zpracovani.yml", { headers: h });
          return json({
            typ: t.startsWith("github_pat_") ? "fine-grained" : t.startsWith("ghp_") ? "classic" : "neznámý",
            delka: t.length,
            podezrele_znaky: /[^A-Za-z0-9_]/.test(t),
            repo: repo.status,
            workflow: wf.status,
            workflow_detail: wf.status === 200 ? (await wf.json()).state : (await wf.text()).slice(0, 200),
          });
        });
        case "GET /": return json({ ok: true, service: "WoWpoCesku sberna" });
        default: return json({ error: "not found" }, 404);
      }
    } catch (e) {
      console.error(e);
      return json({ error: "server error" }, 500);
    }
  },

  // Každou hodinu (wrangler.toml -> triggers.crons): když je co zpracovat, spustit zpracování
  // na GitHubu. Plánovač GitHubu je u málo aktivních repozitářů nespolehlivý.
  async scheduled(event, env, ctx) {
    ctx.waitUntil(dispatchIfNeeded(env));
  },
};

// force = spustit i bez čekající práce (POST /dispatch, test správce)
async function dispatchIfNeeded(env, force = false) {
  if (!env.GITHUB_TOKEN) return { ok: false, error: "chybí GITHUB_TOKEN" };
  const items = (await (await confirmed(env)).json()).items || [];
  const fixes = await env.DB.prepare(
    `SELECT COUNT(*) AS n FROM corrections t
      WHERE t.status = 'pending' AND instr(?1, ',' || t.client || ',') > 0`
  ).bind(trustedList(env)).first();
  if (!force && !items.length && !fixes.n) return { ok: true, dispatched: false };
  const r = await fetch(
    "https://api.github.com/repos/RankonRP/WoWpoCesku/actions/workflows/zpracovani.yml/dispatches",
    {
      method: "POST",
      headers: {
        Authorization: `Bearer ${env.GITHUB_TOKEN.trim()}`,
        Accept: "application/vnd.github+json",
        "X-GitHub-Api-Version": "2022-11-28",
        "User-Agent": "wowpocesku-sberna",
        "content-type": "application/json",
      },
      body: JSON.stringify({ ref: "main" }),
    }
  );
  console.log(`dispatch: ${r.status} (textů ${items.length}, oprav ${fixes.n})`);
  return { ok: r.status === 204, dispatched: true, github_status: r.status, detail: r.status === 204 ? "" : await r.text(), texts: items.length, fixes: fixes.n };
}

function json(data, status = 200) {
  return new Response(JSON.stringify(data), {
    status,
    headers: { "content-type": "application/json; charset=utf-8" },
  });
}

async function sha256(text) {
  const buf = await crypto.subtle.digest("SHA-256", new TextEncoder().encode(text));
  return [...new Uint8Array(buf)].map((b) => b.toString(16).padStart(2, "0")).join("");
}

// Stejný text od různých hráčů se může lišit mezerami / konci řádků
function normalize(text) {
  return text.replace(/\r\n?/g, "\n").replace(/[ \t]+/g, " ").replace(/ *\n */g, "\n").trim();
}

function isAdmin(req, env) {
  const auth = req.headers.get("authorization") || "";
  const key = (env.ADMIN_KEY || "").trim();
  return key.length >= 32 && auth === `Bearer ${key}`;
}

async function admin(req, env, handler) {
  if (!isAdmin(req, env)) return json({ error: "unauthorized" }, 401);
  return handler();
}

function trustedList(env) {
  return `,${(env.TRUSTED_CLIENTS || "").replace(/\s/g, "")},`;
}

async function ipHashOf(req, env) {
  const ip = req.headers.get("cf-connecting-ip") || "";
  return (await sha256(`${env.IP_SALT || ""}:${ip}`)).slice(0, 32);
}

async function isBanned(env, client, ipHash) {
  const row = await env.DB.prepare(
    `SELECT 1 AS x FROM banned WHERE (kind = 'client' AND value = ?1) OR (kind = 'ip' AND value = ?2) LIMIT 1`
  ).bind(client, ipHash).first();
  return !!row;
}

// Podmínka "od nezablokovaných" pro dotazy nad submissions/corrections (alias tabulky = t)
const NOT_BANNED = `t.client NOT IN (SELECT value FROM banned WHERE kind = 'client')
                   AND t.ip_hash NOT IN (SELECT value FROM banned WHERE kind = 'ip')`;

// ---------------------------------------------------------------------------
// Hráči
// ---------------------------------------------------------------------------
async function submit(req, env) {
  let body;
  try { body = await req.json(); } catch { return json({ error: "invalid json" }, 400); }

  const id = body?.id;
  const client = body?.client;
  const fields = body?.fields;
  if (!Number.isInteger(id) || id < 1 || id > 2_000_000) return json({ error: "invalid id" }, 400);
  if (typeof client !== "string" || !/^[a-f0-9]{32}$/.test(client)) return json({ error: "invalid client" }, 400);
  if (!fields || typeof fields !== "object") return json({ error: "invalid fields" }, 400);

  const rows = [];
  for (const [field, raw] of Object.entries(fields)) {
    if (!FIELDS.includes(field)) return json({ error: `unknown field ${field}` }, 400);
    if (typeof raw !== "string") return json({ error: `invalid ${field}` }, 400);
    const text = normalize(raw);
    if (!text) continue;
    if (text.length > MAX_LEN) return json({ error: `${field} too long` }, 400);
    // Anglický klient: text musí být skoro celý ASCII (jinak jde o nesmysl nebo jiný jazyk)
    const nonAscii = text.replace(/[\x00-\x7F]/g, "").length;
    if (nonAscii > text.length * 0.05) return json({ error: `${field} is not english` }, 400);
    rows.push({ field, text, hash: await sha256(text) });
  }
  if (!rows.length) return json({ error: "empty" }, 400);

  const ipHash = await ipHashOf(req, env);
  // Zablokovaný hráč dostane "ok", ale nic se neuloží (ať nepozná, že je zablokovaný)
  if (await isBanned(env, client, ipHash)) return json({ ok: true, stored: rows.length });

  const since = Date.now() - 24 * 3600 * 1000;
  const limits = await env.DB.prepare(
    `SELECT
       (SELECT COUNT(*) FROM submissions WHERE client = ?1 AND created_at > ?3) AS by_client,
       (SELECT COUNT(*) FROM submissions WHERE ip_hash = ?2 AND created_at > ?3) AS by_ip`
  ).bind(client, ipHash, since).first();
  if (limits.by_client >= DAY_LIMIT_CLIENT || limits.by_ip >= DAY_LIMIT_IP) {
    return json({ error: "daily limit reached" }, 429);
  }

  const now = Date.now();
  await env.DB.batch(rows.map((r) =>
    env.DB.prepare(
      `INSERT OR IGNORE INTO submissions (quest_id, field, en_hash, en_text, client, ip_hash, created_at)
       VALUES (?1, ?2, ?3, ?4, ?5, ?6, ?7)`
    ).bind(id, r.field, r.hash, r.text, client, ipHash, now)
  ));
  return json({ ok: true, stored: rows.length });
}

async function fix(req, env) {
  let body;
  try { body = await req.json(); } catch { return json({ error: "invalid json" }, 400); }
  const { id, client, field, en, cs } = body || {};
  if (!Number.isInteger(id) || id < 1 || id > 2_000_000) return json({ error: "invalid id" }, 400);
  if (typeof client !== "string" || !/^[a-f0-9]{32}$/.test(client)) return json({ error: "invalid client" }, 400);
  if (!FIELDS.includes(field)) return json({ error: "invalid field" }, 400);
  if (typeof en !== "string" || typeof cs !== "string") return json({ error: "invalid text" }, 400);
  const enText = normalize(en);
  const csText = cs.replace(/\r\n?/g, "\n").trim();
  if (!enText || !csText) return json({ error: "empty" }, 400);
  if (enText.length > MAX_LEN || csText.length > MAX_CS_LEN) return json({ error: "too long" }, 400);

  const ipHash = await ipHashOf(req, env);
  if (await isBanned(env, client, ipHash)) return json({ ok: true });

  const since = Date.now() - 24 * 3600 * 1000;
  const lim = await env.DB.prepare(
    `SELECT COUNT(*) AS n FROM corrections WHERE (client = ?1 OR ip_hash = ?2) AND created_at > ?3`
  ).bind(client, ipHash, since).first();
  if (lim.n >= DAY_LIMIT_FIX) return json({ error: "daily limit reached" }, 429);

  // Starší čekající oprava stejného pole od stejného hráče se nahradí novou
  await env.DB.batch([
    env.DB.prepare(
      `UPDATE corrections SET status = 'superseded' WHERE quest_id = ?1 AND field = ?2 AND client = ?3 AND status = 'pending'`
    ).bind(id, field, client),
    env.DB.prepare(
      `INSERT INTO corrections (quest_id, field, en_hash, en_text, cs_text, client, ip_hash, created_at, kind)
       VALUES (?1, ?2, ?3, ?4, ?5, ?6, ?7, ?8, 'oprava')`
    ).bind(id, field, await sha256(enText), enText, csText, client, ipHash, Date.now()),
  ]);
  return json({ ok: true });
}

// ---------------------------------------------------------------------------
// Správce (GitHub Actions / nástroje)
// ---------------------------------------------------------------------------
async function confirmed(env) {
  const minReporters = parseInt(env.MIN_REPORTERS || "2", 10);
  // Potvrzení = stejný text od více hráčů z RŮZNÝCH IP adres (falešná ID z jednoho PC nestačí)
  const { results } = await env.DB.prepare(
    `SELECT t.quest_id, t.field, t.en_hash, MIN(t.en_text) AS en_text,
            COUNT(DISTINCT t.ip_hash) AS reporters,
            MAX(CASE WHEN instr(?1, ',' || t.client || ',') > 0 THEN 1 ELSE 0 END) AS trusted
       FROM submissions t
       LEFT JOIN exported e ON e.quest_id = t.quest_id AND e.field = t.field AND e.en_hash = t.en_hash
      WHERE e.quest_id IS NULL AND ${NOT_BANNED}
      GROUP BY t.quest_id, t.field, t.en_hash
     HAVING reporters >= ?2 OR trusted = 1
      ORDER BY t.quest_id
      LIMIT 5000`
  ).bind(trustedList(env), minReporters).all();
  return json({ ok: true, items: results });
}

async function ack(req, env) {
  let items;
  try { items = await req.json(); } catch { return json({ error: "invalid json" }, 400); }
  if (!Array.isArray(items)) return json({ error: "expected array" }, 400);
  const now = Date.now();
  const stmts = items
    .filter((i) => Number.isInteger(i?.quest_id) && FIELDS.includes(i?.field) && /^[a-f0-9]{64}$/.test(i?.en_hash || ""))
    .map((i) => env.DB.prepare(
      `INSERT OR IGNORE INTO exported (quest_id, field, en_hash, exported_at) VALUES (?1, ?2, ?3, ?4)`
    ).bind(i.quest_id, i.field, i.en_hash, now));
  for (let n = 0; n < stmts.length; n += 50) await env.DB.batch(stmts.slice(n, n + 50));
  return json({ ok: true, acked: stmts.length });
}

async function corrections(env) {
  const { results } = await env.DB.prepare(
    `SELECT t.id, t.quest_id, t.field, t.en_text, t.cs_text, t.created_at, t.kind,
            CASE WHEN instr(?1, ',' || t.client || ',') > 0 THEN 1 ELSE 0 END AS trusted
       FROM corrections t
      WHERE t.status = 'pending' AND ${NOT_BANNED}
      ORDER BY t.id LIMIT 500`
  ).bind(trustedList(env)).all();
  return json({ ok: true, items: results });
}

// Návrhy od zpracování (změna anglického originálu, zakázané slovo) -> ke schválení správcem
async function addCorrections(req, env) {
  let items;
  try { items = await req.json(); } catch { return json({ error: "invalid json" }, 400); }
  if (!Array.isArray(items)) return json({ error: "expected array" }, 400);
  const now = Date.now();
  const stmts = [];
  for (const i of items) {
    if (!Number.isInteger(i?.quest_id) || !FIELDS.includes(i?.field) || !KINDS.includes(i?.kind)) continue;
    if (typeof i.en !== "string" || typeof i.cs !== "string") continue;
    const enText = normalize(i.en);
    stmts.push(env.DB.prepare(
      `INSERT INTO corrections (quest_id, field, en_hash, en_text, cs_text, client, ip_hash, created_at, kind)
       VALUES (?1, ?2, ?3, ?4, ?5, 'zpracovani', '', ?6, ?7)`
    ).bind(i.quest_id, i.field, await sha256(enText), enText, i.cs, now, i.kind));
  }
  for (let n = 0; n < stmts.length; n += 50) await env.DB.batch(stmts.slice(n, n + 50));
  return json({ ok: true, added: stmts.length });
}

async function resolveCorrections(req, env) {
  let items;
  try { items = await req.json(); } catch { return json({ error: "invalid json" }, 400); }
  if (!Array.isArray(items)) return json({ error: "expected array" }, 400);
  const stmts = items
    .filter((i) => Number.isInteger(i?.id) && ["applied", "rejected"].includes(i?.status))
    .map((i) => env.DB.prepare(`UPDATE corrections SET status = ?1 WHERE id = ?2 AND status = 'pending'`).bind(i.status, i.id));
  for (let n = 0; n < stmts.length; n += 50) await env.DB.batch(stmts.slice(n, n + 50));
  return json({ ok: true, resolved: stmts.length });
}

// Kdo poslal texty / opravy k danému questu (nebo NPC)
async function who(url, env) {
  const id = parseInt(url.searchParams.get("quest_id") || "", 10);
  if (!Number.isInteger(id)) return json({ error: "quest_id required" }, 400);
  const subs = await env.DB.prepare(
    `SELECT client, substr(ip_hash, 1, 8) AS ip, field, substr(en_text, 1, 120) AS text, created_at
       FROM submissions WHERE quest_id = ?1 ORDER BY created_at DESC LIMIT 100`
  ).bind(id).all();
  const corr = await env.DB.prepare(
    `SELECT client, substr(ip_hash, 1, 8) AS ip, field, substr(cs_text, 1, 120) AS text, status, kind, created_at
       FROM corrections WHERE quest_id = ?1 ORDER BY created_at DESC LIMIT 100`
  ).bind(id).all();
  return json({ ok: true, submissions: subs.results, corrections: corr.results });
}

// Zablokovat hráče: jeho ID i všechny IP, ze kterých posílal; zahodit jeho neexportované texty a opravy
async function ban(req, env) {
  let body;
  try { body = await req.json(); } catch { return json({ error: "invalid json" }, 400); }
  const client = body?.client;
  if (typeof client !== "string" || !/^[a-f0-9]{32}$/.test(client)) return json({ error: "invalid client" }, 400);
  const ips = await env.DB.prepare(
    `SELECT DISTINCT ip_hash FROM submissions WHERE client = ?1
     UNION SELECT DISTINCT ip_hash FROM corrections WHERE client = ?1`
  ).bind(client).all();
  const now = Date.now();
  const stmts = [
    env.DB.prepare(`INSERT OR IGNORE INTO banned (kind, value, created_at) VALUES ('client', ?1, ?2)`).bind(client, now),
    ...ips.results.filter((r) => r.ip_hash).map((r) =>
      env.DB.prepare(`INSERT OR IGNORE INTO banned (kind, value, created_at) VALUES ('ip', ?1, ?2)`).bind(r.ip_hash, now)),
    env.DB.prepare(`DELETE FROM submissions WHERE client = ?1`).bind(client),
    env.DB.prepare(`UPDATE corrections SET status = 'rejected' WHERE client = ?1 AND status = 'pending'`).bind(client),
  ];
  await env.DB.batch(stmts);
  return json({ ok: true, banned_ips: ips.results.length });
}

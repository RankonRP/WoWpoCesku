// Sběrna WoWpoČesku: přijímá anglické texty nových questů od Pomocníků.
// Nic osobního se neukládá: jen číslo questu, anglický text, náhodné ID instalace a otisk IP (kvůli limitům).
//
//   POST /submit      { id, client, fields: { title, text, objectives, progress, reward } }
//   GET  /confirmed   (Authorization: Bearer ADMIN_KEY) -> potvrzené texty, které ještě nebyly exportované
//   POST /ack         (Authorization: Bearer ADMIN_KEY) [{ quest_id, field, en_hash }] -> označí jako exportované
//   POST /fix         { id, client, field, en, cs } -> oprava překladu od hráče (čeká na schválení)
//   GET  /corrections (admin) -> čekající opravy (+ příznak trusted)
//   POST /corrections/resolve (admin) [{ id, status: "applied" | "rejected" }]

const FIELDS = ["title", "text", "objectives", "progress", "reward"];
const MAX_LEN = 5000;
const DAY_LIMIT_CLIENT = 300;
const DAY_LIMIT_IP = 500;

export default {
  async fetch(req, env) {
    const url = new URL(req.url);
    try {
      if (req.method === "POST" && url.pathname === "/submit") return await submit(req, env);
      if (req.method === "GET" && url.pathname === "/confirmed") return await confirmed(req, env);
      if (req.method === "POST" && url.pathname === "/ack") return await ack(req, env);
      if (req.method === "POST" && url.pathname === "/fix") return await fix(req, env);
      if (req.method === "GET" && url.pathname === "/corrections") return await corrections(req, env);
      if (req.method === "POST" && url.pathname === "/corrections/resolve") return await resolveCorrections(req, env);
      if (req.method === "GET" && url.pathname === "/") return json({ ok: true, service: "WoWpoCesku sberna" });
      return json({ error: "not found" }, 404);
    } catch (e) {
      console.error(e);
      return json({ error: "server error" }, 500);
    }
  },
};

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

  const ip = req.headers.get("cf-connecting-ip") || "";
  const ipHash = (await sha256(`${env.IP_SALT || ""}:${ip}`)).slice(0, 32);
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

async function confirmed(req, env) {
  if (!isAdmin(req, env)) return json({ error: "unauthorized" }, 401);
  const minReporters = parseInt(env.MIN_REPORTERS || "2", 10);
  const trusted = `,${(env.TRUSTED_CLIENTS || "").replace(/\s/g, "")},`;

  const { results } = await env.DB.prepare(
    `SELECT s.quest_id, s.field, s.en_hash, MIN(s.en_text) AS en_text,
            COUNT(DISTINCT s.client) AS reporters,
            MAX(CASE WHEN instr(?1, ',' || s.client || ',') > 0 THEN 1 ELSE 0 END) AS trusted
       FROM submissions s
       LEFT JOIN exported e ON e.quest_id = s.quest_id AND e.field = s.field AND e.en_hash = s.en_hash
      WHERE e.quest_id IS NULL
      GROUP BY s.quest_id, s.field, s.en_hash
     HAVING reporters >= ?2 OR trusted = 1
      ORDER BY s.quest_id
      LIMIT 5000`
  ).bind(trusted, minReporters).all();
  return json({ ok: true, items: results });
}

const DAY_LIMIT_FIX = 100;
const MAX_CS_LEN = 8000;

function trustedList(env) {
  return `,${(env.TRUSTED_CLIENTS || "").replace(/\s/g, "")},`;
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

  const ip = req.headers.get("cf-connecting-ip") || "";
  const ipHash = (await sha256(`${env.IP_SALT || ""}:${ip}`)).slice(0, 32);
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
      `INSERT INTO corrections (quest_id, field, en_hash, en_text, cs_text, client, ip_hash, created_at)
       VALUES (?1, ?2, ?3, ?4, ?5, ?6, ?7, ?8)`
    ).bind(id, field, await sha256(enText), enText, csText, client, ipHash, Date.now()),
  ]);
  return json({ ok: true });
}

async function corrections(req, env) {
  if (!isAdmin(req, env)) return json({ error: "unauthorized" }, 401);
  const { results } = await env.DB.prepare(
    `SELECT id, quest_id, field, en_text, cs_text, created_at,
            CASE WHEN instr(?1, ',' || client || ',') > 0 THEN 1 ELSE 0 END AS trusted
       FROM corrections WHERE status = 'pending' ORDER BY id LIMIT 500`
  ).bind(trustedList(env)).all();
  return json({ ok: true, items: results });
}

async function resolveCorrections(req, env) {
  if (!isAdmin(req, env)) return json({ error: "unauthorized" }, 401);
  let items;
  try { items = await req.json(); } catch { return json({ error: "invalid json" }, 400); }
  if (!Array.isArray(items)) return json({ error: "expected array" }, 400);
  const stmts = items
    .filter((i) => Number.isInteger(i?.id) && ["applied", "rejected"].includes(i?.status))
    .map((i) => env.DB.prepare(`UPDATE corrections SET status = ?1 WHERE id = ?2 AND status = 'pending'`).bind(i.status, i.id));
  for (let n = 0; n < stmts.length; n += 50) await env.DB.batch(stmts.slice(n, n + 50));
  return json({ ok: true, resolved: stmts.length });
}

async function ack(req, env) {
  if (!isAdmin(req, env)) return json({ error: "unauthorized" }, 401);
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

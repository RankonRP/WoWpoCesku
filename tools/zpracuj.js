// Denní zpracování (GitHub Actions):
//   1) potvrzené nové questy ze sběrny -> překlad
//   2) opravy od hráčů -> důvěryhodné rovnou, ostatní ke schválení v issue na GitHubu
//   3) rozhovory s NPC -> rozhovory.json + DataRozhovory.lua
//   -> preklady.json + Data.lua
//
// Prostředí:
//   SBERNA_URL         adresa sběrny
//   SBERNA_ADMIN_KEY   admin klíč sběrny
//   PREKLADAC          "google" (výchozí) nebo "claude"
//   ANTHROPIC_API_KEY  jen pro PREKLADAC=claude
//   GH_TOKEN           token GitHub Actions (issue se schvalováním oprav)
//   GITHUB_REPOSITORY  owner/repo (nastaví GitHub Actions)
//   DRY_RUN=1          nic nezapisuje ani nepotvrzuje (test)

const fs = require("fs");
const path = require("path");

const { readCache, writeCache, writeDataLua, readGossip, writeGossip, writeGossipLua, gossipKey } = require("./soubory");
const { apply: applyRules } = require("./pravidla");

const ROOT = path.join(__dirname, "..");
const GLOSSARY_PATH = path.join(ROOT, "slovnicek.txt");

const { SBERNA_URL, SBERNA_ADMIN_KEY, ANTHROPIC_API_KEY } = process.env;
const PREKLADAC = process.env.PREKLADAC || "google";
const DRY_RUN = process.env.DRY_RUN === "1";

const sleep = (ms) => new Promise((r) => setTimeout(r, ms));
const simple = (s) => (s || "").toLowerCase().replace(/[\s\p{P}]/gu, "");

// ---------------------------------------------------------------------------
// Překladače
// ---------------------------------------------------------------------------
async function googleBatch(texts) {
  const body = texts.map((t) => "q=" + encodeURIComponent(t)).join("&");
  const r = await fetch("https://clients5.google.com/translate_a/t?client=dict-chrome-ex&sl=en&tl=cs", {
    method: "POST",
    body,
    headers: {
      "Content-Type": "application/x-www-form-urlencoded;charset=UTF-8",
      "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64)",
    },
  });
  if (!r.ok) throw new Error("Google HTTP " + r.status);
  const j = await r.json();
  return j.map((x) => (Array.isArray(x) ? x[0] : x));
}

async function claudeQuest(fields) {
  const glossary = fs.existsSync(GLOSSARY_PATH) ? fs.readFileSync(GLOSSARY_PATH, "utf8") : "";
  const system =
    "Překládáš texty questů z World of Warcraft z angličtiny do češtiny.\n" +
    "Dostaneš JSON objekt, kde každá hodnota je text k překladu. Vrať POUZE JSON objekt se stejnými klíči a přeloženými hodnotami, bez dalšího textu a bez markdownu.\n" +
    "Zachovej zástupné znaky {N} (jméno hráče), {C} (třída), {R} (rasa), zalomení řádků a čísla. Překládej přirozeně a čtivě, drž styl fantasy příběhu.\n" +
    "Řiď se tímto slovníčkem a pravidly:\n" + glossary;
  const r = await fetch("https://api.anthropic.com/v1/messages", {
    method: "POST",
    headers: {
      "x-api-key": ANTHROPIC_API_KEY,
      "anthropic-version": "2023-06-01",
      "content-type": "application/json",
    },
    body: JSON.stringify({
      model: "claude-haiku-4-5",
      max_tokens: 8000,
      system,
      messages: [{ role: "user", content: JSON.stringify(fields) }],
    }),
  });
  if (!r.ok) throw new Error("Claude HTTP " + r.status + " " + (await r.text()));
  const j = await r.json();
  const txt = j.content[0].text.trim().replace(/^```(json)?\s*/, "").replace(/\s*```$/, "");
  const out = JSON.parse(txt);
  for (const k of Object.keys(fields)) if (typeof out[k] !== "string") throw new Error("Claude nevrátil pole " + k);
  return out;
}

// quests: { id: { field: enText } } -> { id: { field: csText } }
async function translateAll(quests) {
  const result = {};
  if (PREKLADAC === "claude") {
    for (const [id, fields] of Object.entries(quests)) {
      const out = await claudeQuest(fields);
      for (const k of Object.keys(out)) out[k] = applyRules(out[k]);
      result[id] = out;
    }
    return result;
  }
  const todo = [];
  for (const [id, fields] of Object.entries(quests)) for (const [k, v] of Object.entries(fields)) todo.push({ id, k, v });
  for (let i = 0; i < todo.length; ) {
    const batch = [];
    let chars = 0;
    while (i < todo.length && (batch.length === 0 || chars + todo[i].v.length < 4000) && batch.length < 40) {
      chars += todo[i].v.length;
      batch.push(todo[i++]);
    }
    const out = await googleBatch(batch.map((b) => b.v));
    if (out.length !== batch.length) throw new Error("Google vrátil jiný počet textů");
    batch.forEach((b, n) => ((result[b.id] = result[b.id] || {})[b.k] = applyRules(out[n])));
    await sleep(1200);
  }
  return result;
}

// ---------------------------------------------------------------------------
// Sběrna
// ---------------------------------------------------------------------------
const auth = () => ({ Authorization: `Bearer ${SBERNA_ADMIN_KEY}` });

async function sberna(pathname, body) {
  const r = await fetch(`${SBERNA_URL}${pathname}`, body === undefined
    ? { headers: auth() }
    : { method: "POST", headers: { ...auth(), "content-type": "application/json" }, body: JSON.stringify(body) });
  if (!r.ok) throw new Error(`Sběrna ${pathname}: HTTP ${r.status}`);
  return r.json();
}

// Nové questy od hráčů -> překlad. Vrací seznam k potvrzení (ack).
async function processSubmissions(cache, gossip) {
  const all = (await sberna("/confirmed")).items || [];
  console.log(`Potvrzených textů ze sběrny: ${all.length}`);
  if (!all.length) return { changed: false, gossipChanged: false, ack: [] };
  const items = all.filter((it) => it.field !== "gossip");

  // Rozhovory s NPC: každý text zvlášť (jedno NPC jich může mít víc)
  const gossipTodo = {};
  for (const it of all.filter((it) => it.field === "gossip")) {
    const key = gossipKey(it.en_text);
    if (!gossip[key]?.cs && !gossipTodo[key]) gossipTodo[key] = { cs: it.en_text, npc: it.quest_id };
  }
  const gossipTr = await translateAll(Object.fromEntries(Object.entries(gossipTodo).map(([k, v]) => [k, { cs: v.cs }])));
  for (const [key, t] of Object.entries(gossipTr)) {
    gossip[key] = { cs: t.cs, en: gossipTodo[key].cs, npc: String(gossipTodo[key].npc), src: "komunita" };
  }
  console.log(`Rozhovorů přeloženo: ${Object.keys(gossipTr).length}`);

  // Pro každé pole questu vezmi text s nejvíc hlášeními (nebo od důvěryhodného hráče)
  const best = {};
  for (const it of items) {
    const key = `${it.quest_id}|${it.field}`;
    const score = it.reporters + (it.trusted ? 1000 : 0);
    if (!best[key] || score > best[key].score) best[key] = { ...it, score };
  }

  const toTranslate = {};
  for (const it of Object.values(best)) {
    const e = cache[it.quest_id];
    // Už přeloženo ze stejného anglického textu -> nic nedělat
    if (e && e[it.field] && simple(e["en_" + it.field]) === simple(it.en_text)) continue;
    (toTranslate[it.quest_id] = toTranslate[it.quest_id] || {})[it.field] = it.en_text;
  }
  console.log(`Questů k překladu: ${Object.keys(toTranslate).length} (${PREKLADAC})`);

  const translated = await translateAll(toTranslate);
  for (const [id, fields] of Object.entries(translated)) {
    const e = (cache[id] = cache[id] || {});
    for (const [k, v] of Object.entries(fields)) {
      e[k] = v;
      e["en_" + k] = toTranslate[id][k];
    }
    delete e.pre;
    e.src = "komunita";
  }
  return {
    changed: Object.keys(translated).length > 0,
    gossipChanged: Object.keys(gossipTr).length > 0,
    ack: all.map((it) => ({ quest_id: it.quest_id, field: it.field, en_hash: it.en_hash })),
  };
}

// ---------------------------------------------------------------------------
// Opravy od hráčů: důvěryhodné rovnou, ostatní přes issue na GitHubu (zaškrtávátka)
// ---------------------------------------------------------------------------
const { GH_TOKEN, GITHUB_REPOSITORY } = process.env;
const ISSUE_TITLE = "Opravy překladů ke schválení";
const ISSUE_LABEL = "opravy";
const FIELD_NAMES = { title: "Název", text: "Popis", objectives: "Úkol", progress: "Průběh", reward: "Odměna" };

async function github(pathname, method = "GET", body) {
  const r = await fetch(`https://api.github.com/repos/${GITHUB_REPOSITORY}${pathname}`, {
    method,
    headers: {
      Authorization: `Bearer ${GH_TOKEN}`,
      Accept: "application/vnd.github+json",
      "User-Agent": "wowpocesku-bot",
      ...(body ? { "content-type": "application/json" } : {}),
    },
    body: body ? JSON.stringify(body) : undefined,
  });
  if (!r.ok) throw new Error(`GitHub ${method} ${pathname}: HTTP ${r.status} ${await r.text()}`);
  return r.json();
}

function applyCorrection(cache, c) {
  const e = (cache[c.quest_id] = cache[c.quest_id] || {});
  e[c.field] = c.cs_text;
  e["en_" + c.field] = c.en_text;
  delete e.pre;
  e.src = "oprava";
}

// Text do issue: bez @zmínek (neposílat notifikace cizím lidem) a jako citace
const quote = (s) => "> " + (s || "–").replace(/@/g, "@\u200b").replace(/\r?\n/g, "\n> ");

function issueBody(pending, cache) {
  const parts = [
    "Hráči navrhli tyto opravy překladů. U každé zaškrtni **schválit** nebo **zamítnout** – " +
      "zpracování se spustí samo a schválené opravy se dostanou ke všem hráčům.\n",
  ];
  let size = parts[0].length, shown = 0;
  for (const c of pending) {
    const cur = cache[c.quest_id]?.[c.field];
    const block =
      `---\n### Oprava ${c.id} – quest ${c.quest_id}, ${FIELD_NAMES[c.field] || c.field}\n` +
      `<details><summary>Anglický originál</summary>\n\n${quote(c.en_text)}\n\n</details>\n\n` +
      `**Teď:**\n${quote(cur)}\n\n**Návrh:**\n${quote(c.cs_text)}\n\n` +
      `- [ ] schválit opravu ${c.id}\n- [ ] zamítnout opravu ${c.id}\n`;
    if (size + block.length > 60000) break;
    parts.push(block);
    size += block.length;
    shown++;
  }
  if (shown < pending.length) parts.push(`\n_…a dalších ${pending.length - shown} oprav se ukáže po vyřízení těchto._`);
  return parts.join("\n");
}

async function processCorrections(cache) {
  const items = (await sberna("/corrections")).items || [];
  console.log(`Čekajících oprav: ${items.length}`);
  const resolve = [];
  let changed = false;

  // Rozhodnutí z issue (zaškrtnutá políčka)
  let issue = null;
  const decisions = {};
  if (GH_TOKEN && GITHUB_REPOSITORY) {
    const open = await github(`/issues?state=open&labels=${ISSUE_LABEL}&per_page=10`);
    issue = open.find((i) => i.title === ISSUE_TITLE) || null;
    for (const m of (issue?.body || "").matchAll(/- \[[xX]\] (schválit|zamítnout) opravu (\d+)/g)) {
      decisions[m[2]] = m[1] === "schválit" ? "applied" : "rejected";
    }
  } else {
    console.log("Bez GH_TOKEN – schvalování přes issue se přeskakuje.");
  }

  const pending = [];
  for (const c of items) {
    const decision = c.trusted ? "applied" : decisions[c.id];
    if (decision === "applied") { applyCorrection(cache, c); changed = true; }
    if (decision) resolve.push({ id: c.id, status: decision });
    else pending.push(c);
  }
  console.log(`Oprav schváleno/zamítnuto: ${resolve.length}, stále čeká: ${pending.length}`);
  return { changed, resolve, pending, issue };
}

async function updateIssue(pending, issue, cache) {
  if (!GH_TOKEN || !GITHUB_REPOSITORY) return;
  if (!pending.length) {
    if (issue) await github(`/issues/${issue.number}`, "PATCH", { state: "closed", body: "Všechny opravy jsou vyřízené. ✔" });
    return;
  }
  const body = issueBody(pending, cache);
  if (issue) await github(`/issues/${issue.number}`, "PATCH", { body });
  else await github(`/issues`, "POST", { title: ISSUE_TITLE, body, labels: [ISSUE_LABEL] });
}

// ---------------------------------------------------------------------------
async function main() {
  if (!SBERNA_URL || !SBERNA_ADMIN_KEY) throw new Error("Chybí SBERNA_URL nebo SBERNA_ADMIN_KEY");
  const cache = readCache();
  const gossip = readGossip();

  const subs = await processSubmissions(cache, gossip);
  const corr = await processCorrections(cache);

  if (DRY_RUN) {
    console.log("DRY_RUN – nic se nezapisuje ani nepotvrzuje.");
    return;
  }
  if (subs.changed || corr.changed) {
    writeCache(cache);
    writeDataLua(cache);
  }
  if (subs.gossipChanged) {
    writeGossip(gossip);
    writeGossipLua(gossip);
  }
  if (subs.ack.length) await sberna("/ack", subs.ack);
  if (corr.resolve.length) await sberna("/corrections/resolve", corr.resolve);
  await updateIssue(corr.pending, corr.issue, cache);
  console.log("Hotovo.");
}

main().catch((e) => {
  console.error(e);
  process.exit(1);
});

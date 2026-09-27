// Denní zpracování (GitHub Actions): potvrzené questy ze sběrny -> překlad -> preklady.json + Data.lua
//
// Prostředí:
//   SBERNA_URL         adresa sběrny
//   SBERNA_ADMIN_KEY   admin klíč sběrny
//   PREKLADAC          "google" (výchozí) nebo "claude"
//   ANTHROPIC_API_KEY  jen pro PREKLADAC=claude
//   DRY_RUN=1          nic nezapisuje ani nepotvrzuje (test)

const fs = require("fs");
const path = require("path");

const ROOT = path.join(__dirname, "..");
const CACHE_PATH = path.join(ROOT, "preklady.json");
const DATA_LUA_PATH = path.join(ROOT, "WoWpoCesku", "Data.lua");
const GLOSSARY_PATH = path.join(ROOT, "slovnicek.txt");
const FIELD_ORDER = ["title", "text", "objectives", "progress", "reward"];

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
    for (const [id, fields] of Object.entries(quests)) result[id] = await claudeQuest(fields);
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
    batch.forEach((b, n) => ((result[b.id] = result[b.id] || {})[b.k] = out[n]));
    await sleep(1200);
  }
  return result;
}

// ---------------------------------------------------------------------------
// Zápis souborů (stejný formát jako pomocnik.ps1)
// ---------------------------------------------------------------------------
function writeCache(cache) {
  const ids = Object.keys(cache).sort((a, b) => a - b);
  const lines = ids.map((id, i) => {
    const entry = {};
    for (const k of Object.keys(cache[id]).sort()) entry[k] = cache[id][k];
    return `  "${id}": ${JSON.stringify(entry)}${i < ids.length - 1 ? "," : ""}`;
  });
  fs.writeFileSync(CACHE_PATH, "{\n" + lines.join("\n") + "\n}\n");
}

const luaString = (s) => '"' + s.replace(/\\/g, "\\\\").replace(/"/g, '\\"').replace(/\r/g, "").replace(/\n/g, "\\n") + '"';

function writeDataLua(cache) {
  const out = [
    "-- Tento soubor generuje pomocnik.ps1. Neupravuj ho ručně – oprav překlad v preklady.json.",
    "WoWpoCesku_Data = {",
  ];
  for (const id of Object.keys(cache).sort((a, b) => a - b)) {
    const e = cache[id];
    const parts = FIELD_ORDER.filter((f) => e[f]).map((f) => `${f}=${luaString(e[f])}`);
    if (e.en_title) parts.push(`en=${luaString(e.en_title)}`);
    if (parts.length) out.push(`[${id}]={${parts.join(",")}},`);
  }
  out.push("}");
  fs.writeFileSync(DATA_LUA_PATH, out.join("\r\n") + "\r\n");
}

// ---------------------------------------------------------------------------
async function main() {
  if (!SBERNA_URL || !SBERNA_ADMIN_KEY) throw new Error("Chybí SBERNA_URL nebo SBERNA_ADMIN_KEY");
  const auth = { Authorization: `Bearer ${SBERNA_ADMIN_KEY}` };

  const r = await fetch(`${SBERNA_URL}/confirmed`, { headers: auth });
  if (!r.ok) throw new Error("Sběrna HTTP " + r.status);
  const items = (await r.json()).items || [];
  console.log(`Potvrzených textů ze sběrny: ${items.length}`);
  if (!items.length) return;

  // Pro každé pole questu vezmi text s nejvíc hlášeními (nebo od důvěryhodného hráče)
  const best = {};
  for (const it of items) {
    const key = `${it.quest_id}|${it.field}`;
    const score = it.reporters + (it.trusted ? 1000 : 0);
    if (!best[key] || score > best[key].score) best[key] = { ...it, score };
  }

  const cache = JSON.parse(fs.readFileSync(CACHE_PATH, "utf8"));
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

  if (DRY_RUN) {
    console.log("DRY_RUN – nic se nezapisuje. Ukázka:", JSON.stringify(translated).slice(0, 500));
    return;
  }
  writeCache(cache);
  writeDataLua(cache);

  // Potvrdit sběrně všechno zpracované (i to, co už přeložené bylo)
  const ack = items.map((it) => ({ quest_id: it.quest_id, field: it.field, en_hash: it.en_hash }));
  const a = await fetch(`${SBERNA_URL}/ack`, {
    method: "POST",
    headers: { ...auth, "content-type": "application/json" },
    body: JSON.stringify(ack),
  });
  if (!a.ok) throw new Error("Potvrzení ve sběrně selhalo: HTTP " + a.status);
  console.log(`Hotovo: přeloženo ${Object.keys(translated).length} questů, potvrzeno ${ack.length} textů.`);
}

main().catch((e) => {
  console.error(e);
  process.exit(1);
});

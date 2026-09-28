// Překlad textů (Google zdarma nebo Claude) + automatické úpravy z pravidla.json.
// Používá zpracuj.js (GitHub) i nacti-cache.js (správce).
const fs = require("fs");
const path = require("path");
const { apply: applyRules } = require("./pravidla");

const ROOT = path.join(__dirname, "..");
const GLOSSARY_PATH = path.join(ROOT, "slovnicek.txt");
const { ANTHROPIC_API_KEY } = process.env;
const PREKLADAC = process.env.PREKLADAC || "google";
const sleep = (ms) => new Promise((r) => setTimeout(r, ms));

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


module.exports = { translateAll, PREKLADAC };

// Přeloží questy z mezipaměti hry, které v databázi chybí (spouští správce, třeba po /czq sber).
//   node tools/nacti-cache.js [cesta k questcache.wdb] [--zapsat]
// Bez --zapsat jen ukáže, co by udělal. Výchozí cesta: D:\World of Warcraft\_classic_beta_\...
//
// Co dělá:
//  - quest chybí v databázi              -> přeloží název, úkol, zadání
//  - quest je v databázi, ale bez zadání   -> doplní chybějící části
//  - klasický quest (pre) má ve Forever jiný text -> přeloží znovu podle Forever
// Ručně opravené a komunitní questy nemění (změny u nich řeší sběrna se schvalováním).
const path = require("path");
const { readQuestCache } = require("./wdb");
const { readCache, writeCache, writeDataLua } = require("./soubory");
const { translateAll } = require("./preklad");

const args = process.argv.slice(2);
const write = args.includes("--zapsat");
const file = args.find((a) => !a.startsWith("--")) || "D:/World of Warcraft/_classic_beta_/Cache/WDB/enUS/questcache.wdb";
const simple = (s) => (s || "").toLowerCase().replace(/[\s\p{P}]/gu, "");
const FIELDS = ["title", "objectives", "text"];

(async () => {
  const cacheQuests = readQuestCache(file);
  const db = readCache();
  const todo = {};
  let nove = 0, doplnene = 0, zmenene = 0;
  for (const [id, q] of Object.entries(cacheQuests)) {
    const e = db[id];
    const fields = {};
    for (const f of FIELDS) {
      if (!q[f]) continue;
      if (!e || !e[f]) fields[f] = q[f];                                      // chybí
      else if (e.pre === "1" && simple(e["en_" + f]) !== simple(q[f])) fields[f] = q[f]; // Forever změnil klasický quest
    }
    if (!Object.keys(fields).length) continue;
    todo[id] = fields;
    if (!e) nove++; else if (e.pre === "1" && Object.keys(fields).some((f) => e[f])) zmenene++; else doplnene++;
  }
  console.log(`Questů v mezipaměti: ${Object.keys(cacheQuests).length}`);
  console.log(`K překladu: ${Object.keys(todo).length} (nové ${nove}, doplnit ${doplnene}, změněné ve Forever ${zmenene})`);
  for (const [id, f] of Object.entries(todo).slice(0, 5)) console.log(`  #${id} ${f.title || db[id]?.en_title || ""}`);
  if (!write || !Object.keys(todo).length) {
    if (!write) console.log("(jen náhled – pro zápis spusť s --zapsat)");
    return;
  }

  // Po dávkách, ať jde průběh vidět a výsledek se průběžně ukládá
  const ids = Object.keys(todo);
  for (let i = 0; i < ids.length; i += 100) {
    const chunk = Object.fromEntries(ids.slice(i, i + 100).map((id) => [id, todo[id]]));
    const tr = await translateAll(chunk);
    for (const [id, fields] of Object.entries(tr)) {
      const e = (db[id] = db[id] || {});
      for (const [k, v] of Object.entries(fields)) {
        e[k] = v;
        e["en_" + k] = chunk[id][k];
      }
      if (!e.src) e.src = "cache";
      if (e.pre === "1" && FIELDS.every((f) => !cacheQuests[id][f] || simple(e["en_" + f]) === simple(cacheQuests[id][f]))) delete e.pre;
    }
    writeCache(db);
    writeDataLua(db);
    console.log(`  přeloženo ${Math.min(i + 100, ids.length)}/${ids.length}`);
  }
  console.log("Hotovo – zapsáno do preklady.json a Data.lua.");
})().catch((e) => { console.error(e); process.exit(1); });

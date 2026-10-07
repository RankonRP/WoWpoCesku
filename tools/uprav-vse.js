// Jednorázově projde celou databázi a použije pravidla.json na všechny strojové překlady.
// Ručně opravené questy (src = "oprava") nechá být.
//   node tools/uprav-vse.js          -> jen ukáže, co by změnil
//   node tools/uprav-vse.js --zapsat -> změny uloží do preklady.json + Data.lua
const fs = require("fs");
const path = require("path");
const { apply } = require("./pravidla");

const ROOT = path.join(__dirname, "..");
const CACHE_PATH = path.join(ROOT, "data", "preklady.json");
const FIELDS = ["title", "text", "objectives", "progress", "reward"];
const write = process.argv.includes("--zapsat");

const cache = JSON.parse(fs.readFileSync(CACHE_PATH, "utf8").replace(/^﻿/, ""));
let quests = 0, fields = 0;
const examples = [];
for (const [id, e] of Object.entries(cache)) {
  if (e.src === "oprava") continue;
  let touched = false;
  for (const f of FIELDS) {
    if (!e[f]) continue;
    const t = apply(e[f]);
    if (t !== e[f]) {
      if (examples.length < 8) examples.push(`#${id} ${f}:\n   ${e[f].slice(0, 110)}\n → ${t.slice(0, 110)}`);
      e[f] = t;
      fields++;
      touched = true;
    }
  }
  if (touched) quests++;
}
console.log(`Upraveno: ${quests} questů, ${fields} polí`);
console.log(examples.join("\n"));

// rozhovory s NPC: stejná pravidla (ručně opravené, src = "oprava", se nemění)
const S = require("./soubory");
const gossip = S.readGossip();
let talks = 0;
const talkExamples = [];
for (const e of Object.values(gossip)) {
  if (e.src === "oprava" || !e.cs) continue;
  const t = apply(e.cs);
  if (t !== e.cs) {
    if (talkExamples.length < 8) talkExamples.push(`   ${e.cs.slice(0, 110)}\n → ${t.slice(0, 110)}`);
    e.cs = t;
    talks++;
  }
}
console.log(`Upraveno: ${talks} rozhovorů`);
console.log(talkExamples.join("\n"));

if (write) {
  S.writeCache(cache);
  S.writeDataLua(cache);
  S.writeGossip(gossip);
  S.writeGossipLua(gossip);
  console.log("Zapsáno do preklady.json, Data.lua, rozhovory.json a DataRozhovory.lua.");
}

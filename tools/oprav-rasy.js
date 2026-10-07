// Jednorázová oprava záměn ras ve strojovém překladu: Google překládá goblin, gnome i ogre podobně jako orc / dwarf.
// Podle anglického originálu (en_*) vrátí správnou rasu, ale jen tam, kde se v originálu druhá rasa nevyskytuje.
//   node tools/oprav-rasy.js          -> jen ukáže, co by změnil
//   node tools/oprav-rasy.js --zapsat -> změny uloží do preklady.json, rozhovory.json a Data*.lua
// Ručně opravené záznamy (src = "oprava") se nemění.
const S = require("./soubory");
const write = process.argv.includes("--zapsat");

// [anglický originál musí obsahovat, nesmí obsahovat], náhrady: koncovka tvaru -> nový tvar (velikost písmen se zachová)
const SADY = [
  {
    nazev: "goblin (ne ork)",
    ma: /goblin/i,
    nema: /\borcs?\b|grunt|peon|warchief|horde|orcish/i,
    kmeny: [
      [/(?<!\p{L})ork(ovi|em|ové|ů|ům|y|a|u|ech)?(?!\p{L})/giu, (m, k) => "goblin" + ({ ovi: "ovi", em: "em", ové: "ové", ů: "ů", ům: "ům", y: "y", a: "a", u: "u", ech: "ech" }[k] || "")],
      [/(?<!\p{L})orčí(ho|mu|m|ch|mi)?(?!\p{L})/giu, (m, k) => "goblinsk" + ({ ho: "ého", mu: "ému", m: "ém", ch: "ých", mi: "ými" }[k] || "é")],
    ],
  },
  {
    nazev: "gnome (ne trpaslík)",
    ma: /(?<![a-z])gnome/i,
    nema: /dwarf|dwarves|dwarven/i,
    kmeny: [
      [/(?<!\p{L})trpaslík(ovi|em|ové|ů|ům|y|a|u|ech)?(?!\p{L})/giu, (m, k) => "gnóm" + ({ ovi: "ovi", em: "em", ové: "ové", ů: "ů", ům: "ům", y: "y", a: "a", u: "u", ech: "ech" }[k] || "")],
      [/(?<!\p{L})trpaslíci(?!\p{L})/giu, () => "gnómové"],
      [/(?<!\p{L})trpasličí(?!\p{L})/giu, () => "gnómí"],
    ],
  },
  {
    nazev: "ogre (ne lichožrout)",
    ma: /ogre/i,
    nema: /$^/,
    kmeny: [
      [/(?<!\p{L})lichožrout(i|ů|ům|y|a|em|ech)?(?!\p{L})/giu, (m, k) => (k === "i" ? "ogři" : k === "ech" ? "ozích" : "ogr" + (k || ""))],
    ],
  },
];

const zachovejVelikost = (puvodni, novy) =>
  puvodni.charAt(0) === puvodni.charAt(0).toUpperCase() && puvodni.charAt(0) !== puvodni.charAt(0).toLowerCase()
    ? novy.charAt(0).toUpperCase() + novy.slice(1) : novy;

function oprav(en, cs) {
  let t = cs;
  for (const sada of SADY) {
    if (!sada.ma.test(en) || sada.nema.test(en)) continue;
    for (const [re, fn] of sada.kmeny) t = t.replace(re, (m, k) => zachovejVelikost(m, fn(m, k)));
  }
  return t;
}

const FIELDS = ["title", "text", "objectives", "progress", "reward"];
const cache = S.readCache ? S.readCache() : JSON.parse(require("fs").readFileSync(require("path").join(__dirname, "..", "data", "preklady.json"), "utf8").replace(/^﻿/, ""));
const gossip = S.readGossip();
let polí = 0;
const priklady = [];
for (const [id, e] of Object.entries(cache)) {
  if (e.src === "oprava") continue;
  for (const f of FIELDS) {
    if (!e[f] || !e["en_" + f]) continue;
    const t = oprav(e["en_" + f], e[f]);
    if (t !== e[f]) {
      if (priklady.length < 10) priklady.push(`#${id} ${f}: ${e[f].slice(0, 80).replace(/\n/g, " ")}\n   -> ${t.slice(0, 80).replace(/\n/g, " ")}`);
      e[f] = t;
      polí++;
    }
  }
}
let rozhovorů = 0;
for (const e of Object.values(gossip)) {
  if (e.src === "oprava" || !e.cs || !e.en) continue;
  const t = oprav(e.en, e.cs);
  if (t !== e.cs) { e.cs = t; rozhovorů++; }
}
console.log(`Opraveno: ${polí} polí questů, ${rozhovorů} rozhovorů`);
console.log(priklady.join("\n"));
if (write) {
  S.writeCache(cache);
  S.writeDataLua(cache);
  S.writeGossip(gossip);
  S.writeGossipLua(gossip);
  console.log("Zapsáno.");
}

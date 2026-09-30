// Ruční kvalitní překlad (Claude) jen toho, na co správce ve hře narazil.
//   node tools/claude-preklad.js seznam [max]     -> vypíše viděné questy / rozhovory / texty rozhraní,
//                                                   které ještě nemají ruční překlad (src claude/oprava)
//   node tools/claude-preklad.js pouzij <soubor>  -> zapíše překlady do databází (src = "claude")
//
// Viděné věci addon ukládá do WoWpoCeskuSeen v SavedVariables:
//   <hra>\WTF\Account\<účet>\SavedVariables\WoWpoCesku.lua  (složka hry z nastaveni.json -> slozka_hry)
//
// Soubor s překlady: { "questy": { "<id>": { "title": "…", "text": "…", … } },
//                      "rozhovory": { "<anglický text>": "…" }, "rozhrani": { "<šablona>": "…" } }
// (starší tvar = rovnou { "<id>": {…} } je taky v pořádku)
const fs = require("fs");
const path = require("path");
const S = require("./soubory");

const ROOT = path.join(__dirname, "..");
const DONE = new Set(["claude", "oprava"]);
const FIELDS = ["title", "objectives", "text", "progress", "reward"];

function savedVariablesFiles() {
  const settings = JSON.parse(fs.readFileSync(path.join(ROOT, "nastaveni.json"), "utf8").replace(/^\uFEFF/, ""));
  const game = settings.slozka_hry || "D:/World of Warcraft/_classic_beta_";
  const accounts = path.join(game, "WTF", "Account");
  if (!fs.existsSync(accounts)) return [];
  return fs.readdirSync(accounts)
    .map((a) => path.join(accounts, a, "SavedVariables", "WoWpoCesku.lua"))
    .filter((f) => fs.existsSync(f));
}

// Z Lua souboru vytáhne tabulku WoWpoCeskuSeen = { ["q"] = { [123] = …, }, ["g"] = { ["text"] = …, }, … }
function readSeen() {
  const seen = { q: new Set(), g: new Set(), u: new Set() };
  const unescape = (s) => s.replace(/\\(n|"|\\)/g, (_, c) => (c === "n" ? "\n" : c));
  for (const file of savedVariablesFiles()) {
    const text = fs.readFileSync(file, "utf8");
    const block = text.match(/^WoWpoCeskuSeen\s*=\s*\{([\s\S]*?)^\}\s*$/m);
    if (!block) continue;
    // WoW zapisuje vnořené tabulky odsazené tabulátorem: \t["q"] = { … \n\t},
    for (const m of block[1].matchAll(/\["(q|g|u)"\]\s*=\s*\{([\s\S]*?)\n\s*\},?/g)) {
      const [, kind, body] = m;
      if (kind === "q") for (const k of body.matchAll(/\[(\d+)\]\s*=/g)) seen.q.add(k[1]);
      else for (const k of body.matchAll(/\["((?:[^"\\]|\\.)*)"\]\s*=/g)) seen[kind].add(unescape(k[1]));
    }
  }
  return seen;
}

function seznam(max) {
  const seen = readSeen();
  const db = S.readCache(), gossip = S.readGossip(), ui = S.readUi();
  const out = { questy: {}, rozhovory: {}, rozhrani: {} };
  for (const id of seen.q) {
    const e = db[id];
    if (!e || DONE.has(e.src)) continue;
    out.questy[id] = {};
    for (const f of FIELDS) if (e["en_" + f]) out.questy[id][f] = e["en_" + f];
    if (Object.keys(out.questy).length >= max) break;
  }
  for (const k of seen.g) { const key = S.gossipKey(k); if (gossip[key] && !DONE.has(gossip[key].src)) out.rozhovory[key] = gossip[key].en || key; }
  for (const k of seen.u) { if (ui[k] && !DONE.has(ui[k].src)) out.rozhrani[k] = k; }
  console.log(JSON.stringify(out, null, 1));
  console.error(`viděno: questů ${seen.q.size}, rozhovorů ${seen.g.size}, textů rozhraní ${seen.u.size} | k překladu: ` +
    `${Object.keys(out.questy).length} / ${Object.keys(out.rozhovory).length} / ${Object.keys(out.rozhrani).length}`);
}

function pouzij(file) {
  let data = JSON.parse(fs.readFileSync(file, "utf8").replace(/^\uFEFF/, ""));
  if (!data.questy && !data.rozhovory && !data.rozhrani) data = { questy: data };
  const db = S.readCache(), gossip = S.readGossip(), ui = S.readUi();
  let q = 0, g = 0, u = 0;
  for (const [id, fields] of Object.entries(data.questy || {})) {
    const e = db[id];
    if (!e) { console.error(`quest ${id} není v databázi – přeskakuji`); continue; }
    for (const [k, v] of Object.entries(fields)) if (e["en_" + k]) e[k] = v;
    delete e.pre;
    e.src = "claude";
    q++;
  }
  for (const [key, cs] of Object.entries(data.rozhovory || {})) {
    const k = S.gossipKey(key);
    gossip[k] = { ...(gossip[k] || { en: key }), cs, src: "claude" };
    g++;
  }
  for (const [key, cs] of Object.entries(data.rozhrani || {})) {
    ui[key] = { ...(ui[key] || { en: key }), cs, src: "claude" };
    u++;
  }
  if (q) { S.writeCache(db); S.writeDataLua(db); }
  if (g) { S.writeGossip(gossip); S.writeGossipLua(gossip); }
  if (u) { S.writeUi(ui); S.writeUiLua(ui); }
  console.log(`zapsáno: questů ${q}, rozhovorů ${g}, textů rozhraní ${u}`);
}

const [cmd, arg] = process.argv.slice(2);
if (cmd === "seznam") seznam(Number(arg) || 20);
else if (cmd === "pouzij" && arg) pouzij(arg);
else console.log("Použití: node tools/claude-preklad.js seznam [max] | pouzij <soubor.json>");

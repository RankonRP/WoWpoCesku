// Ruční kvalitní překlad (Claude) jen toho, na co správce ve hře narazil.
//   node tools/claude-preklad.js seznam [max]     -> vypíše viděné questy / rozhovory / texty rozhraní,
//                                                   které ještě nemají ruční překlad (src claude/oprava)
//   node tools/claude-preklad.js pouzij <soubor>  -> zapíše překlady do databází (src = "claude")
//   node tools/claude-preklad.js oznacene         -> co hráč ve hře označil tlačítkem "Nelíbí se mi" (originál + dosavadní překlad)
//   node tools/claude-preklad.js oznacene-hotovo  -> označené, které už jsou přeložené, příště nevypisovat
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
  const settings = JSON.parse(fs.readFileSync(path.join(ROOT, "nastaveni", "nastaveni.json"), "utf8").replace(/^\uFEFF/, ""));
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
  const unescape = (s) => s.replace(/\\(n|r|t|"|\\)/g, (_, c) => (c === "n" ? "\n" : c === "r" ? "\r" : c === "t" ? "\t" : c));
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

// Označení z tlačítka "Nelíbí se mi – poslat Claudovi": WoWpoCeskuSeen.flag["q:<id>" | "g:<anglický text>"] = { t, part, title }
const DONE_FLAGS = path.join(ROOT, "nastaveni", "stav", ".oznacene-hotovo.json");
function readFlags() {
  const unescape = (s) => s.replace(/\\(n|r|t|"|\\)/g, (_, c) => (c === "n" ? "\n" : c === "r" ? "\r" : c === "t" ? "\t" : c));
  const flags = {};
  for (const file of savedVariablesFiles()) {
    const text = fs.readFileSync(file, "utf8");
    const block = text.match(/^WoWpoCeskuSeen\s*=\s*\{([\s\S]*?)^\}\s*$/m);
    if (!block) continue;
    const fl = tableBody(block[1], "flag");
    if (fl === null) continue;
    for (const m of fl.matchAll(/\["((?:[^"\\]|\\.)*)"\]\s*=\s*\{([^}]*)\}/g)) {
      const body = m[2];
      const t = Number((body.match(/\["t"\]\s*=\s*(\d+)/) || [])[1] || 0);
      const part = (body.match(/\["part"\]\s*=\s*"([^"]*)"/) || [])[1] || "";
      flags[unescape(m[1])] = { t, part };
    }
  }
  return flags;
}
function tableBody(text, key) {
  const m = text.match(new RegExp('\\["' + key + '"\\]\\s*=\\s*\\{'));
  if (!m) return null;
  let i = m.index + m[0].length, depth = 1, inStr = false;
  const start = i;
  for (; i < text.length; i++) {
    const c = text[i];
    if (inStr) { if (c === "\\") i++; else if (c === '"') inStr = false; continue; }
    if (c === '"') inStr = true;
    else if (c === "{") depth++;
    else if (c === "}" && --depth === 0) return text.slice(start, i);
  }
  return null;
}
const readDoneFlags = () => { try { return JSON.parse(fs.readFileSync(DONE_FLAGS, "utf8")); } catch { return {}; } };

function oznacene(markDone) {
  const flags = readFlags(), done = readDoneFlags();
  const db = S.readCache(), gossip = S.readGossip();
  const out = { questy: {}, rozhovory: {} };
  let pending = 0;
  for (const [key, f] of Object.entries(flags)) {
    if ((done[key] || 0) >= f.t) continue;
    pending++;
    if (markDone) { done[key] = f.t; continue; }
    if (key.startsWith("q:")) {
      const id = key.slice(2), e = db[id];
      if (!e) { console.error("quest " + id + " není v místní databázi"); continue; }
      out.questy[id] = { oznacena_cast: f.part || "(neuvedeno)", original: {}, dosavadni_preklad: {} };
      for (const fld of FIELDS) {
        if (e["en_" + fld]) out.questy[id].original[fld] = e["en_" + fld];
        if (e[fld]) out.questy[id].dosavadni_preklad[fld] = e[fld];
      }
    } else if (key.startsWith("g:")) {
      const k = S.gossipKey(key.slice(2)), g = gossip[k];
      out.rozhovory[k] = { dosavadni_preklad: g ? g.cs : null, zdroj: g ? g.src : null };
    }
  }
  if (markDone) { fs.mkdirSync(path.dirname(DONE_FLAGS), { recursive: true }); fs.writeFileSync(DONE_FLAGS, JSON.stringify(done)); console.log("označeno jako hotové: " + pending); return; }
  console.log(JSON.stringify(out, null, 1));
  console.error("označeno hráčem: " + Object.keys(flags).length + " | k přeložení: " + pending +
    " (questů " + Object.keys(out.questy).length + ", rozhovorů " + Object.keys(out.rozhovory).length + ")");
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
else if (cmd === "oznacene") oznacene(false);
else if (cmd === "oznacene-hotovo") oznacene(true);
else console.log("Použití: node tools/claude-preklad.js seznam [max] | pouzij <soubor.json> | oznacene | oznacene-hotovo");

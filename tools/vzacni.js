// Vytáhne z CMaNGOS classic-db, kde se objevují vzácní mobové z Kroniky (DataKronika.lua),
// a zapíše WoWpoCesku/DataVzacni.lua se světovými souřadnicemi (na mapu je převede addon přes C_Map).
//   node tools/vzacni.js <cesta k ClassicDB.sql>
// Spawny: creature.id, creature_spawn_entry (guid -> entry) a spawn skupiny (spawn_group_entry + spawn_group_spawn).
const fs = require("fs");
const path = require("path");

const sqlPath = process.argv[2];
if (!sqlPath) { console.error("použití: node tools/vzacni.js <ClassicDB.sql>"); process.exit(1); }
const sql = fs.readFileSync(sqlPath, "utf8");

function columns(table) {
  const m = sql.match(new RegExp("CREATE TABLE `" + table + "` \\(([\\s\\S]*?)\\n\\)"));
  if (!m) throw new Error("tabulka " + table + " nenalezena");
  const cols = {};
  let i = 0;
  for (const line of m[1].split("\n")) {
    const c = line.match(/^\s*`([^`]+)`/);
    if (c) { if (!(c[1] in cols)) cols[c[1]] = i; i++; }
  }
  return cols;
}
function parseTuples(s, out) {
  let i = s.indexOf("VALUES") + 6, row = null, val = "", inStr = false, isStr = false;
  for (; i < s.length; i++) {
    const c = s[i];
    if (inStr) {
      if (c === "\\") { const n = s[++i]; val += n === "n" ? "\n" : n === "r" ? "\r" : n === "t" ? "\t" : n; }
      else if (c === "'") { if (s[i + 1] === "'") { val += "'"; i++; } else inStr = false; }
      else val += c;
    } else if (c === "(" && !row) { row = []; val = ""; isStr = false; }
    else if (c === "'") { inStr = true; isStr = true; }
    else if (row && (c === "," || c === ")")) {
      row.push(isStr ? val : (val.trim() === "NULL" ? "" : val.trim())); val = ""; isStr = false;
      if (c === ")") { out.push(row); row = null; }
    } else if (row) val += c;
  }
}
function rows(table) {
  const out = [];
  const prefix = "INSERT INTO `" + table + "` VALUES";
  let pos = 0;
  while ((pos = sql.indexOf(prefix, pos)) !== -1) {
    const end = sql.indexOf(";\n", pos);
    parseTuples(sql.slice(pos, end + 1), out);
    pos = end;
  }
  const cols = columns(table);
  return out.map((r) => new Proxy(r, { get: (t, k) => (k in cols ? t[cols[k]] : t[k]) }));
}
const num = (v) => Number(v) || 0;

// jména vzácných z DataKronika.lua
const kron = fs.readFileSync(path.join(__dirname, "..", "WoWpoCesku", "DataKronika.lua"), "utf8");
const listPart = kron.slice(kron.indexOf("WoWpoCesku_RareList"), kron.indexOf("WoWpoCesku_Objevy"));
const wanted = new Set();
for (const m of listPart.matchAll(/"([^"|]+)\|/g)) wanted.add(m[1]);
console.log("vzácných v kronice:", wanted.size);

const entries = {};   // entry -> jméno
for (const r of rows("creature_template")) if (wanted.has(r.Name)) entries[r.Entry] = r.Name;

const guidsOf = {};   // jméno -> Set(guid)
const add = (name, guid) => (guidsOf[name] = guidsOf[name] || new Set()).add(String(guid));
const pos = {};       // guid -> {map, x, y}
for (const r of rows("creature")) {
  pos[r.guid] = { map: num(r.map), x: num(r.position_x), y: num(r.position_y) };
  if (entries[r.id]) add(entries[r.id], r.guid);
}
for (const r of rows("creature_spawn_entry")) if (entries[r.entry]) add(entries[r.entry], r.guid);
const groupNames = {};
for (const r of rows("spawn_group_entry")) {
  if (entries[r.Entry]) (groupNames[r.Id] = groupNames[r.Id] || new Set()).add(entries[r.Entry]);
}
for (const r of rows("spawn_group_spawn")) {
  for (const name of groupNames[r.Id] || []) add(name, r.Guid);
}

// body: jen venkovní svět, sloučit blízké (40 yardů), nejvýš 12
const out = {};
let found = 0;
for (const name of [...wanted].sort()) {
  const pts = [], seen = new Set();
  for (const g of guidsOf[name] || []) {
    const p = pos[g];
    if (!p || (p.map !== 0 && p.map !== 1)) continue;
    const key = p.map + ":" + Math.round(p.x / 40) + ":" + Math.round(p.y / 40);
    if (seen.has(key)) continue;
    seen.add(key);
    pts.push(p);
  }
  if (!pts.length) continue;
  const step = Math.max(1, Math.ceil(pts.length / 12));
  const flat = [];
  for (let i = 0; i < pts.length; i += step) flat.push(pts[i].map, Math.round(pts[i].x), Math.round(pts[i].y));
  out[name] = flat;
  found++;
}
const missing = [...wanted].filter((n) => !out[n]);
console.log("se souřadnicemi:", found, "bez nich:", missing.length, missing.join(", "));

const esc = (s) => s.replace(/\\/g, "\\\\").replace(/"/g, '\\"');
let lua = "© 2026 RankonRP a přispěvatelé. Překlady a texty nelze kopírovat do jiných addonů ani projektů bez povolení – viz docs/LICENSE-DATA.md\n-- WoWpoCesku: kde se objevují vzácní mobové (CMaNGOS classic-db, světové souřadnice: kontinent, x, y, …)\n"
  + "-- Vytvořeno nástrojem tools/vzacni.js – needitovat ručně.\nWoWpoCesku_RareSpawns = {\n";
for (const [name, flat] of Object.entries(out)) lua += `    ["${esc(name)}"] = { ${flat.join(", ")} },\n`;
lua += "}\n";
fs.writeFileSync(path.join(__dirname, "..", "WoWpoCesku", "DataVzacni.lua"), lua);
console.log("zapsáno WoWpoCesku/DataVzacni.lua");

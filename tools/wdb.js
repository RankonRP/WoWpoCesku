// Čtení mezipaměti questů WoW (Cache\WDB\enUS\questcache.wdb): název, úkol, zadání.
// (Stejnou logiku má pomocnik.ps1 – Read-QuestCache.)
//
// Záznam: id (uint32), délka (uint32), data. V datech jsou délky řetězců zabalené v bitech
// 9,12,12,9,10,8,10,8,11 (LogTitle, LogDescription, QuestDescription, AreaDescription,
// PortraitGiverText, PortraitGiverName, PortraitTurnInText, PortraitTurnInName,
// QuestCompletionLog) a hned za nimi řetězce za sebou bez oddělovačů.
const fs = require("fs");

const BITS = [9, 12, 12, 9, 10, 8, 10, 8, 11];

function readBits(buf, byteOff, widths) {
  let bit = 0;
  const out = [];
  for (const w of widths) {
    let v = 0;
    for (let i = 0; i < w; i++, bit++) {
      const byte = buf[byteOff + (bit >> 3)];
      if (byte === undefined) return null;
      v = (v << 1) | ((byte >> (7 - (bit & 7))) & 1);
    }
    out.push(v);
  }
  return out;
}

const printable = (s) => s.length > 0 && !/[\x00-\x08\x0e-\x1f�]/.test(s);

// Pozice bitového bloku není pevná -> najít první, která dává čitelné řetězce
function parseRecord(d) {
  for (let p = 0; p + 12 < d.length; p++) {
    const L = readBits(d, p, BITS);
    if (!L || L[0] < 2 || L[0] > 300) continue;
    const start = p + 12;
    if (start + L.reduce((a, b) => a + b, 0) > d.length) continue;
    const strs = [];
    let o = start, ok = true;
    for (const n of L) {
      const s = d.slice(o, o + n).toString("utf8");
      if (n > 0 && !printable(s)) { ok = false; break; }
      strs.push(s);
      o += n;
    }
    if (!ok || !/^[A-Za-z0-9"'(\[]/.test(strs[0])) continue;
    return { title: strs[0], objectives: strs[1], text: strs[2] };
  }
  return null;
}

// Zástupné znaky serveru -> naše značky (stejně jako u klasické databáze)
function normalize(t) {
  return (t || "")
    .replace(/\r\n?/g, "\n")
    .replace(/\$[Bb]/g, "\n")
    .replace(/\$[Nn]/g, "{N}")
    .replace(/\$[Cc]/g, "{C}")
    .replace(/\$[Rr]/g, "{R}")
    .replace(/\$[Gg]\s*([^:;]*):([^;]*);/g, "$1/$2")
    // $1oa = počet z úkolu (hra ho dosadí sama, z mezipaměti ho nezjistíme) -> vynechat
    .replace(/\$\d+o[a-z]*\s?/g, "")
    .trim();
}

function readQuestCache(file) {
  const b = fs.readFileSync(file);
  if (b.slice(0, 4).toString("latin1") !== "TSQW") throw new Error("Není to questcache.wdb: " + file);
  const quests = {};
  let o = 24;
  while (o + 8 <= b.length) {
    const id = b.readUInt32LE(o);
    const len = b.readUInt32LE(o + 4);
    if (!len || o + 8 + len > b.length) break;
    const q = parseRecord(b.slice(o + 8, o + 8 + len));
    if (q) quests[id] = { title: normalize(q.title), objectives: normalize(q.objectives), text: normalize(q.text) };
    o += 8 + len;
  }
  return quests;
}

module.exports = { readQuestCache, normalize };

// Textura kamenného rámu Dungeon Kroniky: podklady/cech/dungeonram.png -> WoWpoCesku/Textures/dungeon-ram.tga (1024×1024, 6bit barvy).
// Rám se skládá z kusů (rohy, okraje, ozdoby uprostřed); pravá strana se ve hře zrcadlí, prázdná místa jsou průhledná (v zipu zabírají málo).
// Poloha kusů v atlasu se zapisuje i do Lua (KronikaCechu.lua: DUNGEON_PIECES) – po změně tohoto souboru je tam potřeba přepsat čísla.
// Spuštění: node tools/dungeon-ram-textura.js
const path = require("path");
const I = require("./cech-obraz.js");
const { matte } = require("./dungeon-ram-matte.js");
const src = I.decodePNG(path.join(__dirname, "..", "podklady", "cech", "dungeonram.png"));
// kus: jméno, [x, y, šířka, výška] ve zdroji, [x, y] v atlasu
const PIECES = [
  ["tl",    [14, 30, 136, 120],  [0, 0]],
  ["bl",    [14, 855, 136, 145], [0, 130]],
  ["left",  [27, 150, 45, 710],  [150, 0]],
  ["top_l", [150, 44, 462, 46],  [210, 0]],
  ["top_c", [612, 10, 328, 120], [210, 60]],
  ["bot_l", [150, 936, 585, 46], [210, 190]],
  ["bot_c", [735, 925, 70, 75],  [210, 250]],
];
const M = matte(src);   // 1 = rám, 0 = rozmazané okolí / černý střed
// měkká hrana: průměr z okolí 3×3
function alphaAt(x, y) { let s = 0; for (let j = -1; j <= 1; j++) for (let i = -1; i <= 1; i++) s += M[(y + j) * src.w + x + i]; return Math.round(255 * s / 9); }
const atlas = I.blank(1024, 1024);
for (const [name, [x, y, w, h], [ax, ay]] of PIECES) {
  for (let j = 0; j < h; j++) for (let i = 0; i < w; i++) {
    const s = ((y + j) * src.w + (x + i)) * 4, d = ((ay + j) * 1024 + (ax + i)) * 4;
    atlas.data[d] = src.data[s] & 0xFC; atlas.data[d + 1] = src.data[s + 1] & 0xFC; atlas.data[d + 2] = src.data[s + 2] & 0xFC; atlas.data[d + 3] = alphaAt(x + i, y + j);
  }
  console.log(`  ${name}: { ${ax}, ${ay}, ${w}, ${h} }`);
}
I.writeTGA(path.join(__dirname, "..", "WoWpoCesku", "Textures", "dungeon-ram.tga"), atlas);
console.log("hotovo");

// Textura dřevěného rámu Cechovní kroniky: podklady/cech/cechram.png -> WoWpoCesku/Textures/cech-drevo.tga (1024×1024, 6bit barvy, okolí průhledné).
// Kusy: rohy se štítem, horní/dolní okraj, ozdoby uprostřed, levý okraj ve třech dílech (horní, prostřední natahovací, dolní); pravá strana se zrcadlí.
// Čísla kusů v atlasu jsou i v KronikaCechu.lua (GUILD_FRAME). Spuštění: node tools/cech-ram-textura.js
const path = require("path");
const I = require("./cech-obraz.js");
const { matte } = require("./dungeon-ram-matte.js");
const src = I.decodePNG(path.join(__dirname, "..", "podklady", "cech", "cechram.png"));
// jméno, [x, y, š, v] ve zdroji, [x, y] v atlasu
const PIECES = [
  ["tl",     [8, 16, 132, 129],    [0, 0]],
  ["bl",     [8, 850, 132, 140],   [0, 140]],
  ["top_l",  [140, 28, 540, 66],   [140, 0]],
  ["top_c",  [680, 8, 200, 117],   [140, 80]],
  ["bot_l",  [140, 902, 608, 68],  [140, 210]],
  ["bot_c",  [748, 890, 54, 86],   [140, 290]],
  ["left_t", [20, 145, 62, 105],   [350, 300]],
  ["left_m", [20, 260, 62, 170],   [420, 300]],
  ["left_b", [20, 740, 62, 110],   [490, 300]],
  ["left_p", [20, 432, 62, 52],    [560, 300]],
];
const M = matte(src);
function alphaAt(x, y) { let s = 0; for (let j = -1; j <= 1; j++) for (let i = -1; i <= 1; i++) s += M[(y + j) * src.w + x + i]; return Math.round(255 * s / 9); }
const atlas = I.blank(1024, 1024);
for (const [name, [x, y, w, h], [ax, ay]] of PIECES) {
  for (let j = 0; j < h; j++) for (let i = 0; i < w; i++) {
    const s = ((y + j) * src.w + (x + i)) * 4, d = ((ay + j) * 1024 + (ax + i)) * 4;
    atlas.data[d] = src.data[s] & 0xFC; atlas.data[d + 1] = src.data[s + 1] & 0xFC; atlas.data[d + 2] = src.data[s + 2] & 0xFC; atlas.data[d + 3] = alphaAt(x + i, y + j);
  }
}
I.writeTGA(path.join(__dirname, "..", "WoWpoCesku", "Textures", "cech-drevo.tga"), atlas);
// náhled kusů na pergamenové barvě
const prev = I.blank(1024, 400);
for (let i = 0; i < 1024 * 400; i++) { prev.data[i * 4] = 226; prev.data[i * 4 + 1] = 205; prev.data[i * 4 + 2] = 160; prev.data[i * 4 + 3] = 255; }
for (let y = 0; y < 400; y++) for (let x = 0; x < 1024; x++) { const a = atlas.data[(y * 1024 + x) * 4 + 3] / 255; for (let c = 0; c < 3; c++) prev.data[(y * 1024 + x) * 4 + c] = prev.data[(y * 1024 + x) * 4 + c] * (1 - a) + atlas.data[(y * 1024 + x) * 4 + c] * a; }
I.writePNG(path.join(__dirname, "..", "podklady", "dungeon-ram", "cech-kusy.png"), prev);
console.log("hotovo");

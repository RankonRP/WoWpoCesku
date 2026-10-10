// Připraví rám Dungeon Kroniky: podklady/cech/dungeonram.png -> podklady/dungeon-ram/ram.png
// (střed rámu se vyřízne do průhledna, aby bylo vidět pozadí okna; okolní rozmazané pozadí se ořízne).
const path = require("path");
const I = require("./cech-obraz.js");
const src = I.decodePNG(path.join(__dirname, "..", "podklady", "cech", "dungeonram.png"));
const W = src.w, H = src.h;
const OX0 = 160, OY0 = 238, OX1 = 1376, OY1 = 852, F = 4;   // otvor uvnitř rámu (v pixelech originálu)
for (let y = 0; y < H; y++) for (let x = 0; x < W; x++) {
  const dx = Math.min(x - OX0, OX1 - x), dy = Math.min(y - OY0, OY1 - y);
  const d = Math.min(dx, dy);
  if (d >= F) src.data[(y * W + x) * 4 + 3] = 0;
  else if (d > 0) src.data[(y * W + x) * 4 + 3] = Math.round(255 * (1 - d / F));
}
I.writePNGAlpha(path.join(__dirname, "..", "podklady", "dungeon-ram", "ram.png"), src);
console.log("hotovo", W, H);

// Ořízne obrázek otevřené knihy (podklady/cech/kniha.png) na knihu samotnou, zmenší a zprůhlední okolí zaoblenými rohy.
// Výstup: podklady/knihovna-kniha/kniha.png. Spuštění: node tools/kniha-orez.js
const path = require("path");
const I = require("./cech-obraz.js");
const src = I.decodePNG(path.join(__dirname, "..", "podklady", "cech", "kniha.png"));
const X0 = 10, Y0 = 8, X1 = 1526, Y1 = 1016;
let img = I.crop(src, X0, Y0, X1 - X0, Y1 - Y0);
const W = 1100, H = Math.round(img.h * W / img.w);
img = I.resize(img, W, H);
const R = 12;
for (let y = 0; y < H; y++) for (let x = 0; x < W; x++) {
  const dx = Math.max(R - x, x - (W - 1 - R), 0), dy = Math.max(R - y, y - (H - 1 - R), 0);
  const d = Math.sqrt(dx * dx + dy * dy);
  const a = d <= R - 1 ? 1 : d >= R ? 0 : R - d;
  img.data[(y * W + x) * 4 + 3] = Math.round(img.data[(y * W + x) * 4 + 3] * a);
}
I.writePNGAlpha(path.join(__dirname, "..", "podklady", "knihovna-kniha", "kniha.png"), img);
console.log("hotovo", W, H);

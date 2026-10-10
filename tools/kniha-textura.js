// Textura okna Knihovny (otevřená kniha): podklady/cech/kniha.png -> WoWpoCesku/Textures/knihovna-kniha.tga (1024×512).
// Oříznutí na knihu, zaoblené průhledné rohy a 6bitové barvy (zip pro CurseForge musí zůstat pod 10 MB).
// Obrázek je svisle zmáčknutý (poměr 3:2 -> 2:1), ve hře se roztáhne zpět na poměr okna.
// Spuštění: node tools/kniha-textura.js
const path = require("path");
const I = require("./cech-obraz.js");
const src = I.decodePNG(path.join(__dirname, "..", "podklady", "cech", "kniha.png"));
let img = I.crop(src, 10, 8, 1516, 1008);
img = I.resize(img, 1024, 512);
const W = 1024, H = 512, R = 9;
for (let y = 0; y < H; y++) for (let x = 0; x < W; x++) {
  const i = (y * W + x) * 4;
  const dx = Math.max(R - x, x - (W - 1 - R), 0), dy = Math.max(R - y, y - (H - 1 - R), 0);
  const d = Math.sqrt(dx * dx + dy * dy), a = d <= R - 1 ? 1 : d >= R ? 0 : R - d;
  img.data[i + 3] = Math.round(img.data[i + 3] * a);
  for (let c = 0; c < 3; c++) img.data[i + c] = (img.data[i + c] >> 2) << 2;
}
I.writeTGA(path.join(__dirname, "..", "WoWpoCesku", "Textures", "knihovna-kniha.tga"), img);
console.log("hotovo");

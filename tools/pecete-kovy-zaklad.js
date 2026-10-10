// Šedotónové základy pečetí pro přebarvení podle stupně (bronz / stříbro / zlato / platina) přímo ve hře:
// z WoWpoCesku/Textures/Pecete/<jméno>.tga vyrobí <jméno>-s.tga (jas roztažený na plný rozsah, průhlednost zůstane).
// Hra pak obrázek přebarví SetVertexColor (Kronika.lua: tintSeal), takže nejsou potřeba samostatné soubory pro každý stupeň.
// Spuštění: node tools/pecete-kovy-zaklad.js
const fs = require("fs"), path = require("path");
const I = require("./cech-obraz.js");
const DIR = path.join(__dirname, "..", "WoWpoCesku", "Textures", "Pecete");
const NAMES = ["lovec", "cestovatel", "objevitel", "hrdina", "dobyvatel", "ctenar", "uroven", "bohatstvi"];

function readTGA(file) {
  const b = fs.readFileSync(file);
  const w = b.readUInt16LE(12), h = b.readUInt16LE(14), bpp = b[16], top = (b[17] & 0x20) !== 0, off = 18 + b[0];
  const data = Buffer.alloc(w * h * 4);
  for (let y = 0; y < h; y++) for (let x = 0; x < w; x++) {
    const sy = top ? y : h - 1 - y, s = off + (sy * w + x) * (bpp / 8), d = (y * w + x) * 4;
    data[d] = b[s + 2]; data[d + 1] = b[s + 1]; data[d + 2] = b[s]; data[d + 3] = bpp === 32 ? b[s + 3] : 255;
  }
  return { w, h, data };
}

for (const n of NAMES) {
  const src = readTGA(path.join(DIR, n + ".tga"));
  const lum = (i) => 0.3 * src.data[i * 4] + 0.59 * src.data[i * 4 + 1] + 0.11 * src.data[i * 4 + 2];
  let lo = 255, hi = 0;
  for (let i = 0; i < src.w * src.h; i++) { if (src.data[i * 4 + 3] < 40) continue; const l = lum(i); if (l < lo) lo = l; if (l > hi) hi = l; }
  const img = I.blank(src.w, src.h);
  for (let i = 0; i < src.w * src.h; i++) {
    const t = Math.pow(Math.max(0, Math.min(1, (lum(i) - lo) / (hi - lo))), 0.8) * 255;
    img.data[i * 4] = t; img.data[i * 4 + 1] = t; img.data[i * 4 + 2] = t; img.data[i * 4 + 3] = src.data[i * 4 + 3];
  }
  I.writeTGA(path.join(DIR, n + "-s.tga"), img);
}
console.log("hotovo:", NAMES.length, "základů");

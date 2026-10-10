// Z pečeti „ctenar" (128×128 TGA) vyrobí čtyři kovové varianty pro pečetě za počet knih:
// bronz, stříbro, zlato, platina. Převod: jas obrázku se namapuje na přechod barev kovu, průhlednost zůstane.
// Výstup: WoWpoCesku/Textures/Pecete/knihy-1..4.tga a náhled podklady/pecete-knihy-nahled.png
// Spuštění: node tools/pecete-kniha-kovy.js
const fs = require("fs");
const path = require("path");
const I = require("./cech-obraz.js");

const SRC = path.join(__dirname, "..", "WoWpoCesku", "Textures", "Pecete", "ctenar.tga");
const DST = path.join(__dirname, "..", "WoWpoCesku", "Textures", "Pecete");

function readTGA(file) {
  const b = fs.readFileSync(file);
  const w = b.readUInt16LE(12), h = b.readUInt16LE(14), bpp = b[16], topDown = (b[17] & 0x20) !== 0;
  const off = 18 + b[0];
  const data = Buffer.alloc(w * h * 4);
  for (let y = 0; y < h; y++) {
    const sy = topDown ? y : h - 1 - y;
    for (let x = 0; x < w; x++) {
      const s = off + (sy * w + x) * (bpp / 8), d = (y * w + x) * 4;
      data[d] = b[s + 2]; data[d + 1] = b[s + 1]; data[d + 2] = b[s];
      data[d + 3] = bpp === 32 ? b[s + 3] : 255;
    }
  }
  return { w, h, data };
}

// přechody [stín, střed, světlo]
const METALS = [
  { name: "bronz",   ramp: [[34, 16, 6], [150, 90, 44], [240, 170, 105]] },
  { name: "stříbro", ramp: [[24, 28, 36], [150, 158, 170], [244, 247, 252]] },
  { name: "zlato",   ramp: [[40, 26, 4], [196, 150, 30], [255, 232, 130]] },
  { name: "platina", ramp: [[14, 24, 44], [96, 150, 214], [214, 240, 255]] },
];

function mix(a, b, t) { return [a[0] + (b[0] - a[0]) * t, a[1] + (b[1] - a[1]) * t, a[2] + (b[2] - a[2]) * t]; }
function ramp(r, t) { return t < 0.5 ? mix(r[0], r[1], t * 2) : mix(r[1], r[2], (t - 0.5) * 2); }

const src = readTGA(SRC);
// rozsah jasu pro roztažení kontrastu
let lo = 255, hi = 0;
for (let i = 0; i < src.w * src.h; i++) {
  if (src.data[i * 4 + 3] < 40) continue;
  const l = 0.3 * src.data[i * 4] + 0.59 * src.data[i * 4 + 1] + 0.11 * src.data[i * 4 + 2];
  if (l < lo) lo = l; if (l > hi) hi = l;
}
const out = [];
METALS.forEach((m, idx) => {
  const img = I.blank(src.w, src.h);
  for (let i = 0; i < src.w * src.h; i++) {
    const l = 0.3 * src.data[i * 4] + 0.59 * src.data[i * 4 + 1] + 0.11 * src.data[i * 4 + 2];
    const t = Math.max(0, Math.min(1, (l - lo) / (hi - lo)));
    const c = ramp(m.ramp, t);
    img.data[i * 4] = c[0]; img.data[i * 4 + 1] = c[1]; img.data[i * 4 + 2] = c[2]; img.data[i * 4 + 3] = src.data[i * 4 + 3];
  }
  I.writeTGA(path.join(DST, "knihy-" + (idx + 1) + ".tga"), img);
  out.push(img);
});

// náhled: čtyři vedle sebe na pergamenu
const W = src.w, prev = I.blank(W * 4 + 50, W + 20);
for (let i = 0; i < prev.w * prev.h; i++) { prev.data[i * 4] = 226; prev.data[i * 4 + 1] = 205; prev.data[i * 4 + 2] = 160; prev.data[i * 4 + 3] = 255; }
out.forEach((img, k) => {
  for (let y = 0; y < img.h; y++) for (let x = 0; x < img.w; x++) {
    const a = img.data[(y * img.w + x) * 4 + 3] / 255, d = ((y + 10) * prev.w + 10 + k * (W + 10) + x) * 4;
    for (let c = 0; c < 3; c++) prev.data[d + c] = prev.data[d + c] * (1 - a) + img.data[(y * img.w + x) * 4 + c] * a;
  }
});
const big = I.resize(prev, prev.w * 2, prev.h * 2);
const outDir = path.join(__dirname, "..", "podklady");
I.writePNG(path.join(outDir, "pecete-knihy-nahled.png"), big);
console.log("hotovo:", METALS.map(m => m.name).join(", "));

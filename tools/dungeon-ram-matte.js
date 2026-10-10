// Průhlednost rámu Dungeon Kroniky: z obrázku podklady/cech/dungeonram.png vyrobí masku (rám = viditelný, rozmazané okolí a černý střed = průhledné).
// Pozadí je hladké a rám plný detailu, proto se hledá podle lokálního kontrastu. Používá ho tools/dungeon-ram-textura.js.
const I = require("./cech-obraz.js");
function matte(src) {
  const W = src.w, H = src.h;
  const L = new Float32Array(W * H);
  for (let i = 0; i < W * H; i++) L[i] = 0.3 * src.data[i * 4] + 0.59 * src.data[i * 4 + 1] + 0.11 * src.data[i * 4 + 2];
  // lokální kontrast: největší rozdíl jasu v okolí 2 px
  let m = new Uint8Array(W * H);
  for (let y = 2; y < H - 2; y++) for (let x = 2; x < W - 2; x++) {
    const c = L[y * W + x];
    let d = 0;
    for (const [dx, dy] of [[2, 0], [-2, 0], [0, 2], [0, -2], [1, 1], [-1, -1], [1, -1], [-1, 1]]) d = Math.max(d, Math.abs(L[(y + dy) * W + x + dx] - c));
    m[y * W + x] = d > 7 ? 1 : 0;
  }
  const dilate = (a, r) => { const o = new Uint8Array(W * H); for (let y = 0; y < H; y++) for (let x = 0; x < W; x++) { if (!a[y * W + x]) continue;
    for (let j = -r; j <= r; j++) for (let i = -r; i <= r; i++) { const xx = x + i, yy = y + j; if (xx >= 0 && yy >= 0 && xx < W && yy < H) o[yy * W + xx] = 1; } } return o; };
  const erode = (a, r) => { const o = new Uint8Array(W * H); for (let y = r; y < H - r; y++) for (let x = r; x < W - r; x++) { let ok = 1;
    for (let j = -r; j <= r && ok; j++) for (let i = -r; i <= r; i++) if (!a[(y + j) * W + x + i]) { ok = 0; break; } o[y * W + x] = ok; } return o; };
  m = erode(dilate(m, 7), 7);   // zavření děr uvnitř rámu
  return m;
}
module.exports = { matte };
if (require.main === module) {
  const path = require("path");
  const src = I.decodePNG(path.join(__dirname, "..", "podklady", "cech", "dungeonram.png"));
  const m = matte(src);
  const out = I.blank(src.w, src.h);
  for (let i = 0; i < src.w * src.h; i++) {
    for (let c = 0; c < 3; c++) out.data[i * 4 + c] = m[i] ? src.data[i * 4 + c] : (c === 0 ? 255 : 0);
    out.data[i * 4 + 3] = 255;
  }
  I.writePNG(path.join(__dirname, "..", "podklady", "dungeon-ram", "matte.png"), I.resize(out, 768, 512));
  console.log("hotovo");
}

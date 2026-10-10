// Ikony míst na mapě (Poutníkův deník): podklady/cech/ikonymapa.png (průhledné PNG, vlevo lupa = neobjevené, vpravo vlajka = objevené)
// -> WoWpoCesku/Textures/mapa-neobjeveno.tga a mapa-objeveno.tga (64×64). Spuštění: node tools/mapa-ikony.js
const path = require("path");
const I = require("./cech-obraz.js");
const src = I.decodePNG(path.join(__dirname, "..", "podklady", "cech", "ikonymapa.png"));
const half = src.w >> 1;
const OUT = path.join(__dirname, "..", "WoWpoCesku", "Textures");
[["mapa-neobjeveno", 0, half], ["mapa-objeveno", half, src.w - half]].forEach(([name, x0, w]) => {
  let img = I.crop(src, x0, 0, w, src.h);
  const b = I.bbox(img, 24);   // { x, y, w, h } podle průhlednosti
  img = I.crop(img, b.x, b.y, b.w, b.h);
  const side = Math.max(img.w, img.h);
  const sq = I.blank(side, side);
  const ox = (side - img.w) >> 1, oy = (side - img.h) >> 1;
  for (let y = 0; y < img.h; y++) for (let x = 0; x < img.w; x++) for (let c = 0; c < 4; c++) sq.data[((y + oy) * side + x + ox) * 4 + c] = img.data[(y * img.w + x) * 4 + c];
  I.writeTGA(path.join(OUT, name + ".tga"), I.resize(sq, 64, 64));
  console.log(name, "ok");
});

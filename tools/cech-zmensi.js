// Zmenší velké textury Cechovní kroniky (TGA 32bit, vlastní zápis z cech-obraz.js), aby zip pro CurseForge zůstal pod 10 MB.
//   node tools/cech-zmensi.js
const fs = require("fs");
const path = require("path");
const I = require("./cech-obraz");
const DIR = path.join(__dirname, "..", "WoWpoCesku", "Textures");

function readTGA(p) {
  const b = fs.readFileSync(p);
  const w = b.readUInt16LE(12), h = b.readUInt16LE(14);
  if (b[2] !== 2 || b[16] !== 32 || b[17] !== 0x28) throw new Error("neočekávaný formát " + p);
  const img = I.blank(w, h);
  for (let i = 0; i < w * h; i++) {
    const o = 18 + i * 4;
    img.data[i * 4] = b[o + 2]; img.data[i * 4 + 1] = b[o + 1]; img.data[i * 4 + 2] = b[o]; img.data[i * 4 + 3] = b[o + 3];
  }
  return img;
}

// název -> nová velikost (poměr stran zůstává, texcoordy jsou zlomky, takže se kód nemění)
const JOBS = { "cech-ikony": [512, 256], "cech-ikony2": [512, 256], "cech-odznaky": [512, 256], "cech-medaile": [512, 128] };
for (const [name, [w, h]] of Object.entries(JOBS)) {
  const p = path.join(DIR, name + ".tga");
  const img = readTGA(p);
  if (img.w <= w) { console.log(name, "už je malá"); continue; }
  I.writeTGA(p, I.resize(img, w, h));
  console.log(name, img.w + "x" + img.h, "->", w + "x" + h);
}

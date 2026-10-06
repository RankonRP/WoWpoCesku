// Převede malované bannery dungeonů (tools/zdroje/obrazky-dungeony/<slug>.png) na textury pro hru:
// WoWpoCesku/Textures/Dungeony/<slug>.tga (512×64, 32bit, nekomprimované TGA) – vystřihne se vodorovný pruh 8:1
// ze středu obrázku. Zároveň přegeneruje WoWpoCesku/DataObrazky.lua (které instance obrázek mají).
// Spuštění: node tools/dungeony-obrazky.js
const fs = require('fs');
const path = require('path');
const zlib = require('zlib');

const SRC = path.join(__dirname, 'zdroje', 'obrazky-dungeony');
const DST = path.join(__dirname, '..', 'WoWpoCesku', 'Textures', 'Dungeony');
const LUA = path.join(__dirname, '..', 'WoWpoCesku', 'DataObrazky.lua');
const OUT_W = 512, OUT_H = 64;

// instance (název ze hry) -> název souboru
const SLUGS = {
    'Ragefire Chasm': 'ragefire-chasm', 'Wailing Caverns': 'wailing-caverns', 'The Deadmines': 'deadmines',
    'Shadowfang Keep': 'shadowfang-keep', 'Blackfathom Deeps': 'blackfathom-deeps', 'The Stockade': 'stockade',
    'Ruins of Lordaeron': 'ruins-of-lordaeron', 'Hall of Thanes': 'hall-of-thanes', 'Excavation Site: Wetlands': 'excavation-site-wetlands', 'City of Dalaran': 'city-of-dalaran',
    'Gnomeregan': 'gnomeregan', 'Razorfen Kraul': 'razorfen-kraul', 'Scarlet Monastery': 'scarlet-monastery',
    'Razorfen Downs': 'razorfen-downs', 'Uldaman': 'uldaman', "Zul'Farrak": 'zulfarrak', 'Maraudon': 'maraudon',
    'Sunken Temple': 'sunken-temple', 'Blackrock Depths': 'blackrock-depths', 'Blackrock Spire': 'blackrock-spire',
    'Dire Maul': 'dire-maul', 'Scholomance': 'scholomance', 'Stratholme': 'stratholme', 'Molten Core': 'molten-core',
    "Onyxia's Lair": 'onyxias-lair', 'Blackwing Lair': 'blackwing-lair', "Zul'Gurub": 'zulgurub',
    "Ruins of Ahn'Qiraj": 'ruins-of-ahnqiraj', "Ahn'Qiraj Temple": 'ahnqiraj-temple', 'Naxxramas': 'naxxramas',
};

function readPng(file) {
    const b = fs.readFileSync(file);
    let p = 8, w, h, depth, ctype, interlace;
    const idat = [];
    while (p < b.length) {
        const len = b.readUInt32BE(p), type = b.toString('ascii', p + 4, p + 8), d = b.subarray(p + 8, p + 8 + len);
        if (type === 'IHDR') { w = d.readUInt32BE(0); h = d.readUInt32BE(4); depth = d[8]; ctype = d[9]; interlace = d[12]; }
        else if (type === 'IDAT') idat.push(d);
        p += 12 + len;
    }
    if (depth !== 8 || (ctype !== 6 && ctype !== 2) || interlace) throw new Error(file + ': čekám 8bit RGB/RGBA bez prokládání');
    const bpp = ctype === 6 ? 4 : 3;
    const raw = zlib.inflateSync(Buffer.concat(idat));
    const px = Buffer.alloc(w * h * 4);
    const stride = w * bpp;
    let prev = Buffer.alloc(stride);
    for (let y = 0; y < h; y++) {
        const f = raw[y * (stride + 1)];
        const line = Buffer.from(raw.subarray(y * (stride + 1) + 1, (y + 1) * (stride + 1)));
        for (let i = 0; i < stride; i++) {
            const a = i >= bpp ? line[i - bpp] : 0, up = prev[i], c = i >= bpp ? prev[i - bpp] : 0;
            let v = line[i];
            if (f === 1) v += a;
            else if (f === 2) v += up;
            else if (f === 3) v += (a + up) >> 1;
            else if (f === 4) { const pp = a + up - c, pa = Math.abs(pp - a), pb = Math.abs(pp - up), pc = Math.abs(pp - c); v += (pa <= pb && pa <= pc) ? a : (pb <= pc ? up : c); }
            line[i] = v & 255;
        }
        for (let x = 0; x < w; x++) {
            const o = (y * w + x) * 4;
            px[o] = line[x * bpp]; px[o + 1] = line[x * bpp + 1]; px[o + 2] = line[x * bpp + 2];
            px[o + 3] = bpp === 4 ? line[x * bpp + 3] : 255;
        }
        prev = line;
    }
    return { w, h, px };
}

fs.mkdirSync(DST, { recursive: true });
const have = {};
for (const [name, slug] of Object.entries(SLUGS)) {
    const file = path.join(SRC, slug + '.png');
    if (!fs.existsSync(file)) continue;
    const { w, h, px } = readPng(file);
    // vodorovný pruh 8:1 ze středu (výška celá, šířka podle poměru; když je obrázek užší, ořízne se výška)
    let cw = w, ch = Math.floor(w / 8);
    if (ch > h) { ch = h; cw = h * 8; }
    const x0 = Math.floor((w - cw) / 2), y0 = Math.floor((h - ch) / 2);
    const buf = Buffer.alloc(18 + OUT_W * OUT_H * 4);
    buf[2] = 2; buf.writeUInt16LE(OUT_W, 12); buf.writeUInt16LE(OUT_H, 14); buf[16] = 32; buf[17] = 8 | 0x20;
    let o = 18;
    for (let y = 0; y < OUT_H; y++) {
        for (let x = 0; x < OUT_W; x++) {
            const sx0 = x0 + Math.floor(x * cw / OUT_W), sx1 = Math.max(sx0 + 1, x0 + Math.floor((x + 1) * cw / OUT_W));
            const sy0 = y0 + Math.floor(y * ch / OUT_H), sy1 = Math.max(sy0 + 1, y0 + Math.floor((y + 1) * ch / OUT_H));
            let r = 0, g = 0, bl = 0, n = 0;
            for (let yy = sy0; yy < sy1; yy++) for (let xx = sx0; xx < sx1; xx++) {
                const i = (yy * w + xx) * 4;
                r += px[i]; g += px[i + 1]; bl += px[i + 2]; n++;
            }
            buf[o++] = Math.round(bl / n); buf[o++] = Math.round(g / n); buf[o++] = Math.round(r / n); buf[o++] = 255;
        }
    }
    fs.writeFileSync(path.join(DST, slug + '.tga'), buf);
    have[name] = slug;
    console.log(name, w + 'x' + h, '->', slug + '.tga');
}
const lines = Object.entries(have).map(([n, s]) => `    ["${n}"] = "${s}",`);
fs.writeFileSync(LUA, `-- © 2026 RankonRP a přispěvatelé. Překlady a texty nelze kopírovat do jiných addonů ani projektů bez povolení – viz docs/LICENSE-DATA.md
-- WoWpoCesku: které instance mají malovaný banner v Textures\\Dungeony (název souboru bez přípony).
-- Soubor se generuje: node tools/dungeony-obrazky.js

WoWpoCesku_DungeonArt = {
${lines.join('\n')}${lines.length ? '\n' : ''}}
`);
console.log('hotovo, instancí s obrázkem:', lines.length, 'z', Object.keys(SLUGS).length);

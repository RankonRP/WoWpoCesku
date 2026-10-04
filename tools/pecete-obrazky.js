// Převede obrázky pečetí (obrazky-pecete/*.png, RGBA) na textury pro hru:
// WoWpoCesku/Textures/Pecete/<jméno>.tga (128×128, 32bit, nekomprimované TGA).
// Bílé pozadí (kdyby PNG nemělo průhlednost) se zprůhlední.
// Spuštění: node tools/pecete-obrazky.js
const fs = require('fs');
const path = require('path');
const zlib = require('zlib');

const SRC = path.join(__dirname, '..', 'obrazky-pecete');
const DST = path.join(__dirname, '..', 'WoWpoCesku', 'Textures', 'Pecete');
const OUT = 128;

function readPng(file) {
    const b = fs.readFileSync(file);
    let p = 8, w, h, depth, ctype;
    const idat = [];
    while (p < b.length) {
        const len = b.readUInt32BE(p), type = b.toString('ascii', p + 4, p + 8), d = b.subarray(p + 8, p + 8 + len);
        if (type === 'IHDR') { w = d.readUInt32BE(0); h = d.readUInt32BE(4); depth = d[8]; ctype = d[9]; }
        else if (type === 'IDAT') idat.push(d);
        p += 12 + len;
    }
    if (depth !== 8 || (ctype !== 6 && ctype !== 2)) throw new Error(file + ': čekám 8bit RGB/RGBA');
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
for (const f of fs.readdirSync(SRC).filter((x) => x.toLowerCase().endsWith('.png'))) {
    const { w, h, px } = readPng(path.join(SRC, f));
    // bílé pozadí -> průhledné (jen když obrázek nemá vlastní průhlednost)
    let transparent = 0;
    for (let i = 3; i < px.length; i += 4) if (px[i] < 10) transparent++;
    if (transparent < w * h * 0.05) {
        for (let i = 0; i < px.length; i += 4) {
            const m = Math.min(px[i], px[i + 1], px[i + 2]);
            if (m > 235) px[i + 3] = Math.round(255 * (255 - m) / 20);
        }
    }
    // zmenšení průměrováním (s ohledem na alfu, ať okraje neztmavnou)
    const buf = Buffer.alloc(18 + OUT * OUT * 4);
    buf[2] = 2; buf.writeUInt16LE(OUT, 12); buf.writeUInt16LE(OUT, 14); buf[16] = 32; buf[17] = 8 | 0x20;
    let o = 18;
    for (let y = 0; y < OUT; y++) {
        for (let x = 0; x < OUT; x++) {
            const x0 = Math.floor(x * w / OUT), x1 = Math.floor((x + 1) * w / OUT), y0 = Math.floor(y * h / OUT), y1 = Math.floor((y + 1) * h / OUT);
            let r = 0, g = 0, bl = 0, a = 0, n = 0;
            for (let yy = y0; yy < y1; yy++) for (let xx = x0; xx < x1; xx++) {
                const i = (yy * w + xx) * 4, al = px[i + 3];
                r += px[i] * al; g += px[i + 1] * al; bl += px[i + 2] * al; a += al; n++;
            }
            buf[o++] = a ? Math.round(bl / a) : 0;
            buf[o++] = a ? Math.round(g / a) : 0;
            buf[o++] = a ? Math.round(r / a) : 0;
            buf[o++] = Math.round(a / n);
        }
    }
    const out = path.join(DST, f.replace(/\.png$/i, '.tga'));
    fs.writeFileSync(out, buf);
    console.log(f, w + 'x' + h, 'průhledných pixelů ' + Math.round(transparent / (w * h) * 100) + ' %', '->', path.basename(out));
}

// Vyrobí texturu voskové pečeti pro záložku Pečetě: WoWpoCesku/Textures/pecet.tga
// (128×128, 32bit, nekomprimované TGA). Je ve stupních šedi – barvu dává addon (SetVertexColor):
// získaná pečeť rudý vosk, rozpracovaná vybledlý.
// Spuštění: node tools/pecet.js
const fs = require('fs');
const path = require('path');

const N = 128, C = N / 2;
let seed = 4242;
const rnd = () => ((seed = (seed * 1103515245 + 12345) & 0x7fffffff) / 0x7fffffff);

// nepravidelný okraj vosku: pár vln + tři „kapky“ vosku přetékající přes okraj
const waves = [3, 5, 7, 11].map(k => ({ k, a: rnd() * 1.6 + 0.6, p: rnd() * Math.PI * 2 }));
const drips = [0, 1, 2].map(() => ({ ang: rnd() * Math.PI * 2, w: 0.25 + rnd() * 0.2, a: 3 + rnd() * 3 }));
function edgeR(t) {
    let r = 54;
    for (const w of waves) r += Math.sin(t * w.k + w.p) * w.a * 0.5;
    for (const d of drips) {
        let dt = Math.abs(((t - d.ang + Math.PI * 3) % (Math.PI * 2)) - Math.PI);
        if (dt < d.w) r += d.a * Math.cos(dt / d.w * Math.PI / 2);
    }
    return Math.min(62, r);
}

// výšková mapa: vypouklý vosk, uprostřed vtlačená plocha, kolem ní vyražený prstenec
function height(x, y) {
    const dx = x - C, dy = y - C;
    const d = Math.sqrt(dx * dx + dy * dy);
    const R = edgeR(Math.atan2(dy, dx));
    if (d >= R) return -1;
    const fromEdge = R - d;
    let h = Math.min(1, fromEdge / 9);            // zaoblený okraj vosku
    h = Math.sin(h * Math.PI / 2) * 0.9;
    if (d < 40) h -= 0.25 * Math.min(1, (40 - d) / 2);   // vtlačená plocha pod znakem
    const ring = Math.abs(d - 41.5);                  // vyražený prstenec
    if (ring < 2.2) h += 0.22 * (1 - ring / 2.2);
    // drobné nerovnosti
    h += (Math.sin(x * 0.9 + y * 0.4) + Math.sin(y * 1.1 - x * 0.3)) * 0.008;
    return h;
}

const buf = Buffer.alloc(18 + N * N * 4);
buf[2] = 2;
buf.writeUInt16LE(N, 12);
buf.writeUInt16LE(N, 14);
buf[16] = 32;
buf[17] = 8 | 0x20;
let o = 18;
const L = { x: -0.55, y: -0.65, z: 0.52 };   // světlo zleva shora
for (let y = 0; y < N; y++) {
    for (let x = 0; x < N; x++) {
        // vyhlazení okraje: 4×4 vzorky na pixel
        let cover = 0;
        for (let sy = 0; sy < 4; sy++) for (let sx = 0; sx < 4; sx++)
            if (height(x + (sx + 0.5) / 4, y + (sy + 0.5) / 4) >= 0) cover++;
        cover /= 16;
        let v = 0;
        if (cover > 0) {
            const h = Math.max(0, height(x + 0.5, y + 0.5));
            const hx = Math.max(0, height(x + 1.5, y + 0.5)) - Math.max(0, height(x - 0.5, y + 0.5));
            const hy = Math.max(0, height(x + 0.5, y + 1.5)) - Math.max(0, height(x + 0.5, y - 0.5));
            const nx = -hx * 3, ny = -hy * 3, nz = 1;
            const nl = Math.sqrt(nx * nx + ny * ny + nz * nz);
            const diff = Math.max(0, (nx * L.x + ny * L.y + nz * L.z) / nl);
            const spec = Math.pow(diff, 18) * 0.35;           // lesk vosku
            v = 0.42 + diff * 0.55 + spec + h * 0.08;
        }
        const g = Math.max(0, Math.min(255, v * 235));
        buf[o++] = g; buf[o++] = g; buf[o++] = g;
        buf[o++] = Math.round(cover * 255);
    }
}
const out = path.join(__dirname, '..', 'WoWpoCesku', 'Textures', 'pecet.tga');
fs.writeFileSync(out, buf);
console.log('hotovo:', out);

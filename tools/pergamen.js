// Vyrobí texturu pergamenu pro Kroniku Azerothu: WoWpoCesku/Textures/pergamen.tga (512×512, 32bit, nekomprimované TGA)
// Spuštění: node tools/pergamen.js
const fs = require('fs');
const path = require('path');

const N = 512;
let seed = 1337;
const rnd = () => ((seed = (seed * 1103515245 + 12345) & 0x7fffffff) / 0x7fffffff);

// hodnotový šum s dlaždicemi (bezešvý), více oktáv
function makeNoise(cells) {
    const g = [];
    for (let i = 0; i < cells * cells; i++) g.push(rnd());
    const at = (x, y) => g[((y % cells + cells) % cells) * cells + ((x % cells + cells) % cells)];
    const s = t => t * t * (3 - 2 * t);
    return (x, y) => {
        const fx = x / N * cells, fy = y / N * cells;
        const x0 = Math.floor(fx), y0 = Math.floor(fy);
        const tx = s(fx - x0), ty = s(fy - y0);
        const a = at(x0, y0) + (at(x0 + 1, y0) - at(x0, y0)) * tx;
        const b = at(x0, y0 + 1) + (at(x0 + 1, y0 + 1) - at(x0, y0 + 1)) * tx;
        return a + (b - a) * ty;
    };
}
const octaves = [4, 8, 16, 32, 64, 128].map(c => ({ f: makeNoise(c), w: 1 / Math.sqrt(c) }));
const wsum = octaves.reduce((s, o) => s + o.w, 0);
const fiber = makeNoise(256);
const stains = makeNoise(10);

const buf = Buffer.alloc(18 + N * N * 4);
buf[2] = 2;                       // nekomprimované true-color
buf.writeUInt16LE(N, 12);
buf.writeUInt16LE(N, 14);
buf[16] = 32;
buf[17] = 8 | 0x20;               // 8 bitů alfa, počátek vlevo nahoře
let o = 18;
for (let y = 0; y < N; y++) {
    for (let x = 0; x < N; x++) {
        let n = 0;
        for (const oc of octaves) n += oc.f(x, y) * oc.w;
        n /= wsum;                                     // 0..1, kolem 0.5
        const fb = fiber(x * 3, y) - 0.5;              // jemná vlákna (protáhlá vodorovně)
        let st = stains(x, y);                         // velké skvrny
        st = st > 0.66 ? (st - 0.66) * 1.2 : 0;
        // vinětace: okraje tmavší a do hněda
        const dx = (x / (N - 1)) * 2 - 1, dy = (y / (N - 1)) * 2 - 1;
        const edge = Math.min(1, Math.pow(Math.max(Math.abs(dx), Math.abs(dy)), 5) * 0.9 + (dx * dx + dy * dy) * 0.12);
        let shade = 1 + (n - 0.5) * 0.22 + fb * 0.05 - st * 0.12 - edge * 0.42;
        const r = 240 * shade, g = 220 * shade - edge * 14 - st * 18, b = 168 * shade - edge * 34 - st * 40;
        buf[o++] = Math.max(0, Math.min(255, b));
        buf[o++] = Math.max(0, Math.min(255, g));
        buf[o++] = Math.max(0, Math.min(255, r));
        buf[o++] = 255;
    }
}
const out = path.join(__dirname, '..', 'WoWpoCesku', 'Textures', 'pergamen.tga');
fs.mkdirSync(path.dirname(out), { recursive: true });
fs.writeFileSync(out, buf);
console.log('hotovo:', out);

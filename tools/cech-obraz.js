// Malá knihovna na práci s obrázky pro Cechovní kroniku: načtení PNG, ořez, změna velikosti, zrcadlení, zápis TGA.
// (Hra neumí PNG, jen TGA/BLP; všechno se dělá bez externích balíčků.)
const fs = require("fs");
const zlib = require("zlib");

function decodePNG(path) {
  const b = fs.readFileSync(path);
  if (b.readUInt32BE(0) !== 0x89504e47) throw new Error("není PNG: " + path);
  let pos = 8, w = 0, h = 0, depth = 0, ctype = 0, interlace = 0;
  const idat = [];
  let plte = null, trns = null;
  while (pos < b.length) {
    const len = b.readUInt32BE(pos), type = b.toString("ascii", pos + 4, pos + 8);
    const data = b.slice(pos + 8, pos + 8 + len);
    if (type === "IHDR") { w = data.readUInt32BE(0); h = data.readUInt32BE(4); depth = data[8]; ctype = data[9]; interlace = data[12]; }
    else if (type === "IDAT") idat.push(data);
    else if (type === "PLTE") plte = data;
    else if (type === "tRNS") trns = data;
    pos += 12 + len;
  }
  if (depth !== 8 || interlace !== 0) throw new Error(`nepodporovaný PNG (hloubka ${depth}, prokládání ${interlace}): ${path}`);
  const ch = { 0: 1, 2: 3, 3: 1, 4: 2, 6: 4 }[ctype];
  const raw = zlib.inflateSync(Buffer.concat(idat));
  const stride = w * ch;
  const out = Buffer.alloc(w * h * ch);
  let prev = Buffer.alloc(stride);
  for (let y = 0; y < h; y++) {
    const f = raw[y * (stride + 1)];
    const line = raw.slice(y * (stride + 1) + 1, (y + 1) * (stride + 1));
    const cur = out.slice(y * stride, (y + 1) * stride);
    for (let x = 0; x < stride; x++) {
      const a = x >= ch ? cur[x - ch] : 0, up = prev[x], c = x >= ch ? prev[x - ch] : 0;
      let v = line[x];
      if (f === 1) v += a;
      else if (f === 2) v += up;
      else if (f === 3) v += (a + up) >> 1;
      else if (f === 4) {
        const p = a + up - c, pa = Math.abs(p - a), pb = Math.abs(p - up), pc = Math.abs(p - c);
        v += (pa <= pb && pa <= pc) ? a : (pb <= pc ? up : c);
      }
      cur[x] = v & 255;
    }
    prev = cur;
  }
  // do RGBA
  const rgba = Buffer.alloc(w * h * 4);
  for (let i = 0; i < w * h; i++) {
    let r, g, bl, a = 255;
    if (ctype === 6) { r = out[i * 4]; g = out[i * 4 + 1]; bl = out[i * 4 + 2]; a = out[i * 4 + 3]; }
    else if (ctype === 2) { r = out[i * 3]; g = out[i * 3 + 1]; bl = out[i * 3 + 2]; }
    else if (ctype === 0) { r = g = bl = out[i]; }
    else if (ctype === 4) { r = g = bl = out[i * 2]; a = out[i * 2 + 1]; }
    else { const k = out[i]; r = plte[k * 3]; g = plte[k * 3 + 1]; bl = plte[k * 3 + 2]; a = trns && k < trns.length ? trns[k] : 255; }
    rgba[i * 4] = r; rgba[i * 4 + 1] = g; rgba[i * 4 + 2] = bl; rgba[i * 4 + 3] = a;
  }
  return { w, h, data: rgba };
}

function blank(w, h) { return { w, h, data: Buffer.alloc(w * h * 4) }; }

function crop(img, x0, y0, cw, ch) {
  const o = blank(cw, ch);
  for (let y = 0; y < ch; y++) for (let x = 0; x < cw; x++) {
    const sx = x0 + x, sy = y0 + y;
    if (sx < 0 || sy < 0 || sx >= img.w || sy >= img.h) continue;
    img.data.copy(o.data, (y * cw + x) * 4, (sy * img.w + sx) * 4, (sy * img.w + sx) * 4 + 4);
  }
  return o;
}

// změna velikosti průměrováním oblastí (správně i s průhledností, počítá se s předmnožením alfa)
function resize(img, nw, nh) {
  const tmp = new Float64Array(nw * img.h * 4);
  const sx = img.w / nw;
  for (let y = 0; y < img.h; y++) {
    for (let x = 0; x < nw; x++) {
      const a0 = x * sx, a1 = (x + 1) * sx;
      let R = 0, G = 0, B = 0, A = 0, W = 0;
      for (let i = Math.floor(a0); i < Math.ceil(a1) && i < img.w; i++) {
        const wt = Math.min(i + 1, a1) - Math.max(i, a0);
        const o = (y * img.w + i) * 4, al = img.data[o + 3] / 255;
        R += img.data[o] * al * wt; G += img.data[o + 1] * al * wt; B += img.data[o + 2] * al * wt; A += al * wt; W += wt;
      }
      const t = (y * nw + x) * 4;
      tmp[t] = R / W; tmp[t + 1] = G / W; tmp[t + 2] = B / W; tmp[t + 3] = A / W;
    }
  }
  const o = blank(nw, nh);
  const sy = img.h / nh;
  for (let y = 0; y < nh; y++) {
    const a0 = y * sy, a1 = (y + 1) * sy;
    for (let x = 0; x < nw; x++) {
      let R = 0, G = 0, B = 0, A = 0, W = 0;
      for (let j = Math.floor(a0); j < Math.ceil(a1) && j < img.h; j++) {
        const wt = Math.min(j + 1, a1) - Math.max(j, a0);
        const t = (j * nw + x) * 4;
        R += tmp[t] * wt; G += tmp[t + 1] * wt; B += tmp[t + 2] * wt; A += tmp[t + 3] * wt; W += wt;
      }
      R /= W; G /= W; B /= W; A /= W;
      const d = (y * nw + x) * 4;
      if (A > 0.0001) {
        o.data[d] = Math.min(255, Math.round(R / A)); o.data[d + 1] = Math.min(255, Math.round(G / A));
        o.data[d + 2] = Math.min(255, Math.round(B / A)); o.data[d + 3] = Math.min(255, Math.round(A * 255));
      }
    }
  }
  return o;
}

function flipH(img) {
  const o = blank(img.w, img.h);
  for (let y = 0; y < img.h; y++) for (let x = 0; x < img.w; x++)
    img.data.copy(o.data, (y * img.w + x) * 4, (y * img.w + (img.w - 1 - x)) * 4, (y * img.w + (img.w - 1 - x)) * 4 + 4);
  return o;
}
function flipV(img) {
  const o = blank(img.w, img.h);
  for (let y = 0; y < img.h; y++) img.data.copy(o.data, y * img.w * 4, (img.h - 1 - y) * img.w * 4, (img.h - y) * img.w * 4);
  return o;
}

// obdélník neprůhledného obsahu (alfa > práh)
function bbox(img, thr = 24) {
  let x0 = img.w, y0 = img.h, x1 = -1, y1 = -1;
  for (let y = 0; y < img.h; y++) for (let x = 0; x < img.w; x++) {
    if (img.data[(y * img.w + x) * 4 + 3] > thr) {
      if (x < x0) x0 = x; if (x > x1) x1 = x; if (y < y0) y0 = y; if (y > y1) y1 = y;
    }
  }
  return x1 < 0 ? null : { x: x0, y: y0, w: x1 - x0 + 1, h: y1 - y0 + 1 };
}

// vloží obrázek na plátno dané velikosti (zarovnání: "left"/"center", "top"/"middle")
function pad(img, W, H, ha = "center", va = "middle") {
  const o = blank(W, H);
  const ox = ha === "left" ? 0 : Math.floor((W - img.w) / 2);
  const oy = va === "top" ? 0 : Math.floor((H - img.h) / 2);
  for (let y = 0; y < img.h; y++) for (let x = 0; x < img.w; x++) {
    const dx = ox + x, dy = oy + y;
    if (dx < 0 || dy < 0 || dx >= W || dy >= H) continue;
    img.data.copy(o.data, (dy * W + dx) * 4, (y * img.w + x) * 4, (y * img.w + x) * 4 + 4);
  }
  return o;
}

// pás z dlaždice zrcadlově opakované do šířky W (aby spoje nebyly vidět)
function mirrorTileH(seg, W) {
  const o = blank(W, seg.h);
  const f = flipH(seg);
  for (let x = 0; x < W; x++) {
    const k = Math.floor(x / seg.w), xx = x % seg.w;
    const src = k % 2 === 0 ? seg : f;
    for (let y = 0; y < seg.h; y++) src.data.copy(o.data, (y * W + x) * 4, (y * seg.w + xx) * 4, (y * seg.w + xx) * 4 + 4);
  }
  return o;
}
function mirrorTileV(seg, H) {
  const o = blank(seg.w, H);
  const f = flipV(seg);
  for (let y = 0; y < H; y++) {
    const k = Math.floor(y / seg.h), yy = y % seg.h;
    const src = k % 2 === 0 ? seg : f;
    src.data.copy(o.data, y * seg.w * 4, yy * seg.w * 4, (yy + 1) * seg.w * 4);
  }
  return o;
}

function writeTGA(path, img) {
  const h = Buffer.alloc(18);
  h[2] = 2; h.writeUInt16LE(img.w, 12); h.writeUInt16LE(img.h, 14); h[16] = 32; h[17] = 0x28;
  const px = Buffer.alloc(img.w * img.h * 4);
  for (let i = 0; i < img.w * img.h; i++) {
    px[i * 4] = img.data[i * 4 + 2]; px[i * 4 + 1] = img.data[i * 4 + 1]; px[i * 4 + 2] = img.data[i * 4]; px[i * 4 + 3] = img.data[i * 4 + 3];
  }
  fs.writeFileSync(path, Buffer.concat([h, px]));
}

// náhled jako PNG (pro kontrolu), na pozadí o dané barvě
function writePNG(path, img, bg = [230, 210, 165]) {
  const w = img.w, h = img.h;
  const raw = Buffer.alloc((w * 4 + 1) * h);
  for (let y = 0; y < h; y++) {
    raw[y * (w * 4 + 1)] = 0;
    for (let x = 0; x < w; x++) {
      const o = (y * w + x) * 4, a = img.data[o + 3] / 255, d = y * (w * 4 + 1) + 1 + x * 4;
      raw[d] = Math.round(img.data[o] * a + bg[0] * (1 - a)); raw[d + 1] = Math.round(img.data[o + 1] * a + bg[1] * (1 - a));
      raw[d + 2] = Math.round(img.data[o + 2] * a + bg[2] * (1 - a)); raw[d + 3] = 255;
    }
  }
  const crcT = []; for (let n = 0; n < 256; n++) { let c = n; for (let k = 0; k < 8; k++) c = c & 1 ? 0xedb88320 ^ (c >>> 1) : c >>> 1; crcT[n] = c >>> 0; }
  const crc = (buf) => { let c = 0xffffffff; for (const v of buf) c = crcT[(c ^ v) & 255] ^ (c >>> 8); return (c ^ 0xffffffff) >>> 0; };
  const chunk = (t, d) => { const l = Buffer.alloc(4); l.writeUInt32BE(d.length); const td = Buffer.concat([Buffer.from(t), d]); const c = Buffer.alloc(4); c.writeUInt32BE(crc(td)); return Buffer.concat([l, td, c]); };
  const ihdr = Buffer.alloc(13); ihdr.writeUInt32BE(w, 0); ihdr.writeUInt32BE(h, 4); ihdr[8] = 8; ihdr[9] = 6;
  fs.writeFileSync(path, Buffer.concat([Buffer.from([137, 80, 78, 71, 13, 10, 26, 10]), chunk("IHDR", ihdr), chunk("IDAT", zlib.deflateSync(raw)), chunk("IEND", Buffer.alloc(0))]));
}

// PNG s průhledností (RGBA)
function writePNGAlpha(path, img) {
  const w = img.w, h = img.h;
  const raw = Buffer.alloc((w * 4 + 1) * h);
  for (let y = 0; y < h; y++) { raw[y * (w * 4 + 1)] = 0; img.data.copy(raw, y * (w * 4 + 1) + 1, y * w * 4, (y + 1) * w * 4); }
  const crcT = []; for (let n = 0; n < 256; n++) { let c = n; for (let k = 0; k < 8; k++) c = c & 1 ? 0xedb88320 ^ (c >>> 1) : c >>> 1; crcT[n] = c >>> 0; }
  const crc = (buf) => { let c = 0xffffffff; for (const v of buf) c = crcT[(c ^ v) & 255] ^ (c >>> 8); return (c ^ 0xffffffff) >>> 0; };
  const chunk = (t, d) => { const l = Buffer.alloc(4); l.writeUInt32BE(d.length); const td = Buffer.concat([Buffer.from(t), d]); const c = Buffer.alloc(4); c.writeUInt32BE(crc(td)); return Buffer.concat([l, td, c]); };
  const ihdr = Buffer.alloc(13); ihdr.writeUInt32BE(w, 0); ihdr.writeUInt32BE(h, 4); ihdr[8] = 8; ihdr[9] = 6;
  fs.writeFileSync(path, Buffer.concat([Buffer.from([137, 80, 78, 71, 13, 10, 26, 10]), chunk("IHDR", ihdr), chunk("IDAT", zlib.deflateSync(raw)), chunk("IEND", Buffer.alloc(0))]));
}

// Černé pozadí -> průhlednost: souvislá černá oblast od okrajů obrazu (práh thr) zprůhlední, hrana se jen o 1 pixel změkčí podle jasu, aby se neukousl okraj
function keyBlack(img, thr) {
  const { w, h, data } = img;
  if (data[3] < 250 && data[(w - 1) * 4 + 3] < 250) return img;   // obrázek už je průhledný (PNG s alfou) – nic se neodstraňuje
  const bg = new Uint8Array(w * h), stack = [];
  const mx = (i) => Math.max(data[i * 4], data[i * 4 + 1], data[i * 4 + 2]);
  for (let x = 0; x < w; x++) stack.push(x, (h - 1) * w + x);
  for (let y = 0; y < h; y++) stack.push(y * w, y * w + w - 1);
  while (stack.length) {
    const i = stack.pop();
    if (bg[i] || mx(i) >= thr) continue;
    bg[i] = 1;
    const x = i % w, y = (i / w) | 0;
    if (x > 0) stack.push(i - 1); if (x < w - 1) stack.push(i + 1);
    if (y > 0) stack.push(i - w); if (y < h - 1) stack.push(i + w);
  }
  for (let i = 0; i < w * h; i++) data[i * 4 + 3] = bg[i] ? 0 : 255;
  for (let y = 1; y < h - 1; y++) for (let x = 1; x < w - 1; x++) {
    const i = y * w + x;
    if (!bg[i]) continue;
    let edge = false;
    for (let dy = -1; dy <= 1 && !edge; dy++) for (let dx = -1; dx <= 1; dx++) if (!bg[i + dy * w + dx]) { edge = true; break; }
    if (edge) data[i * 4 + 3] = Math.round(255 * Math.min(1, mx(i) / (thr + 10)));
  }
  return img;
}
module.exports = { keyBlack, writePNGAlpha, decodePNG, blank, crop, resize, flipH, flipV, bbox, pad, mirrorTileH, mirrorTileV, writeTGA, writePNG };

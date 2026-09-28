// Pomocník WoWpoČesku pro macOS
// ----------------------------------------------------------------------------
// Mac verze Pomocníka (pomocnik.ps1). Běží v Terminálu přes vestavěný `osascript`
// (JavaScript for Automation) – nic se neinstaluje.
//
// Co dělá (stejně jako Windows verze):
//  - při prvním spuštění zkopíruje addon (složku WoWpoCesku) do Interface/AddOns hry
//  - stahuje nové překlady z GitHubu (questy, rozhovory, texty rozhraní) a přepisuje Data*.lua v addonu
//  - hlídá frontu nepřeložených textů ze hry (SavedVariables, uloží se při /reload) a schránku (Cmd+C)
//  - nové texty přeloží (Google, nebo Claude) a pošle jejich ANGLICKÝ originál do společné sběrny
//  - projde mezipaměť questů hry (questcache.wdb) a pošle/přeloží questy, které v databázi chybí
//  - aktualizuje addon i sebe na novou verzi z GitHubu a po patchi hry doplní číslo rozhraní do .toc
// Chybí jen okno „Opravit překlad“ (ve Windows verzi je grafické).
//
// Spuštění: dvojklik na „Spustit pomocnika.command“, nebo v Terminálu:
//   osascript -l JavaScript pomocnik-mac.js "<složka Pomocníka>" [--jednou]
// Ukončení: Ctrl+C v okně Terminálu (nebo zavřít okno).
//
// Soubor jde spustit i v Node.js (node pomocnik-mac.js <složka> --jednou) – kvůli testování.

"use strict";

// ============================================================================
// Platforma: macOS (JXA) nebo Node.js
// ============================================================================
const IS_JXA = typeof ObjC !== "undefined";

const P = IS_JXA ? jxaPlatform() : nodePlatform();

function jxaPlatform() {
  ObjC.import("Foundation");
  ObjC.import("AppKit");
  const app = Application.currentApplication();
  app.includeStandardAdditions = true;
  const fm = $.NSFileManager.defaultManager;
  const env = ObjC.deepUnwrap($.NSProcessInfo.processInfo.environment) || {};
  return {
    name: "macOS",
    home: env.HOME || "",
    args: (ObjC.deepUnwrap($.NSProcessInfo.processInfo.arguments) || []).slice(1),
    exists: (p) => fm.fileExistsAtPath($(p)),
    isDir(p) {
      const r = Ref();
      return fm.fileExistsAtPathIsDirectory($(p), r) && !!r[0];
    },
    list(p) {
      const a = ObjC.deepUnwrap(fm.contentsOfDirectoryAtPathError($(p), $()));
      return Array.isArray(a) ? a : [];
    },
    mtime(p) {
      const a = ObjC.deepUnwrap(fm.attributesOfItemAtPathError($(p), $()));
      const d = a && a.NSFileModificationDate;
      return d ? String(new Date(d).getTime()) : "";
    },
    mkdirp: (p) => fm.createDirectoryAtPathWithIntermediateDirectoriesAttributesError($(p), true, $(), $()),
    readText(p) {
      const s = $.NSString.stringWithContentsOfFileEncodingError($(p), $.NSUTF8StringEncoding, $());
      const js = ObjC.unwrap(s);
      if (typeof js !== "string") throw new Error("Nejde přečíst soubor: " + p);
      return js.replace(/^﻿/, "");
    },
    writeText(p, text) {
      const ok = $(text).writeToFileAtomicallyEncodingError($(p), true, $.NSUTF8StringEncoding, $());
      if (!ok) throw new Error("Nejde zapsat soubor: " + p);
    },
    readBytes(p) {
      const d = $.NSData.dataWithContentsOfFile($(p));
      if (!d || d.isNil()) throw new Error("Nejde přečíst soubor: " + p);
      return base64ToBytes(ObjC.unwrap(d.base64EncodedStringWithOptions(0)));
    },
    remove: (p) => fm.removeItemAtPathError($(p), $()),
    // Spustí příkaz v /bin/sh, vrátí stdout. Při chybě vyhodí výjimku.
    sh: (cmd) => app.doShellScript(cmd, { alteringLineEndings: false }),
    sleep: (sec) => delay(sec),
    clipboardCount: () => Number($.NSPasteboard.generalPasteboard.changeCount),
    clipboardText() {
      const s = ObjC.unwrap($.NSPasteboard.generalPasteboard.stringForType($.NSPasteboardTypeString));
      return typeof s === "string" ? s : "";
    },
    notify(title, text) {
      try { app.displayNotification(text, { withTitle: title }); } catch (e) { /* notifikace nejsou povinné */ }
    },
    askYesNo(text, title) {
      try {
        app.activate();
        const r = app.displayDialog(text, { withTitle: title, buttons: ["Ne", "Ano"], defaultButton: "Ano" });
        return r.buttonReturned === "Ano";
      } catch (e) { return false; }
    },
    chooseFolder(prompt) {
      try { app.activate(); return String(app.chooseFolder({ withPrompt: prompt })).replace(/\/+$/, ""); } catch (e) { return null; }
    },
    chooseFromList(items, prompt, def) {
      try {
        app.activate();
        const r = app.chooseFromList(items, { withPrompt: prompt, defaultItems: [def || items[0]] });
        return Array.isArray(r) && r.length ? r[0] : null;
      } catch (e) { return null; }
    },
    out: (s) => console.log(s),
  };
}

function nodePlatform() {
  const fs = require("fs");
  const cp = require("child_process");
  const sab = new Int32Array(new SharedArrayBuffer(4));
  let fakeClip = "";
  let fakeCount = 0;
  return {
    name: "node",
    home: process.env.HOME || "",
    args: process.argv.slice(1),
    exists: (p) => fs.existsSync(p),
    isDir: (p) => { try { return fs.statSync(p).isDirectory(); } catch (e) { return false; } },
    list: (p) => { try { return fs.readdirSync(p); } catch (e) { return []; } },
    mtime: (p) => { try { return String(Math.round(fs.statSync(p).mtimeMs)); } catch (e) { return ""; } },
    mkdirp: (p) => fs.mkdirSync(p, { recursive: true }),
    readText: (p) => fs.readFileSync(p, "utf8").replace(/^﻿/, ""),
    writeText: (p, t) => { fs.writeFileSync(p + ".tmp", t); fs.renameSync(p + ".tmp", p); },
    readBytes: (p) => new Uint8Array(fs.readFileSync(p)),
    remove: (p) => fs.rmSync(p, { recursive: true, force: true }),
    sh: (cmd) => cp.execSync(cmd, { shell: "/bin/sh", encoding: "utf8", stdio: ["ignore", "pipe", "pipe"] }),
    sleep: (sec) => Atomics.wait(sab, 0, 0, sec * 1000),
    clipboardCount: () => fakeCount,
    clipboardText: () => fakeClip,
    setClipboard: (t) => { fakeClip = t; fakeCount++; },
    notify: () => {},
    zipUrl: process.env.WOWPOCESKU_ZIP || "",
    askYesNo: () => true,
    chooseFolder: () => process.env.WOW_SLOZKA || null,
    chooseFromList: (items, prompt, def) => def || items[0],
    out: (s) => console.log(s),
  };
}

// ============================================================================
// Pomocné funkce (bez závislosti na platformě)
// ============================================================================
function base64ToBytes(b64) {
  const map = new Int16Array(128).fill(-1);
  const abc = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
  for (let i = 0; i < 64; i++) map[abc.charCodeAt(i)] = i;
  const clean = b64.replace(/[^A-Za-z0-9+/]/g, "");
  const out = new Uint8Array(Math.floor((clean.length * 3) / 4));
  let o = 0, buf = 0, bits = 0;
  for (let i = 0; i < clean.length; i++) {
    buf = (buf << 6) | map[clean.charCodeAt(i)];
    bits += 6;
    if (bits >= 8) { bits -= 8; out[o++] = (buf >> bits) & 0xff; }
  }
  return out.subarray(0, o);
}

// Striktní dekódování UTF-8: při neplatné sekvenci vrátí null
function decodeUtf8(b, start, len) {
  let s = "";
  const end = start + len;
  let i = start;
  while (i < end) {
    const c = b[i];
    let cp, n;
    if (c < 0x80) { cp = c; n = 0; }
    else if (c >= 0xc2 && c < 0xe0) { cp = c & 0x1f; n = 1; }
    else if (c >= 0xe0 && c < 0xf0) { cp = c & 0x0f; n = 2; }
    else if (c >= 0xf0 && c < 0xf5) { cp = c & 0x07; n = 3; }
    else return null;
    if (i + n >= end) return null; // sekvence přesahuje konec řetězce
    for (let k = 1; k <= n; k++) {
      const x = b[i + k];
      if ((x & 0xc0) !== 0x80) return null;
      cp = (cp << 6) | (x & 0x3f);
    }
    if ((n === 2 && (cp < 0x800 || (cp >= 0xd800 && cp <= 0xdfff))) || (n === 3 && (cp < 0x10000 || cp > 0x10ffff))) return null;
    s += String.fromCodePoint(cp);
    i += n + 1;
  }
  return s;
}

// Krátký otisk textu (FNV-1a, 2×32 bitů) – pro seznam už zpracovaných textů z fronty
function hashText(s) {
  let h1 = 0x811c9dc5, h2 = 0x01000193 ^ 0x5bd1e995;
  for (let i = 0; i < s.length; i++) {
    const c = s.charCodeAt(i);
    h1 = Math.imul(h1 ^ c, 0x01000193) >>> 0;
    h2 = Math.imul(h2 ^ c, 0x5bd1e995) >>> 0;
  }
  return h1.toString(16).padStart(8, "0") + h2.toString(16).padStart(8, "0") + s.length.toString(16);
}

const q = (s) => "'" + String(s).replace(/'/g, "'\\''") + "'"; // bezpečné uvozovky pro shell
const join = (...a) => a.join("/").replace(/\/+/g, "/");
const dirname = (p) => p.replace(/\/[^/]*$/, "") || "/";
const basename = (p) => p.replace(/^.*\//, "");
const pad2 = (n) => String(n).padStart(2, "0");
const now = () => { const d = new Date(); return pad2(d.getHours()) + ":" + pad2(d.getMinutes()); };

// Barvy v Terminálu
const C = { gold: "\x1b[1;33m", text: "\x1b[0m", grey: "\x1b[90m", red: "\x1b[1;31m", green: "\x1b[32m", reset: "\x1b[0m" };
const say = (s, color) => P.out((color || "") + s + C.reset);
const status = (s) => say(`${now()}  ${s}`, C.grey);

// ============================================================================
// Cesty a nastavení
// ============================================================================
const FIELD_ORDER = ["title", "text", "objectives", "progress", "reward"];
const FIELD_LABELS = { title: "Název", text: "Popis", objectives: "Úkol", progress: "Průběh", reward: "Odměna" };
const SBERNA_URL = "https://wowpocesku-sberna.wowpocesku-sberna.workers.dev";
const RAW = "https://raw.githubusercontent.com/RankonRP/WoWpoCesku/main/";
const ZIP_URL = "https://codeload.github.com/RankonRP/WoWpoCesku/zip/refs/heads/main";
const UA = "WoWpoCesku-Pomocnik-Mac";

let ROOT = "";
let ONCE = false;
let S = {};           // nastavení
let Cache = {};       // questy
let Gossip = {};      // rozhovory
let Ui = {};          // texty rozhraní
let Rules = { words: [], regexes: [], stats: [], statRe: null };

const path = (name) => join(ROOT, name);

function readJson(p, fallback) {
  if (!P.exists(p)) return fallback;
  return JSON.parse(P.readText(p));
}

function saveSettings() { P.writeText(path("nastaveni.json"), JSON.stringify(S, null, 2) + "\n"); }

function loadSettings() {
  S = readJson(path("nastaveni.json"), null) || {};
  let changed = false;
  if (!S.prekladac) { S.prekladac = "google"; changed = true; }
  if (S.claude_api_klic === undefined) { S.claude_api_klic = ""; changed = true; }
  if (!S.claude_model) { S.claude_model = "claude-haiku-4-5"; changed = true; }
  if (S.prispivat === undefined || S.prispivat === null) {
    // První spuštění: zeptat se na přispívání do společné databáze (stejně jako Windows verze)
    S.prispivat = P.askYesNo(
      "Chceš pomáhat s překladem pro ostatní hráče?\n\n" +
      "Když narazíš na nepřeložený quest, Pomocník pošle jeho ANGLICKÝ text do společné sbírky. " +
      "Nic osobního se neposílá – jméno, třída a rasa postavy jsou nahrazené značkami.\n\n" +
      "Přeložené questy pak dostanou všichni hráči.\n\n" +
      "Volbu můžeš kdykoli změnit v souboru nastaveni.json (prispivat).",
      "WoWpoČesku – společná databáze");
    changed = true;
  }
  if (!/^[a-f0-9]{32}$/.test(S.klient_id || "")) {
    let id = "";
    try { id = P.sh("/usr/bin/openssl rand -hex 16 2>/dev/null || openssl rand -hex 16").trim(); } catch (e) { /* níže náhrada */ }
    if (!/^[a-f0-9]{32}$/.test(id)) { id = ""; for (let i = 0; i < 32; i++) id += Math.floor(Math.random() * 16).toString(16); }
    S.klient_id = id;
    changed = true;
  }
  if (changed) saveSettings();
}

// ============================================================================
// Složka hry a addonu
// ============================================================================
function isGameFolder(p) {
  return P.isDir(join(p, "Interface")) || P.exists(join(p, ".flavor.info"));
}

// …/World of Warcraft/_classic_beta_ – z nastavení, jinak podle nainstalovaného addonu
function findGameFolder() {
  if (S.slozka_hry && P.isDir(join(S.slozka_hry, "Interface", "AddOns", "WoWpoCesku"))) return S.slozka_hry;
  const bases = ["/Applications/World of Warcraft", join(P.home, "Applications", "World of Warcraft"), dirname(ROOT)];
  for (const base of bases) {
    if (!P.isDir(base)) continue;
    for (const name of P.list(base)) {
      if (!/^_.*_$/.test(name)) continue;
      const flavor = join(base, name);
      if (P.isDir(join(flavor, "Interface", "AddOns", "WoWpoCesku"))) {
        S.slozka_hry = flavor;
        saveSettings();
        return flavor;
      }
    }
  }
  return null;
}

function addonDir() {
  const g = findGameFolder();
  return g ? join(g, "Interface", "AddOns", "WoWpoCesku") : null;
}

// Verze hry (_classic_beta_, _classic_era_ …) ve složce World of Warcraft
function flavorsIn(base) {
  if (!P.isDir(base)) return [];
  return P.list(base).filter((n) => /^_.*_$/.test(n)).map((n) => join(base, n)).filter(isGameFolder);
}

// První spuštění: zkopírovat addon (složku WoWpoCesku vedle Pomocníka) do Interface/AddOns hry.
// Na Macu se kopíruje (ne odkaz) – Pomocník pak do kopie zapisuje překlady a aktualizace.
function installAddon() {
  const src = path("WoWpoCesku");
  if (!P.isDir(src)) return null;
  let flavors = [];
  for (const base of ["/Applications/World of Warcraft", join(P.home, "Applications", "World of Warcraft"), dirname(ROOT)]) {
    for (const f of flavorsIn(base)) if (!flavors.includes(f)) flavors.push(f);
  }
  if (!flavors.length) {
    const picked = P.chooseFolder("Vyber složku World of Warcraft (nebo přímo verzi hry, např. _classic_beta_)");
    if (!picked) return null;
    flavors = isGameFolder(picked) && /^_.*_$/.test(basename(picked)) ? [picked] : flavorsIn(picked);
    if (!flavors.length) { say("Ve vybrané složce jsem nenašel WoW: " + picked, C.red); return null; }
  }
  let game = flavors[0];
  if (flavors.length > 1) {
    const names = flavors.map(basename);
    const choice = P.chooseFromList(names, "Do které verze hry mám addon WoWpoČesku nainstalovat?", names.includes("_classic_beta_") ? "_classic_beta_" : names[0]);
    if (!choice) return null;
    game = flavors[names.indexOf(choice)];
  }
  const addons = join(game, "Interface", "AddOns");
  P.mkdirp(addons);
  P.sh(`cp -R ${q(src)} ${q(addons + "/")} && (xattr -dr com.apple.quarantine ${q(join(addons, "WoWpoCesku"))} 2>/dev/null; true)`);
  S.slozka_hry = game;
  saveSettings();
  say(`Addon WoWpoČesku je nainstalovaný do ${addons}. Ve hře ho na výběru postavy zaškrtni v AddOns.`, C.green);
  return game;
}

// ============================================================================
// Databáze překladů a Lua soubory (stejný formát jako pomocnik.ps1 / tools/soubory.js)
// ============================================================================
function writeJsonLines(p, obj, keys) {
  const lines = keys.map((k, i) => {
    const entry = {};
    for (const f of Object.keys(obj[k]).sort()) entry[f] = obj[k][f];
    return `  ${JSON.stringify(k)}: ${JSON.stringify(entry)}${i < keys.length - 1 ? "," : ""}`;
  });
  P.writeText(p, "{\n" + lines.join("\n") + "\n}\n");
}

const luaString = (s) => '"' + String(s).replace(/\\/g, "\\\\").replace(/"/g, '\\"').replace(/\r/g, "").replace(/\n/g, "\\n") + '"';
const gossipKey = (en) => (en || "").replace(/\s+/g, " ").trim();
const simple = (s) => (s || "").replace(/[\s\p{P}]/gu, "").toLowerCase();
const byNumber = (a, b) => a - b;

function loadDatabases() {
  Cache = readJson(path("preklady.json"), {});
  Gossip = readJson(path("rozhovory.json"), {});
  Ui = readJson(path("rozhrani.json"), {});
  for (const db of [Cache, Gossip, Ui]) {
    for (const k of Object.keys(db)) for (const f of Object.keys(db[k])) db[k][f] = String(db[k][f]);
  }
}

const saveCache = () => writeJsonLines(path("preklady.json"), Cache, Object.keys(Cache).sort(byNumber));
const saveGossip = () => writeJsonLines(path("rozhovory.json"), Gossip, Object.keys(Gossip).sort());
const saveUi = () => writeJsonLines(path("rozhrani.json"), Ui, Object.keys(Ui).sort());

function writeDataLua() {
  const dir = addonDir();
  if (!dir || !Object.keys(Cache).length) return;
  const out = [
    "-- Tento soubor generuje pomocnik.ps1. Neupravuj ho ručně – oprav překlad v preklady.json.",
    "WoWpoCesku_Data = {",
  ];
  for (const id of Object.keys(Cache).sort(byNumber)) {
    const e = Cache[id];
    const parts = FIELD_ORDER.filter((f) => e[f]).map((f) => `${f}=${luaString(e[f])}`);
    if (e.en_title) parts.push(`en=${luaString(e.en_title)}`);
    if (e.en_objectives && e.objectives) parts.push(`eo=${luaString(e.en_objectives)}`);
    if (parts.length) out.push(`[${id}]={${parts.join(",")}},`);
  }
  out.push("}");
  P.writeText(join(dir, "Data.lua"), out.join("\n") + "\n");
}

function writeTextLua(db, file, variable, source) {
  const dir = addonDir();
  if (!dir || !Object.keys(db).length) return;
  const out = [`-- Tento soubor generuje pomocnik.ps1. Neupravuj ho ručně – oprav překlad v ${source}.`, `${variable} = {`];
  for (const k of Object.keys(db).sort()) if (db[k].cs) out.push(`[${luaString(k)}]=${luaString(db[k].cs)},`);
  out.push("}");
  P.writeText(join(dir, file), out.join("\n") + "\n");
}
const writeGossipLua = () => writeTextLua(Gossip, "DataRozhovory.lua", "WoWpoCesku_Gossip", "rozhovory.json");
const writeUiLua = () => writeTextLua(Ui, "DataRozhrani.lua", "WoWpoCesku_UI", "rozhrani.json");

// ============================================================================
// Síť (přes curl – je součástí macOS)
// ============================================================================
let tmpCounter = 0;
function tmpFile(ext) {
  const dir = path(".tmp");
  if (!P.isDir(dir)) P.mkdirp(dir);
  return join(dir, `t${Date.now()}_${tmpCounter++}${ext || ""}`);
}

// GET: vrací { status, body, etag }. body jen při 200.
function httpGet(url, etag, timeout) {
  const body = tmpFile(), head = tmpFile();
  let cmd = `curl -sS -L --max-time ${timeout || 60} -A ${q(UA)} -D ${q(head)} -o ${q(body)} -w '%{http_code}'`;
  if (etag) cmd += ` -H ${q("If-None-Match: " + etag)}`;
  cmd += ` ${q(url)}`;
  try {
    const code = parseInt(P.sh(cmd).trim().slice(-3), 10) || 0;
    const headers = P.exists(head) ? P.readText(head) : "";
    const m = headers.match(/^etag:\s*(.+?)\s*$/gim);
    const tag = m ? m[m.length - 1].replace(/^etag:\s*/i, "").trim() : "";
    return { status: code, body: code === 200 && P.exists(body) ? P.readText(body) : "", etag: tag };
  } finally {
    P.remove(body); P.remove(head);
  }
}

// POST JSON: vrací { status, body }
function httpPostJson(url, data, headers, timeout) {
  const inFile = tmpFile(".json"), outFile = tmpFile();
  P.writeText(inFile, JSON.stringify(data));
  let cmd = `curl -sS --max-time ${timeout || 10} -A ${q(UA)} -H 'Content-Type: application/json; charset=utf-8'`;
  for (const h of headers || []) cmd += ` -H ${q(h)}`;
  cmd += ` --data-binary @${q(inFile)} -o ${q(outFile)} -w '%{http_code}' ${q(url)}`;
  try {
    const code = parseInt(P.sh(cmd).trim().slice(-3), 10) || 0;
    return { status: code, body: P.exists(outFile) ? P.readText(outFile) : "" };
  } finally {
    P.remove(inFile); P.remove(outFile);
  }
}

// ============================================================================
// Překladače a automatické úpravy (pravidla.json – stejná logika jako tools/pravidla.js)
// ============================================================================
const reEsc = (s) => s.replace(/[.*+?^${}()|[\]\\]/g, "\\$&");
const cap = (s) => s.charAt(0).toUpperCase() + s.slice(1);
const low = (s) => s.charAt(0).toLowerCase() + s.slice(1);

function loadRules() {
  Rules = { words: [], regexes: [], stats: [], statRe: null };
  const r = readJson(path("pravidla.json"), null);
  if (!r) return;
  let skipped = 0;
  for (const [from, to] of Object.entries(r.slova || {})) {
    for (const [a, b] of [[cap(from), cap(to)], [low(from), low(to)]]) {
      try { Rules.words.push([new RegExp(`(?<!\\p{L})${reEsc(a)}(?!\\p{L})`, "gu"), b]); } catch (e) { skipped++; }
    }
  }
  for (const x of r.regexy || []) {
    try { Rules.regexes.push([new RegExp(x.hledat, "gu"), x.nahradit]); } catch (e) { skipped++; }
  }
  Rules.stats = (r.staty || []).filter(Boolean).slice().sort((a, b) => b.length - a.length);
  if (Rules.stats.length) {
    try { Rules.statRe = new RegExp(`(?<!\\p{L})(${Rules.stats.map(reEsc).join("|")})(?!\\p{L})`, "gu"); } catch (e) { skipped++; }
  }
  if (skipped) say(`Upozornění: ${skipped} pravidel z pravidla.json nejde použít (starší macOS?).`, C.red);
}

function applyRules(t) {
  if (!t) return t;
  for (const [re, to] of Rules.words) t = t.replace(re, () => to);
  for (const [re, to] of Rules.regexes) t = t.replace(re, to);
  return t;
}
const protectStats = (t) => (!Rules.statRe || !t ? t : t.replace(Rules.statRe, (m) => "{" + (101 + Rules.stats.indexOf(m)) + "}"));
const restoreStats = (t) => (!t ? t : t.replace(/\{(1\d\d)\}/g, (m, n) => Rules.stats[n - 101] || m));

function googleTranslate(text) {
  if (!text || !text.trim()) return text;
  const inFile = tmpFile(".txt");
  P.writeText(inFile, text);
  try {
    const out = P.sh(`curl -sS --max-time 30 -A 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7)' ` +
      `-H 'Content-Type: application/x-www-form-urlencoded;charset=UTF-8' --data-urlencode ${q("q@" + inFile)} ` +
      `'https://clients5.google.com/translate_a/t?client=dict-chrome-ex&sl=en&tl=cs'`);
    let j = JSON.parse(out);
    let first = Array.isArray(j) ? j[0] : j;
    if (Array.isArray(first)) first = first[0];
    if (typeof first !== "string") throw new Error("Neočekávaná odpověď Google překladače: " + out.slice(0, 200));
    return first;
  } finally {
    P.remove(inFile);
  }
}

function claudeTranslate(fields) {
  const key = S.claude_api_klic;
  if (!key) throw new Error("Chybí Claude API klíč – doplň ho do nastaveni.json (claude_api_klic).");
  const glossary = P.exists(path("slovnicek.txt")) ? P.readText(path("slovnicek.txt")) : "";
  const system = "Překládáš texty questů z World of Warcraft z angličtiny do češtiny.\n" +
    "Dostaneš JSON objekt, kde každá hodnota je text k překladu. Vrať POUZE JSON objekt se stejnými klíči a přeloženými hodnotami, bez dalšího textu a bez markdownu.\n" +
    "Zachovej zástupný znak {N} (jméno hráče), zalomení řádků a čísla. Překládej přirozeně a čtivě, drž styl fantasy příběhu.\n" +
    "Řiď se tímto slovníčkem a pravidly:\n" + glossary;
  const r = httpPostJson("https://api.anthropic.com/v1/messages", {
    model: S.claude_model || "claude-haiku-4-5",
    max_tokens: 4096,
    system,
    messages: [{ role: "user", content: JSON.stringify(fields, null, 2) }],
  }, ["x-api-key: " + key, "anthropic-version: 2023-06-01"], 120);
  if (r.status !== 200) throw new Error(`Claude API: HTTP ${r.status} ${r.body.slice(0, 300)}`);
  let txt = JSON.parse(r.body).content[0].text.trim().replace(/^```(json)?\s*/, "").replace(/\s*```$/, "");
  const obj = JSON.parse(txt);
  const out = {};
  for (const k of Object.keys(fields)) out[k] = String(obj[k] == null ? "" : obj[k]);
  return out;
}

function translate(fields) {
  let out;
  if (S.prekladac === "claude") out = claudeTranslate(fields);
  else { out = {}; for (const k of Object.keys(fields)) out[k] = googleTranslate(fields[k]); }
  for (const k of Object.keys(out)) out[k] = applyRules(out[k]);
  return out;
}

// ============================================================================
// Společná sběrna
// ============================================================================
function sbernaPost(route, data) {
  if (!S.prispivat) return false;
  try {
    const r = httpPostJson(SBERNA_URL + route, data, [], 10);
    if (r.status === 200) return true;
    if (r.status === 429) status("Sběrna: denní limit odeslaných textů je vyčerpaný, zkusí se to zítra.");
    return false;
  } catch (e) {
    return false;
  }
}
const sendQuest = (id, fields) => sbernaPost("/submit", { id: parseInt(id, 10), client: S.klient_id, fields });

// ============================================================================
// Stahování překladů z GitHubu
// ============================================================================
function readEtag(name) { const p = path(name); return P.exists(p) ? P.readText(p).trim() : ""; }
function writeEtag(name, tag) { if (tag) P.writeText(path(name), tag); }

function updateQuestsFromGitHub() {
  const r = httpGet(RAW + "preklady.json", readEtag(".preklady.etag"), 120);
  if (r.status === 304) return 0;
  if (r.status !== 200) throw new Error("GitHub: HTTP " + r.status);
  const remote = JSON.parse(r.body.replace(/^﻿/, ""));
  let changed = 0;
  for (const id of Object.keys(remote)) {
    const h = {};
    for (const k of Object.keys(remote[id])) h[k] = String(remote[id][k]);
    const local = Cache[id];
    // Lokální překlad z novějšího textu ve hře (jiný anglický originál) ponech, dokud ho nezpracuje sběrna
    const sameSource = local && simple(local.en_title) === simple(h.en_title) && simple(local.en_text) === simple(h.en_text);
    const useRemote = !local || local.pre === "1" || sameSource;
    if (!useRemote) continue;
    // Vlastní oprava čeká na schválení -> nepřepisovat, dokud GitHub nemá stejný text
    if (local && local.opraveno === "1" && FIELD_ORDER.some((f) => local[f] && local[f] !== h[f])) continue;
    const a = Object.keys(h).sort().map((k) => `${k}=${h[k]}`).join("\n");
    const b = local ? Object.keys(local).sort().map((k) => `${k}=${local[k]}`).join("\n") : "";
    if (a !== b) { Cache[id] = h; changed++; }
  }
  if (changed) { saveCache(); writeDataLua(); }
  writeEtag(".preklady.etag", r.etag);
  return changed;
}

function updateDictFromGitHub(file, etagName, db, save) {
  const r = httpGet(RAW + file, readEtag(etagName), 60);
  if (r.status === 304 || r.status === 404) return 0;
  if (r.status !== 200) throw new Error("GitHub: HTTP " + r.status);
  const remote = JSON.parse(r.body.replace(/^﻿/, "")) || {};
  let changed = 0;
  for (const k of Object.keys(remote)) {
    const e = {};
    for (const f of Object.keys(remote[k])) e[f] = String(remote[k][f]);
    if (!db[k] || db[k].cs !== e.cs) { db[k] = e; changed++; }
  }
  if (changed) save();
  writeEtag(etagName, r.etag);
  return changed;
}

function syncFromGitHub() {
  let n = updateQuestsFromGitHub();
  try { n += updateDictFromGitHub("rozhovory.json", ".rozhovory.etag", Gossip, () => { saveGossip(); writeGossipLua(); }); } catch (e) { /* další pokus za hodinu */ }
  try { n += updateDictFromGitHub("rozhrani.json", ".rozhrani.etag", Ui, () => { saveUi(); writeUiLua(); }); } catch (e) { /* další pokus za hodinu */ }
  return n;
}

// ============================================================================
// Aktualizace addonu z GitHubu
// ============================================================================
function parseVersion(v) { return String(v || "0").trim().split(".").map((x) => parseInt(x, 10) || 0); }
function versionGreater(a, b) {
  const x = parseVersion(a), y = parseVersion(b);
  for (let i = 0; i < Math.max(x.length, y.length); i++) {
    if ((x[i] || 0) !== (y[i] || 0)) return (x[i] || 0) > (y[i] || 0);
  }
  return false;
}
function localVersion() {
  const p = path("verze.txt");
  return P.exists(p) ? P.readText(p).split(/\r?\n/)[0].trim() : "0.0.0";
}

// Ve vývojové kopii (git klon) se neaktualizuje – tam se aktualizuje přes git
function checkAddonUpdate() {
  if (P.exists(path(".git"))) return null;
  const r = httpGet(RAW + "verze.txt?t=" + Date.now(), "", 20);
  if (r.status !== 200) return null;
  const lines = r.body.split(/\r?\n/).map((s) => s.trim());
  if (!versionGreater(lines[0], localVersion())) return null;
  return { version: lines[0], restartGame: lines.includes("restartovat-hru") };
}

// Stáhne balíček z GitHubu a přepíše addon ve hře i soubory Pomocníka.
// Data a nastavení hráče nepřepisuje. Vrací true, když se změnil i samotný Pomocník (je potřeba ho spustit znovu).
function installAddonUpdate() {
  const dir = addonDir();
  if (!dir) throw new Error("Nenašel jsem addon WoWpoCesku ve složce hry.");
  const work = path(".tmp/aktualizace");
  P.remove(work);
  P.mkdirp(work);
  P.sh(`curl -fsS -L --max-time 180 -A ${q(UA)} -o ${q(work + "/a.zip")} ${q(P.zipUrl || ZIP_URL)} && cd ${q(work)} && /usr/bin/unzip -q -o a.zip`);
  const src = P.list(work).map((n) => join(work, n)).find((p) => P.isDir(join(p, "WoWpoCesku")));
  if (!src) throw new Error("Stažený balíček nemá očekávaný obsah.");
  const self = path("pomocnik-mac.js");
  const before = P.exists(self) ? P.readText(self) : "";
  // Addon ve hře: přepsat kód; data (Data*.lua) se hned vygenerují z místních databází
  P.sh(`cp -R ${q(src + "/WoWpoCesku/")}. ${q(dir + "/")}`);
  // Kopie addonu vedle Pomocníka (z ní se instaluje do hry)
  if (P.isDir(path("WoWpoCesku"))) P.sh(`cp -R ${q(src + "/WoWpoCesku/")}. ${q(path("WoWpoCesku") + "/")}`);
  // Soubory Pomocníka: vždy; databáze překladů jen když chybí
  for (const f of ["pomocnik-mac.js", "Spustit pomocnika.command", "NAVOD-MAC.txt", "pravidla.json", "slovnicek.txt", "filtr.json", "NAVOD.txt"]) {
    if (P.exists(join(src, f))) P.sh(`cp ${q(join(src, f))} ${q(path(f))}`);
  }
  for (const f of ["preklady.json", "rozhovory.json", "rozhrani.json"]) {
    if (!P.exists(path(f)) && P.exists(join(src, f))) P.sh(`cp ${q(join(src, f))} ${q(path(f))}`);
  }
  P.sh(`cp ${q(join(src, "verze.txt"))} ${q(path("verze.txt"))}`);
  P.sh(`chmod +x ${q(path("Spustit pomocnika.command"))} 2>/dev/null; xattr -dr com.apple.quarantine ${q(ROOT)} ${q(dir)} 2>/dev/null; true`);
  P.remove(work);
  loadDatabases();
  loadRules();
  writeDataLua(); writeGossipLua(); writeUiLua();
  return P.exists(self) && P.readText(self) !== before;
}

// Verze hry (…/World of Warcraft/.build.info) -> číslo rozhraní v WoWpoCesku.toc (1.60.1 -> 16001)
function updateAddonInterface() {
  const game = findGameFolder();
  if (!game) return null;
  const buildInfo = join(dirname(game), ".build.info");
  const flavorInfo = join(game, ".flavor.info");
  if (!P.exists(buildInfo) || !P.exists(flavorInfo)) return null;
  const flavor = P.readText(flavorInfo).split(/\r?\n/).filter((s) => s.trim()).pop().trim();
  const lines = P.readText(buildInfo).split(/\r?\n/).filter((s) => s.length);
  const cols = lines[0].split("|").map((c) => c.split("!")[0]);
  const iVer = cols.indexOf("Version"), iProd = cols.indexOf("Product");
  if (iVer < 0 || iProd < 0) return null;
  const row = lines.slice(1).map((l) => l.split("|")).find((r) => r[iProd] === flavor);
  if (!row) return null;
  const version = row[iVer];
  const p = version.split(".");
  if (p.length < 3) return null;
  const iface = parseInt(p[0], 10) * 10000 + parseInt(p[1], 10) * 100 + parseInt(p[2], 10);
  const toc = join(addonDir(), "WoWpoCesku.toc");
  const text = P.readText(toc);
  const m = text.match(/^## Interface:\s*(.+?)\s*$/m);
  if (!m) return null;
  const known = m[1].split(",").map((s) => s.trim());
  let changed = false;
  if (!known.includes(String(iface))) {
    P.writeText(toc, text.replace(m[0], `## Interface: ${iface}, ${known.join(", ")}`));
    changed = true;
  }
  return { version, iface, changed };
}

// ============================================================================
// Mezipaměť questů hry (Cache/WDB/enUS/questcache.wdb) – stejná logika jako tools/wdb.js
// ============================================================================
const WDB_BITS = [9, 12, 12, 9, 10, 8, 10, 8, 11];

function readBits(b, off, end) {
  let bit = 0;
  const out = [];
  for (const w of WDB_BITS) {
    let v = 0;
    for (let i = 0; i < w; i++, bit++) {
      const idx = off + (bit >> 3);
      if (idx >= end) return null;
      v = (v << 1) | ((b[idx] >> (7 - (bit & 7))) & 1);
    }
    out.push(v);
  }
  return out;
}

const printable = (s) => s.length > 0 && !/[\x00-\x08\x0e-\x1f�]/.test(s);

function parseWdbRecord(b, start, len) {
  const end = start + len;
  for (let p = 0; p + 12 < len; p++) {
    const L = readBits(b, start + p, end);
    if (!L || L[0] < 2 || L[0] > 300) continue;
    const s0 = start + p + 12;
    if (s0 + L.reduce((a, x) => a + x, 0) > end) continue;
    const strs = [];
    let o = s0, ok = true;
    for (const n of L) {
      const s = decodeUtf8(b, o, n);
      if (s === null || (n > 0 && !printable(s))) { ok = false; break; }
      strs.push(s);
      o += n;
    }
    if (!ok || !/^[A-Za-z0-9"'(\[]/.test(strs[0])) continue;
    return { title: strs[0], objectives: strs[1], text: strs[2] };
  }
  return null;
}

function serverText(t) {
  return (t || "")
    .replace(/\r\n?/g, "\n")
    .replace(/\$[Bb]/g, "\n")
    .replace(/\$[Nn]/g, "{N}")
    .replace(/\$[Cc]/g, "{C}")
    .replace(/\$[Rr]/g, "{R}")
    .replace(/\$[Gg]\s*([^:;]*):([^;]*);/g, "$1/$2")
    .replace(/\$\d+o[a-z]*\s?/g, "")
    .trim();
}

function readQuestCache(file) {
  const b = P.readBytes(file);
  const quests = {};
  if (b.length < 24 || String.fromCharCode(b[0], b[1], b[2], b[3]) !== "TSQW") return quests;
  const u32 = (o) => (b[o] | (b[o + 1] << 8) | (b[o + 2] << 16) | (b[o + 3] << 24)) >>> 0;
  let o = 24;
  while (o + 8 <= b.length) {
    const id = u32(o), len = u32(o + 4);
    if (!len || o + 8 + len > b.length) break;
    const r = parseWdbRecord(b, o + 8, len);
    if (r) quests[id] = { title: serverText(r.title), objectives: serverText(r.objectives), text: serverText(r.text) };
    o += 8 + len;
  }
  return quests;
}

// Nové questy z mezipaměti: pošle do sběrny (max maxSend) a pár rovnou přeloží (max maxTranslate)
function importGameCache(maxTranslate, maxSend) {
  const game = findGameFolder();
  if (!game) return null;
  const file = join(game, "Cache", "WDB", "enUS", "questcache.wdb");
  if (!P.exists(file)) return null;
  const stamp = P.mtime(file);
  if (S.cache_cas === stamp) return null;

  const sentPath = path(".cache-odeslano");
  const sent = new Set(P.exists(sentPath) ? P.readText(sentPath).split(/\r?\n/).filter(Boolean) : []);
  const quests = readQuestCache(file);
  let translated = 0, sentN = 0, left = 0;
  for (const id of Object.keys(quests)) {
    const fields = quests[id];
    let entry = Cache[id];
    const missing = {};
    for (const k of ["title", "objectives", "text"]) if (fields[k] && (!entry || !entry[k])) missing[k] = fields[k];
    if (!Object.keys(missing).length) continue;

    if (S.prispivat && !sent.has(id) && sentN < maxSend) {
      const body = {};
      for (const k of ["title", "objectives", "text"]) if (fields[k]) body[k] = fields[k];
      if (sendQuest(id, body)) { sent.add(id); sentN++; }
    }
    if (translated < maxTranslate) {
      const tr = translate(missing);
      if (!entry) { entry = {}; Cache[id] = entry; }
      for (const k of Object.keys(missing)) { entry[k] = tr[k]; entry["en_" + k] = missing[k]; }
      if (!entry.src) entry.src = "cache";
      translated++;
    } else {
      left++;
    }
  }
  if (translated) { saveCache(); writeDataLua(); }
  P.writeText(sentPath, [...sent].join("\n") + "\n");
  if (!left) { S.cache_cas = stamp; saveSettings(); }
  return { translated, sent: sentN, left };
}

// ============================================================================
// Zpráva z addonu (schránka nebo fronta)
//   CZQ#<id>#<detail|progress|reward>[#oprava] | CZG#<id NPC> | CZU#1
//   ##title / ##text / ##objectives / ##progress / ##reward / ##gossip / ##ui
// ============================================================================
function parsePayload(s) {
  const lines = s.replace(/\r\n?/g, "\n").split("\n");
  const m = lines[0].trim().match(/^CZ([QGU])#(\d+)(?:#(\w+))?(#oprava)?$/);
  if (!m || lines.length < 2) return null;
  const qd = { kind: m[1] === "G" ? "gossip" : m[1] === "U" ? "ui" : "quest", id: m[2], part: m[3] || "", oprava: !!m[4], fields: {} };
  let cur = null, buf = [];
  for (const line of lines.slice(1)) {
    const f = line.match(/^##(title|text|objectives|progress|reward|gossip|ui)\s*$/);
    if (f) {
      if (cur) qd.fields[cur] = buf.join("\n").trim();
      cur = f[1];
      buf = [];
    } else buf.push(line);
  }
  if (cur) qd.fields[cur] = buf.join("\n").trim();
  return qd;
}

const forDisplay = (s) => (s || "").replace(/\{N\}/g, "hrdino").replace(/\{C\}/g, "(tvá třída)").replace(/\{R\}/g, "(tvá rasa)");

function showQuest(qd, entry) {
  say("");
  say("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━", C.grey);
  say(forDisplay(entry.title || qd.fields.title), C.gold);
  say(`Quest #${qd.id}`, C.grey);
  for (const f of FIELD_ORDER) {
    if (f === "title" || !(f in qd.fields)) continue;
    say("");
    if (f !== "text") say(FIELD_LABELS[f] + ":", C.gold);
    say(forDisplay(entry[f]), C.text);
  }
  say("");
}

function handleGossip(qd, quiet) {
  const en = qd.fields.gossip;
  if (!en) return false;
  const key = gossipKey(en);
  let entry = Gossip[key];
  let did = false;
  if (entry && entry.cs) {
    if (!quiet) status("Z uložených překladů. (Pokud ho addon neukazuje, napiš ve hře /reload.)");
  } else {
    const tr = translate({ gossip: en });
    entry = { cs: tr.gossip, en, npc: String(qd.id), src: "lokalne" };
    Gossip[key] = entry;
    saveGossip();
    writeGossipLua();
    const sent = parseInt(qd.id, 10) > 0 && sendQuest(qd.id, { gossip: en }) ? " Odesláno do společné sbírky." : "";
    status(`Rozhovor uložen (${Object.keys(Gossip).length} rozhovorů). Ve hře napiš /reload.${sent}`);
    did = true;
  }
  if (!quiet) {
    say("");
    say(qd.fields.title || "", C.gold);
    say(parseInt(qd.id, 10) === 1 ? "Kniha / dopis" : `Rozhovor s NPC #${qd.id}`, C.grey);
    say(forDisplay(entry.cs), C.text);
    say("");
  }
  return did;
}

function handleUi(qd) {
  const en = qd.fields.ui;
  if (!en) return false;
  const key = gossipKey(en);
  if (Ui[key] && Ui[key].cs) return false;
  const tr = translate({ ui: protectStats(key) });
  Ui[key] = { cs: restoreStats(tr.ui), en: key, src: "lokalne" };
  saveUi();
  writeUiLua();
  sbernaPost("/submit", { id: 1, client: S.klient_id, fields: { ui: key } });
  return true;
}

// quiet = zpracování z fronty ze hry: nic nevypisovat, jen přeložit, uložit a poslat
function handlePayload(text, quiet) {
  const qd = parsePayload(text);
  if (!qd) return false;
  if (qd.kind === "gossip") return handleGossip(qd, quiet);
  if (qd.kind === "ui") return handleUi(qd);

  let entry = Cache[qd.id];
  if (!entry) { entry = {}; Cache[qd.id] = entry; }
  const missing = {};
  for (const k of Object.keys(qd.fields)) {
    if (!qd.fields[k]) continue;
    // Chybí překlad, nebo se anglický text ve hře liší od toho, ze kterého se překládalo
    if (!entry[k] || simple(entry["en_" + k]) !== simple(qd.fields[k])) missing[k] = qd.fields[k];
  }
  let did = false;
  if (Object.keys(missing).length) {
    if (!quiet) status(`Překládám quest #${qd.id}…`);
    const tr = translate(missing);
    for (const k of Object.keys(missing)) { entry[k] = tr[k]; entry["en_" + k] = missing[k]; }
    saveCache();
    writeDataLua();
    const sent = sendQuest(qd.id, qd.fields) ? " Odesláno do společné sbírky." : "";
    status(`Quest #${qd.id} uložen (${Object.keys(Cache).length} questů). Ve hře napiš /reload.${sent}`);
    did = true;
  } else if (!Object.keys(entry).length) {
    delete Cache[qd.id];
  } else if (!quiet) {
    status("Z uložených překladů. (Pokud ho addon neukazuje, napiš ve hře /reload.)");
  }
  if (!quiet) {
    showQuest(qd, entry);
    if (qd.oprava) status("Opravu překladu v Mac verzi Pomocníka udělat nejde – oprav text v souboru preklady.json.");
  }
  return did;
}

// ============================================================================
// Fronta ze hry: addon ukládá nepřeložené texty do WoWpoCeskuQueue (SavedVariables),
// hra je zapíše při /reload nebo odhlášení do WTF/Account/<účet>/SavedVariables/WoWpoCesku.lua
// ============================================================================
let queueDone = null;
const queueStamps = {};

function queueFiles() {
  const game = findGameFolder();
  if (!game) return [];
  const found = [];
  const walk = (dir, depth) => {
    for (const name of P.list(dir)) {
      const p = join(dir, name);
      if (name === "WoWpoCesku.lua" && basename(dir) === "SavedVariables") found.push(p);
      else if (depth < 4 && !name.includes(".") && P.isDir(p)) walk(p, depth + 1);
    }
  };
  const acc = join(game, "WTF", "Account");
  if (P.isDir(acc)) walk(acc, 0);
  return found;
}

function readQueueFile(p) {
  const text = P.readText(p);
  const m = text.match(/^WoWpoCeskuQueue\s*=\s*\{([\s\S]*?)^\}/m);
  if (!m) return [];
  const items = [];
  const re = /\["(?:[^"\\]|\\.)*"\]\s*=\s*"((?:[^"\\]|\\.)*)"/g;
  let e;
  while ((e = re.exec(m[1]))) {
    items.push(e[1].replace(/\\(n|"|\\|\d{1,3})/g, (x, g) => (g === "n" ? "\n" : g === '"' ? '"' : g === "\\" ? "\\" : String.fromCharCode(parseInt(g, 10)))));
  }
  return items;
}

function processGameQueue() {
  const donePath = path(".fronta-zpracovano");
  if (!queueDone) queueDone = new Set(P.exists(donePath) ? P.readText(donePath).split(/\r?\n/).filter(Boolean) : []);
  let count = 0, touched = false;
  for (const f of queueFiles()) {
    const stamp = P.mtime(f);
    if (queueStamps[f] === stamp) continue;
    queueStamps[f] = stamp;
    for (const payload of readQueueFile(f)) {
      const h = hashText(payload);
      if (queueDone.has(h)) continue;
      try {
        if (handlePayload(payload, true)) count++;
        queueDone.add(h);
        touched = true;
      } catch (e) {
        status("Text z fronty se nepodařilo přeložit: " + e.message + " (zkusí se znovu)");
        delete queueStamps[f];
      }
    }
  }
  if (touched) P.writeText(donePath, [...queueDone].join("\n") + "\n");
  return count;
}

// ============================================================================
// Start a smyčka
// ============================================================================
function safely(label, fn) {
  try { return fn(); } catch (e) { status(`${label}: ${e.message || e}`); return null; }
}

function startup() {
  let restartNeeded = false;
  say("WoWpoČesku – Pomocník pro Mac", C.gold);
  loadSettings();
  let game = findGameFolder();
  if (!game) game = safely("Instalace addonu", installAddon);
  if (!game) {
    say("Nenašel jsem hru ani addon WoWpoCesku (/Applications/World of Warcraft/_…_/Interface/AddOns).", C.red);
    say("Zkontroluj, že máš nainstalovaný World of Warcraft, a spusť Pomocníka znovu.", C.red);
    return false;
  }
  status("Složka hry: " + game);
  loadDatabases();
  loadRules();
  safely("Zápis Lua souborů", () => { writeDataLua(); writeGossipLua(); writeUiLua(); });
  status(`Přispívání do společné sbírky: ${S.prispivat ? "zapnuto" : "vypnuto"} (nastaveni.json → prispivat)`);

  // Nová verze addonu?
  safely("Kontrola nové verze", () => {
    const upd = checkAddonUpdate();
    if (!upd) return;
    status(`Instaluji novou verzi addonu ${upd.version} (máš ${localVersion()})…`);
    const helperChanged = installAddonUpdate();
    const inGame = upd.restartGame ? "Pokud máš spuštěnou hru, RESTARTUJ ji (/reload tentokrát nestačí)." : "Pokud máš spuštěnou hru, napiš ve hře /reload.";
    say(`Addon aktualizován na verzi ${upd.version}. ${inGame}`, C.green);
    P.notify("WoWpoČesku", `Addon aktualizován na ${upd.version}`);
    if (helperChanged) restartNeeded = true;
  });
  if (restartNeeded) {
    say("Aktualizoval se i Pomocník – zavři toto okno a spusť „Spustit pomocnika.command“ znovu.", C.green);
    return false;
  }

  // Nové překlady od ostatních hráčů
  safely("Stažení nových překladů", () => {
    status("Kontroluji nové překlady na GitHubu…");
    const n = syncFromGitHub();
    status(n ? `Staženo ${n} nových/lepších překladů. Ve hře napiš /reload.` : "Překlady jsou aktuální.");
  });

  // Patch hry -> číslo rozhraní v .toc
  safely("Kontrola verze hry", () => {
    const gi = updateAddonInterface();
    if (gi && gi.changed) say(`Hra se aktualizovala na ${gi.version} – addon jsem upravil. Pokud máš spuštěnou hru, RESTARTUJ ji.`, C.green);
  });

  // Nové questy z mezipaměti hry
  safely("Mezipaměť hry", () => {
    status("Hledám nové questy v mezipaměti hry…");
    const c = importGameCache(20, 100);
    if (c && (c.translated || c.sent)) status(`Z mezipaměti hry: přeloženo ${c.translated}, odesláno ${c.sent} questů. Ve hře napiš /reload.`);
  });

  safely("Fronta ze hry", () => {
    const n = processGameQueue();
    if (n) status(`Ze hry přeloženo ${n} textů. Ve hře napiš /reload.`);
  });
  say(`Přeložených questů: ${Object.keys(Cache).length}, rozhovorů: ${Object.keys(Gossip).length}`, C.grey);
  return true;
}

function loop() {
  say("");
  say("Pomocník běží. Nepřeložený quest: ve hře klikni na „Načíst překlady (/reload)“, nebo text zkopíruj (Cmd+C).", C.text);
  say("Ukončení: Ctrl+C nebo zavři toto okno.", C.grey);
  status("Čekám na quest ze hry…");
  let lastClipCount = P.clipboardCount();
  let lastClip = "";
  let nextQueue = Date.now() + 20 * 1000;
  let nextSync = Date.now() + 60 * 60 * 1000;
  for (;;) {
    P.sleep(0.5);
    // Schránka
    const cc = P.clipboardCount();
    if (cc !== lastClipCount) {
      lastClipCount = cc;
      const clip = P.clipboardText();
      if (clip && clip !== lastClip && (clip.startsWith("CZQ#") || clip.startsWith("CZG#"))) {
        lastClip = clip;
        try { handlePayload(clip, false); } catch (e) {
          say("Překlad se nepovedl: " + (e.message || e), C.red);
          status("Zkus quest zkopírovat znovu.");
          lastClip = "";
        }
      }
    }
    // Fronta ze hry (každých 20 s)
    if (Date.now() >= nextQueue) {
      nextQueue = Date.now() + 20 * 1000;
      safely("Fronta ze hry", () => {
        const n = processGameQueue();
        if (n) { status(`Ze hry přeloženo ${n} textů. Ve hře napiš /reload.`); P.notify("WoWpoČesku", `Přeloženo ${n} textů – ve hře napiš /reload`); }
      });
    }
    // Každou hodinu: nové překlady, mezipaměť hry, nová verze
    if (Date.now() >= nextSync) {
      nextSync = Date.now() + 60 * 60 * 1000;
      safely("Stažení nových překladů", () => { const n = syncFromGitHub(); if (n) status(`Staženo ${n} nových překladů. Ve hře napiš /reload.`); });
      safely("Mezipaměť hry", () => {
        const c = importGameCache(20, 100);
        if (c && (c.translated || c.sent)) status(`Z mezipaměti hry: přeloženo ${c.translated}, odesláno ${c.sent} questů. Ve hře napiš /reload.`);
      });
      safely("Kontrola nové verze", () => { const u = checkAddonUpdate(); if (u) status(`Je nová verze addonu ${u.version} – zavři a znovu spusť Pomocníka.`); });
    }
  }
}

function main(argv) {
  const args = (argv || []).filter((a) => a !== "--jednou");
  ONCE = (argv || []).includes("--jednou");
  ROOT = (args.find((a) => a && !/\.js$/.test(a)) || "").replace(/\/+$/, "");
  if (!ROOT) {
    const self = P.args.find((a) => /pomocnik-mac\.js$/.test(a));
    ROOT = self ? dirname(self) : "";
  }
  if (!ROOT || !P.isDir(ROOT)) { say("Spusť přes „Spustit pomocnika.command“ (chybí složka Pomocníka).", C.red); return; }
  P.remove(path(".tmp"));
  if (!startup()) return;
  if (ONCE) { status("Hotovo (--jednou)."); return; }
  loop();
}

// JXA spouští funkci run(argv); v Node se spustí main přímo
function run(argv) { main(argv); }
if (!IS_JXA && typeof module !== "undefined" && require.main === module) main(process.argv.slice(2));
if (!IS_JXA && typeof module !== "undefined") module.exports = { P, parsePayload, readQueueFile, readQuestCache, decodeUtf8, base64ToBytes, hashText, loadRules, applyRules, protectStats, restoreStats, _setRoot: (r) => { ROOT = r; } };

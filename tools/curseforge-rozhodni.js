// Rozhodne, jestli se má vydat nová verze na CurseForge.
// Vydává se, když od poslední značky cf-* přibylo >= PRAH překladů,
// nebo uplynulo 7 dní a přibylo aspoň MIN_TYDEN překladů (nebo je VYNUTIT=1).
// Výstup pro GitHub Actions: vydat, verze, znacka, nazev, changelog.
const fs = require("fs");
const path = require("path");
const { execSync } = require("child_process");

const ROOT = path.join(__dirname, "..");
const PRAH = parseInt(process.env.PRAH || "100", 10);
const MIN_TYDEN = parseInt(process.env.MIN_TYDEN || "1", 10);
const VYNUTIT = process.env.VYNUTIT === "1";
const SOUBORY = ["data/preklady.json", "data/rozhovory.json", "data/rozhrani.json"];

const git = (a) => execSync("git " + a, { cwd: ROOT, encoding: "utf8", maxBuffer: 1 << 28 }).trim();
const parse = (s) => JSON.parse(s.replace(/^﻿/, ""));

function posledniZnacka() {
    try { return git('describe --tags --match "cf-*" --abbrev=0'); } catch { return ""; }
}
function klice(file, ref) {
    try {
        const text = ref ? git(`show ${ref}:${file}`) : fs.readFileSync(path.join(ROOT, file), "utf8");
        return new Set(Object.keys(parse(text)));
    } catch { return new Set(); }
}

const znacka = posledniZnacka();
let nove = 0;
const popis = [];
for (const f of SOUBORY) {
    const dnes = klice(f, null), drive = znacka ? klice(f, znacka) : new Set();
    let n = 0;
    for (const k of dnes) if (!drive.has(k)) n++;
    nove += n;
    popis.push(`${path.basename(f, ".json")}: +${n}`);
}

let dni = 999;
if (znacka) {
    const t = parseInt(git(`log -1 --format=%ct ${znacka}`), 10);
    dni = (Date.now() / 1000 - t) / 86400;
}

const vydat = !znacka || VYNUTIT || nove >= PRAH || (dni >= 7 && nove >= MIN_TYDEN);

const toc = fs.readFileSync(path.join(ROOT, "WoWpoCesku", "WoWpoCesku.toc"), "utf8");
const tocVer = (toc.match(/^## Version:\s*(\S+)/m) || [])[1] || "0";
const d = new Date();
const datum = d.toISOString().slice(0, 10);
const cas = d.toISOString().slice(11, 16).replace(":", "");
const verze = `${tocVer}-${datum.replace(/-/g, "")}`;
const nazev = `WoWpoCesku ${tocVer} (${datum})`;
const changelog = `Update ${datum}: ${nove} new translations (${popis.join(", ")}).`;

console.log(`posledni znacka: ${znacka || "(zadna)"}, novych: ${nove}, dni: ${dni.toFixed(1)}, vydat: ${vydat}`);
const out = process.env.GITHUB_OUTPUT;
const radky = [`vydat=${vydat ? 1 : 0}`, `verze=${verze}`, `znacka=cf-${datum}-${cas}`, `nazev=${nazev}`, `changelog=${changelog}`];
if (out) fs.appendFileSync(out, radky.join("\n") + "\n");
else console.log(radky.join("\n"));

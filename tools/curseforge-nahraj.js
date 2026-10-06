// Nahraje zip na CurseForge přes Upload API (vyžaduje CF_TOKEN a CF_PROJECT_ID).
// Použití: node tools/curseforge-nahraj.js dist/WoWpoCesku-<verze>.zip
const fs = require("fs");
const path = require("path");

const TOKEN = process.env.CF_TOKEN;
const PROJECT = process.env.CF_PROJECT_ID;
const BASE = "https://wow.curseforge.com/api";
const zip = process.argv[2];
if (!TOKEN || !PROJECT || !zip) { console.error("Chybí CF_TOKEN, CF_PROJECT_ID nebo cesta k zipu."); process.exit(1); }

(async () => {
    // ID verze hry 1.60.1 (WoW Forever) zjistíme z API
    const res = await fetch(`${BASE}/game/versions`, { headers: { "X-Api-Token": TOKEN } });
    if (!res.ok) throw new Error(`game/versions: HTTP ${res.status}`);
    const verze = await res.json();
    const hledana = verze.filter((v) => v.name === "1.60.1");
    if (!hledana.length) throw new Error("Verze hry 1.60.1 nenalezena v seznamu CurseForge.");
    // kdyby jich bylo víc, bereme tu ze skupiny Forever (název skupiny není v odpovědi vždy, tak všechny shody s tímto jménem)
    const gameVersions = hledana.map((v) => v.id);

    const metadata = {
        changelog: process.env.CHANGELOG || "Update",
        changelogType: "text",
        displayName: process.env.NAZEV || path.basename(zip, ".zip"),
        gameVersions,
        releaseType: "release",
    };
    const form = new FormData();
    form.append("metadata", JSON.stringify(metadata));
    form.append("file", new Blob([fs.readFileSync(zip)]), path.basename(zip));

    const up = await fetch(`${BASE}/projects/${PROJECT}/upload-file`, { method: "POST", headers: { "X-Api-Token": TOKEN }, body: form });
    const txt = await up.text();
    if (!up.ok) { console.error(`Nahrání selhalo: HTTP ${up.status} ${txt}`); process.exit(1); }
    console.log("Nahráno:", txt);
})().catch((e) => { console.error(e.message); process.exit(1); });

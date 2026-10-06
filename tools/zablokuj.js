// Úklid po vandalovi (spouští správce na svém PC).
//   node tools/zablokuj.js kdo <quest_id>     -> kdo k questu poslal texty a opravy
//   node tools/zablokuj.js blokuj <klient_id> -> zablokuje hráče (i jeho IP) a zahodí, co poslal
//   node tools/zablokuj.js vrat <quest_id>    -> vrátí předchozí verzi překladu questu z historie gitu
//                                               (pak je potřeba změnu commitnout a pushnout)
// Admin klíč se čte ze sberna/tajne.txt (ADMIN_KEY=...).
const fs = require("fs");
const path = require("path");
const { execFileSync } = require("child_process");
const { readCache, writeCache, writeDataLua } = require("./soubory");

const ROOT = path.join(__dirname, "..");
const SBERNA_URL = "https://wowpocesku-sberna.wowpocesku-sberna.workers.dev";

function adminKey() {
  const line = fs.readFileSync(path.join(ROOT, "sberna", "tajne.txt"), "utf8").split(/\r?\n/).find((l) => l.startsWith("ADMIN_KEY="));
  if (!line) throw new Error("V sberna/tajne.txt chybí ADMIN_KEY");
  return line.slice("ADMIN_KEY=".length).trim();
}

async function sberna(pathname, body) {
  const r = await fetch(`${SBERNA_URL}${pathname}`, {
    method: body ? "POST" : "GET",
    headers: { Authorization: `Bearer ${adminKey()}`, ...(body ? { "content-type": "application/json" } : {}) },
    body: body ? JSON.stringify(body) : undefined,
  });
  if (!r.ok) throw new Error(`Sběrna ${pathname}: HTTP ${r.status}`);
  return r.json();
}

async function kdo(id) {
  const w = await sberna(`/who?quest_id=${id}`);
  const when = (t) => new Date(t).toISOString().replace("T", " ").slice(0, 16);
  console.log(`Poslané anglické texty k ${id}:`);
  for (const s of w.submissions) console.log(`  ${when(s.created_at)}  klient ${s.client}  ip ${s.ip}  ${s.field}: ${s.text}`);
  console.log(`Opravy k ${id}:`);
  for (const c of w.corrections) console.log(`  ${when(c.created_at)}  klient ${c.client}  ip ${c.ip}  ${c.field} [${c.kind}/${c.status}]: ${c.text}`);
}

async function blokuj(client) {
  const r = await sberna("/ban", { client });
  console.log(`Zablokováno: klient ${client} a ${r.banned_ips} IP adres. Jeho nezpracované texty a opravy jsou zahozené.`);
}

function vrat(id) {
  const git = (...args) => execFileSync("git", args, { cwd: ROOT, maxBuffer: 1e9 }).toString();
  const current = JSON.stringify(readCache()[id] ?? null);
  // databáze byla dřív v hlavní složce, teď je v data/ – historii hledáme na obou místech
  const showCache = (sha) => { try { return git("show", `${sha}:data/preklady.json`); } catch { return git("show", `${sha}:preklady.json`); } };
  const commits = git("log", "--format=%H", "--", "data/preklady.json", "preklady.json").trim().split("\n");
  for (const sha of commits) {
    const old = JSON.parse(showCache(sha).replace(/^﻿/, ""))[id] ?? null;
    if (JSON.stringify(old) !== current) {
      const cache = readCache();
      if (old) cache[id] = old; else delete cache[id];
      writeCache(cache);
      writeDataLua(cache);
      console.log(`Quest ${id} vrácen na verzi z commitu ${sha.slice(0, 7)}:`);
      console.log(old ? `  ${old.title} – ${(old.text || "").slice(0, 100)}` : "  (quest tehdy neexistoval – smazán)");
      return;
    }
  }
  console.log(`Quest ${id}: v historii není žádná jiná verze.`);
}

const [cmd, arg] = process.argv.slice(2);
(async () => {
  if (cmd === "kdo" && arg) await kdo(Number(arg));
  else if (cmd === "blokuj" && arg) await blokuj(arg);
  else if (cmd === "vrat" && arg) vrat(arg);
  else console.log("Použití: node tools/zablokuj.js kdo <quest_id> | blokuj <klient_id> | vrat <quest_id>");
})().catch((e) => { console.error(e.message); process.exit(1); });

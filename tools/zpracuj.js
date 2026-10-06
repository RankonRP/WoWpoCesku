// Denní zpracování (GitHub Actions):
//   1) potvrzené nové questy ze sběrny -> překlad
//   2) opravy od hráčů -> důvěryhodné rovnou, ostatní ke schválení v issue na GitHubu
//   3) rozhovory s NPC -> rozhovory.json + DataRozhovory.lua
//   -> preklady.json + Data.lua
//
// Prostředí:
//   SBERNA_URL         adresa sběrny
//   SBERNA_ADMIN_KEY   admin klíč sběrny
//   PREKLADAC          "google" (výchozí) nebo "claude"
//   ANTHROPIC_API_KEY  jen pro PREKLADAC=claude
//   GH_TOKEN           token GitHub Actions (issue se schvalováním oprav)
//   GITHUB_REPOSITORY  owner/repo (nastaví GitHub Actions)
//   DRY_RUN=1          nic nezapisuje ani nepotvrzuje (test)

const fs = require("fs");
const path = require("path");

const { cleanText, readCache, writeCache, writeDataLua, readGossip, writeGossip, writeGossipLua, gossipKey, readUi, writeUi, writeUiLua } = require("./soubory");
const { apply: applyRules, protectStats, restoreStats } = require("./pravidla");
const { translateAll, PREKLADAC } = require("./preklad");

const ROOT = path.join(__dirname, "..");

const { SBERNA_URL, SBERNA_ADMIN_KEY } = process.env;
const DRY_RUN = process.env.DRY_RUN === "1";
// ODLOZIT=1: potvrzení sběrně (ack, nové návrhy, vyřízené opravy) se jen uloží do .odeslat.json
// a odešle je až "node tools/zpracuj.js --odeslat" PO úspěšném pushi. Když push selže, nic se
// neztratí – sběrna texty nabídne znovu.
const ODLOZIT = process.env.ODLOZIT === "1";
const ODESLAT_PATH = path.join(ROOT, "nastaveni", "stav", ".odeslat.json");

const simple = (s) => (s || "").toLowerCase().replace(/[\s\p{P}]/gu, "");

// ---------------------------------------------------------------------------
// Sběrna
// ---------------------------------------------------------------------------
const auth = () => ({ Authorization: `Bearer ${SBERNA_ADMIN_KEY}` });

async function sberna(pathname, body) {
  const r = await fetch(`${SBERNA_URL}${pathname}`, body === undefined
    ? { headers: auth() }
    : { method: "POST", headers: { ...auth(), "content-type": "application/json" }, body: JSON.stringify(body) });
  if (!r.ok) throw new Error(`Sběrna ${pathname}: HTTP ${r.status}`);
  return r.json();
}

// Filtr zakázaných slov (filtr.json): začátek slova, bez ohledu na velikost písmen
const FILTER = JSON.parse(fs.readFileSync(path.join(ROOT, "data", "filtr.json"), "utf8").replace(/^﻿/, ""));
const FILTER_RE = new RegExp(
  `(?<!\\p{L})(?:${[...FILTER.cesky, ...FILTER.anglicky].map((w) => w.replace(/[.*+?^${}()|[\]\\]/g, "\\$&")).join("|")})`,
  "iu"
);
const hasBlockedWord = (s) => FILTER_RE.test(s || "");

// Nové questy od hráčů -> překlad. Vrací seznam k potvrzení (ack) a návrhy ke schválení.
async function processSubmissions(cache, gossip, ui) {
  const all = (await sberna("/confirmed")).items || [];
  for (const it of all) it.en_text = cleanText(it.en_text);
  console.log(`Potvrzených textů ze sběrny: ${all.length}`);
  if (!all.length) return { changed: false, gossipChanged: false, uiChanged: false, ack: [], review: [] };
  const items = all.filter((it) => it.field !== "gossip" && it.field !== "ui");

  // Texty rozhraní (šablony talentů…): klíč = anglická šablona s {1},{2}
  const uiTodo = {};
  for (const it of all.filter((it) => it.field === "ui")) {
    const key = gossipKey(it.en_text);
    if (!ui[key]?.cs && !uiTodo[key]) uiTodo[key] = { cs: protectStats(key) };
  }
  const uiTr = await translateAll(uiTodo);
  for (const [key, t] of Object.entries(uiTr)) {
    if (hasBlockedWord(key) || hasBlockedWord(t.cs)) { delete uiTr[key]; continue; }
    ui[key] = { cs: restoreStats(t.cs), en: key, src: "komunita" };
  }
  console.log(`Textů rozhraní přeloženo: ${Object.keys(uiTr).length}`);

  // Rozhovory s NPC: každý text zvlášť (jedno NPC jich může mít víc)
  const gossipTodo = {};
  for (const it of all.filter((it) => it.field === "gossip")) {
    const key = gossipKey(it.en_text);
    if (!gossip[key]?.cs && !gossipTodo[key]) gossipTodo[key] = { cs: it.en_text, npc: it.quest_id };
  }
  const gossipTr = await translateAll(Object.fromEntries(Object.entries(gossipTodo).map(([k, v]) => [k, { cs: v.cs }])));
  for (const [key, t] of Object.entries(gossipTr)) {
    // Rozhovor se zakázaným slovem se nezveřejní (klíč je anglický text, takže vymyšlený
    // rozhovor by se ve hře stejně nikdy neukázal – ale ani ho nechceme v databázi)
    if (hasBlockedWord(key) || hasBlockedWord(t.cs)) { console.log(`Rozhovor se zakázaným slovem zahozen: ${key.slice(0, 60)}`); delete gossipTr[key]; continue; }
    gossip[key] = { cs: t.cs, en: gossipTodo[key].cs, npc: String(gossipTodo[key].npc), src: "komunita" };
  }
  console.log(`Rozhovorů přeloženo: ${Object.keys(gossipTr).length}`);

  // Pro každé pole questu vezmi text s nejvíc hlášeními (nebo od důvěryhodného hráče)
  const best = {};
  for (const it of items) {
    const key = `${it.quest_id}|${it.field}`;
    const score = it.reporters + (it.trusted ? 1000 : 0);
    if (!best[key] || score > best[key].score) best[key] = { ...it, score };
  }

  const toTranslate = {};
  for (const it of Object.values(best)) {
    const e = cache[it.quest_id];
    // Už přeloženo ze stejného anglického textu -> nic nedělat
    if (e && e[it.field] && simple(e["en_" + it.field]) === simple(it.en_text)) continue;
    (toTranslate[it.quest_id] = toTranslate[it.quest_id] || {})[it.field] = it.en_text;
  }
  console.log(`Questů k překladu: ${Object.keys(toTranslate).length} (${PREKLADAC})`);

  // Ochrana proti vandalům:
  //  - změna už přeloženého questu (jiný anglický originál) -> ke schválení ("zmena")
  //  - zakázané slovo v originálu nebo překladu -> ke schválení ("filtr")
  //  Důvěryhodný hráč (správce) jde rovnou.
  const translated = await translateAll(toTranslate);
  const review = [];
  let applied = 0;
  for (const [id, fields] of Object.entries(translated)) {
    for (const [k, v] of Object.entries(fields)) {
      const it = best[`${id}|${k}`];
      const e = cache[id];
      const en = toTranslate[id][k];
      let kind = null;
      if (!it.trusted) {
        if (e && e[k]) kind = "zmena";
        else if (hasBlockedWord(en) || hasBlockedWord(v)) kind = "filtr";
      }
      if (kind) {
        review.push({ quest_id: Number(id), field: k, en, cs: v, kind });
        continue;
      }
      const entry = (cache[id] = cache[id] || {});
      entry[k] = v;
      entry["en_" + k] = en;
      delete entry.pre;
      entry.src = "komunita";
      applied++;
    }
  }
  console.log(`Použito rovnou: ${applied}, ke schválení: ${review.length}`);
  return {
    review,
    changed: applied > 0,
    gossipChanged: Object.keys(gossipTr).length > 0,
    uiChanged: Object.keys(uiTr).length > 0,
    ack: all.map((it) => ({ quest_id: it.quest_id, field: it.field, en_hash: it.en_hash })),
  };
}

// ---------------------------------------------------------------------------
// Opravy od hráčů: důvěryhodné rovnou, ostatní přes issue na GitHubu (zaškrtávátka)
// ---------------------------------------------------------------------------
const { GH_TOKEN, GITHUB_REPOSITORY } = process.env;
const ISSUE_TITLE = "Opravy překladů ke schválení";
const ISSUE_LABEL = "opravy";
const FIELD_NAMES = { title: "Název", text: "Popis", objectives: "Úkol", progress: "Průběh", reward: "Odměna" };

async function github(pathname, method = "GET", body) {
  const r = await fetch(`https://api.github.com/repos/${GITHUB_REPOSITORY}${pathname}`, {
    method,
    headers: {
      Authorization: `Bearer ${GH_TOKEN}`,
      Accept: "application/vnd.github+json",
      "User-Agent": "wowpocesku-bot",
      ...(body ? { "content-type": "application/json" } : {}),
    },
    body: body ? JSON.stringify(body) : undefined,
  });
  if (!r.ok) throw new Error(`GitHub ${method} ${pathname}: HTTP ${r.status} ${await r.text()}`);
  return r.json();
}

function applyCorrection(cache, c) {
  const e = (cache[c.quest_id] = cache[c.quest_id] || {});
  e[c.field] = c.cs_text;
  e["en_" + c.field] = c.en_text;
  delete e.pre;
  e.src = "oprava";
}

// Text do issue: bez @zmínek (neposílat notifikace cizím lidem) a jako citace
const quote = (s) => "> " + (s || "–").replace(/@/g, "@\u200b").replace(/\r?\n/g, "\n> ");

const KIND_TITLES = {
  oprava: "hráč navrhl opravu překladu",
  zmena: "⚠️ změnil se anglický originál už přeloženého questu (změna ve hře, nebo vandal?)",
  filtr: "⚠️ obsahuje zakázané slovo",
};

function issueBody(pending, cache) {
  const parts = [
    "Tyto změny překladů čekají na tvoje rozhodnutí. U každé zaškrtni **schválit** nebo **zamítnout** – " +
      "zpracování se spustí samo a schválené změny se dostanou ke všem hráčům.\n\n" +
      "_Tip: u ⚠️ změn originálu porovnej starý a nový anglický text. Když nový nedává smysl, je to vandal – " +
      "zamítni ho a napiš Claudovi číslo questu, dohledá a zablokuje autora._\n",
  ];
  let size = parts[0].length, shown = 0;
  for (const c of pending) {
    const cur = cache[c.quest_id]?.[c.field];
    const oldEn = cache[c.quest_id]?.["en_" + c.field];
    const enBlock = c.kind === "zmena"
      ? `**Anglicky dřív:**\n${quote(oldEn)}\n\n**Anglicky teď:**\n${quote(c.en_text)}\n\n`
      : `<details><summary>Anglický originál</summary>\n\n${quote(c.en_text)}\n\n</details>\n\n`;
    const block =
      `---\n### ${c.id} – quest ${c.quest_id}, ${FIELD_NAMES[c.field] || c.field}: ${KIND_TITLES[c.kind] || KIND_TITLES.oprava}\n` +
      enBlock +
      `**Česky teď:**\n${quote(cur)}\n\n**Návrh:**\n${quote(c.cs_text)}\n\n` +
      `- [ ] schválit opravu ${c.id}\n- [ ] zamítnout opravu ${c.id}\n`;
    if (size + block.length > 60000) break;
    parts.push(block);
    size += block.length;
    shown++;
  }
  if (shown < pending.length) parts.push(`\n_…a dalších ${pending.length - shown} oprav se ukáže po vyřízení těchto._`);
  return parts.join("\n");
}

async function processCorrections(cache) {
  const items = (await sberna("/corrections")).items || [];
  console.log(`Čekajících oprav: ${items.length}`);
  const resolve = [];
  let changed = false;

  // Rozhodnutí z issue (zaškrtnutá políčka)
  let issue = null;
  const decisions = {};
  if (GH_TOKEN && GITHUB_REPOSITORY) {
    const open = await github(`/issues?state=open&labels=${ISSUE_LABEL}&per_page=10`);
    issue = open.find((i) => i.title === ISSUE_TITLE) || null;
    for (const m of (issue?.body || "").matchAll(/- \[[xX]\] (schválit|zamítnout) opravu (\d+)/g)) {
      decisions[m[2]] = m[1] === "schválit" ? "applied" : "rejected";
    }
  } else {
    console.log("Bez GH_TOKEN – schvalování přes issue se přeskakuje.");
  }

  const pending = [];
  for (const c of items) {
    const decision = c.trusted ? "applied" : decisions[c.id];
    if (decision === "applied") { applyCorrection(cache, c); changed = true; }
    if (decision) resolve.push({ id: c.id, status: decision });
    else pending.push(c);
  }
  console.log(`Oprav schváleno/zamítnuto: ${resolve.length}, stále čeká: ${pending.length}`);
  return { changed, resolve, pending, issue };
}

async function updateIssue(pending, issue, cache) {
  if (!GH_TOKEN || !GITHUB_REPOSITORY) return;
  if (!pending.length) {
    if (issue) await github(`/issues/${issue.number}`, "PATCH", { state: "closed", body: "Všechny opravy jsou vyřízené. ✔" });
    return;
  }
  const body = issueBody(pending, cache);
  if (issue) await github(`/issues/${issue.number}`, "PATCH", { body });
  else await github(`/issues`, "POST", { title: ISSUE_TITLE, body, labels: [ISSUE_LABEL] });
}

// ---------------------------------------------------------------------------
async function main() {
  if (!SBERNA_URL || !SBERNA_ADMIN_KEY) throw new Error("Chybí SBERNA_URL nebo SBERNA_ADMIN_KEY");
  const cache = readCache();
  const gossip = readGossip();
  const ui = readUi();

  const subs = await processSubmissions(cache, gossip, ui);
  // Podezřelé změny a zakázaná slova -> do sběrny jako návrhy ke schválení (objeví se v issue)
  if (subs.review.length && !DRY_RUN && !ODLOZIT) await sberna("/corrections/add", subs.review);
  const corr = await processCorrections(cache);

  if (DRY_RUN) {
    if (subs.review.length) console.log("Ke schválení by šlo:", JSON.stringify(subs.review).slice(0, 500));
    console.log("DRY_RUN – nic se nezapisuje ani nepotvrzuje.");
    return;
  }
  if (subs.changed || corr.changed) {
    writeCache(cache);
    writeDataLua(cache);
  }
  if (subs.gossipChanged) {
    writeGossip(gossip);
    writeGossipLua(gossip);
  }
  if (subs.uiChanged) {
    writeUi(ui);
    writeUiLua(ui);
  }
  if (ODLOZIT) {
    fs.writeFileSync(ODESLAT_PATH, JSON.stringify({ review: subs.review, ack: subs.ack, resolve: corr.resolve }));
    console.log(`Potvrzení odložena do .odeslat.json (ack ${subs.ack.length}, návrhy ${subs.review.length}, opravy ${corr.resolve.length}).`);
  } else {
    if (subs.ack.length) await sberna("/ack", subs.ack);
    if (corr.resolve.length) await sberna("/corrections/resolve", corr.resolve);
  }
  await updateIssue(corr.pending, corr.issue, cache);
  console.log("Hotovo.");
}

// Odeslání odložených potvrzení (po úspěšném pushi)
async function odeslat() {
  if (!fs.existsSync(ODESLAT_PATH)) { console.log("Nic k odeslání."); return; }
  const p = JSON.parse(fs.readFileSync(ODESLAT_PATH, "utf8"));
  if (p.review?.length) await sberna("/corrections/add", p.review);
  if (p.ack?.length) await sberna("/ack", p.ack);
  if (p.resolve?.length) await sberna("/corrections/resolve", p.resolve);
  fs.unlinkSync(ODESLAT_PATH);
  console.log(`Odesláno: ack ${p.ack?.length || 0}, návrhy ${p.review?.length || 0}, opravy ${p.resolve?.length || 0}.`);
}

(process.argv.includes("--odeslat") ? odeslat() : main()).catch((e) => {
  console.error(e);
  process.exit(1);
});

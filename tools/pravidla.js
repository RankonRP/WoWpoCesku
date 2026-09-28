// Automatické úpravy strojového překladu podle pravidla.json (stejná logika je v pomocnik.ps1).
const fs = require("fs");
const path = require("path");

const RULES = JSON.parse(fs.readFileSync(path.join(__dirname, "..", "pravidla.json"), "utf8").replace(/^﻿/, ""));

const esc = (s) => s.replace(/[.*+?^${}()|[\]\\]/g, "\\$&");
const cap = (s) => s.charAt(0).toUpperCase() + s.slice(1);
const low = (s) => s.charAt(0).toLowerCase() + s.slice(1);

// Předpřipravené regexy: každé slovo ve tvaru s malým i velkým počátečním písmenem, jen jako celé slovo
const WORDS = [];
for (const [from, to] of Object.entries(RULES.slova || {})) {
  for (const [a, b] of [[cap(from), cap(to)], [low(from), low(to)]]) {
    WORDS.push([new RegExp(`(?<!\\p{L})${esc(a)}(?!\\p{L})`, "gu"), b]);
  }
}
const REGEXES = (RULES.regexy || []).map((r) => [new RegExp(r.hledat, "gu"), r.nahradit]);

function apply(text) {
  if (!text) return text;
  let t = text;
  for (const [re, to] of WORDS) t = t.replace(re, to);
  for (const [re, to] of REGEXES) t = t.replace(re, to);
  return t;
}

// Staty (Mana, Strength…) zůstávají v textech rozhraní anglicky: před překladem je nahradí {101}, {102}… a po překladu vrátí
const STATS = (RULES.staty || []).slice().sort((a, b) => b.length - a.length);
const STAT_RE = STATS.length ? new RegExp(`(?<!\\p{L})(${STATS.map(esc).join("|")})(?!\\p{L})`, "gu") : null;
function protectStats(text) {
  if (!STAT_RE || !text) return text;
  return text.replace(STAT_RE, (m) => "{" + (101 + STATS.indexOf(m)) + "}");
}
function restoreStats(text) {
  if (!text) return text;
  return text.replace(/\{(1\d\d)\}/g, (m, n) => STATS[n - 101] || m);
}

module.exports = { apply, protectStats, restoreStats };

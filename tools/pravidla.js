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

module.exports = { apply };

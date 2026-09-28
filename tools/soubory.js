// Zápis databází překladů (stejný formát jako pomocnik.ps1).
const fs = require("fs");
const path = require("path");

const ROOT = path.join(__dirname, "..");
const CACHE_PATH = path.join(ROOT, "preklady.json");
const DATA_LUA_PATH = path.join(ROOT, "WoWpoCesku", "Data.lua");
const GOSSIP_PATH = path.join(ROOT, "rozhovory.json");
const GOSSIP_LUA_PATH = path.join(ROOT, "WoWpoCesku", "DataRozhovory.lua");
const FIELD_ORDER = ["title", "text", "objectives", "progress", "reward"];

const readJson = (p, fallback) =>
  fs.existsSync(p) ? JSON.parse(fs.readFileSync(p, "utf8").replace(/^﻿/, "")) : fallback;

// Jeden záznam = jeden řádek, aby šel soubor snadno prohledávat a opravovat
function writeJsonLines(p, obj, keys) {
  const lines = keys.map((k, i) => {
    const entry = {};
    for (const f of Object.keys(obj[k]).sort()) entry[f] = obj[k][f];
    return `  ${JSON.stringify(k)}: ${JSON.stringify(entry)}${i < keys.length - 1 ? "," : ""}`;
  });
  fs.writeFileSync(p, "{\n" + lines.join("\n") + "\n}\n");
}

const luaString = (s) => '"' + s.replace(/\\/g, "\\\\").replace(/"/g, '\\"').replace(/\r/g, "").replace(/\n/g, "\\n") + '"';

// Klíč rozhovoru = anglický text se sjednocenými mezerami (addon ho počítá stejně)
const gossipKey = (en) => (en || "").replace(/\s+/g, " ").trim();

// --- Questy ---
const readCache = () => readJson(CACHE_PATH, {});

function writeCache(cache) {
  writeJsonLines(CACHE_PATH, cache, Object.keys(cache).sort((a, b) => a - b));
}

function writeDataLua(cache) {
  const out = [
    "-- Tento soubor generuje pomocnik.ps1. Neupravuj ho ručně – oprav překlad v preklady.json.",
    "WoWpoCesku_Data = {",
  ];
  for (const id of Object.keys(cache).sort((a, b) => a - b)) {
    const e = cache[id];
    const parts = FIELD_ORDER.filter((f) => e[f]).map((f) => `${f}=${luaString(e[f])}`);
    if (e.en_title) parts.push(`en=${luaString(e.en_title)}`);
    if (parts.length) out.push(`[${id}]={${parts.join(",")}},`);
  }
  out.push("}");
  fs.writeFileSync(DATA_LUA_PATH, out.join("\r\n") + "\r\n");
}

// --- Rozhovory s NPC ---
const readGossip = () => readJson(GOSSIP_PATH, {});

function writeGossip(gossip) {
  writeJsonLines(GOSSIP_PATH, gossip, Object.keys(gossip).sort());
}

function writeGossipLua(gossip) {
  const out = [
    "-- Tento soubor generuje pomocnik.ps1. Neupravuj ho ručně – oprav překlad v rozhovory.json.",
    "WoWpoCesku_Gossip = {",
  ];
  for (const k of Object.keys(gossip).sort()) {
    if (gossip[k].cs) out.push(`[${luaString(k)}]=${luaString(gossip[k].cs)},`);
  }
  out.push("}");
  fs.writeFileSync(GOSSIP_LUA_PATH, out.join("\r\n") + "\r\n");
}

module.exports = { readCache, writeCache, writeDataLua, readGossip, writeGossip, writeGossipLua, gossipKey };

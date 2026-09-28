-- Databáze sběrny (Cloudflare D1)
CREATE TABLE IF NOT EXISTS submissions (
  quest_id   INTEGER NOT NULL,
  field      TEXT    NOT NULL,
  en_hash    TEXT    NOT NULL,
  en_text    TEXT    NOT NULL,
  client     TEXT    NOT NULL,
  ip_hash    TEXT    NOT NULL,
  created_at INTEGER NOT NULL,
  UNIQUE (quest_id, field, en_hash, client)
);
CREATE INDEX IF NOT EXISTS idx_sub_client ON submissions (client, created_at);
CREATE INDEX IF NOT EXISTS idx_sub_ip     ON submissions (ip_hash, created_at);
CREATE INDEX IF NOT EXISTS idx_sub_quest  ON submissions (quest_id, field, en_hash);

-- Opravy překladů od hráčů (čekají na schválení správcem)
CREATE TABLE IF NOT EXISTS corrections (
  id         INTEGER PRIMARY KEY AUTOINCREMENT,
  quest_id   INTEGER NOT NULL,
  field      TEXT    NOT NULL,
  en_hash    TEXT    NOT NULL,
  en_text    TEXT    NOT NULL,
  cs_text    TEXT    NOT NULL,
  client     TEXT    NOT NULL,
  ip_hash    TEXT    NOT NULL,
  created_at INTEGER NOT NULL,
  status     TEXT    NOT NULL DEFAULT 'pending',
  -- oprava = od hráče, zmena = změnil se anglický originál, filtr = zakázané slovo
  kind       TEXT    NOT NULL DEFAULT 'oprava'
);

-- Zablokovaní hráči (kind = 'client' | 'ip')
CREATE TABLE IF NOT EXISTS banned (
  kind       TEXT    NOT NULL,
  value      TEXT    NOT NULL,
  created_at INTEGER NOT NULL,
  PRIMARY KEY (kind, value)
);
CREATE INDEX IF NOT EXISTS idx_corr_status ON corrections (status, id);
CREATE INDEX IF NOT EXISTS idx_corr_client ON corrections (client, created_at);

CREATE TABLE IF NOT EXISTS exported (
  quest_id    INTEGER NOT NULL,
  field       TEXT    NOT NULL,
  en_hash     TEXT    NOT NULL,
  exported_at INTEGER NOT NULL,
  PRIMARY KEY (quest_id, field, en_hash)
);

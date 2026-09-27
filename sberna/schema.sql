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

CREATE TABLE IF NOT EXISTS exported (
  quest_id    INTEGER NOT NULL,
  field       TEXT    NOT NULL,
  en_hash     TEXT    NOT NULL,
  exported_at INTEGER NOT NULL,
  PRIMARY KEY (quest_id, field, en_hash)
);

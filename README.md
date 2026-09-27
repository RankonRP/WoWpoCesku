# WoWpoČesku

Český překlad questů pro **World of Warcraft: Forever**.

- Addon ukáže český překlad vedle okna questu – u více než 4000 klasických questů hned po instalaci.
- Nový quest, který ještě přeložený není, předáš jednou klávesou (Ctrl+C) malému Pomocníkovi na PC. Ten ho přeloží a uloží, takže příště už je česky přímo ve hře.
- Nic se neinstaluje – Pomocník běží v PowerShellu, který je součástí Windows.

Návod k instalaci a používání: [NAVOD.md](NAVOD.md)

## Stav
Rané testování na betě WoW Forever (klient 1.60.1). Překlady jsou zatím strojové (Google) – čekej občasné míchání tykání/vykání a doslovné obraty.

## Obsah repozitáře
| Cesta | Co to je |
|---|---|
| `WoWpoCesku/` | samotný addon (patří do `Interface\AddOns`) |
| `pomocnik.ps1`, `spustit.bat` | Pomocník – hlídá schránku, překládá nové questy |
| `instalace.bat` | propojí addon se složkou hry |
| `preklady.json` | databáze překladů včetně anglických originálů |
| `slovnicek.txt` | pravidla a pojmy pro překlad přes Claude |

## Licence a zdroje
- Kód: [MIT](LICENSE)
- Písmo Noto Sans: SIL Open Font License 1.1 (`WoWpoCesku/Fonts/OFL.txt`)
- Anglické texty klasických questů pochází z open-source databáze [CMaNGOS classic-db](https://github.com/cmangos/classic-db). Texty questů jsou © Blizzard Entertainment; toto je neoficiální fanouškovský překlad.

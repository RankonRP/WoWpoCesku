# WoWpoČesku

Český překlad questů pro **World of Warcraft: Forever**.

- Česky se ukáže zadání questu, texty při odevzdání, úkoly v přehledu, názvy questů, rozhovory s NPC i knihy a dopisy – u víc než 4000 questů hned po instalaci.
- Nový quest, který ještě přeložený není, předáš jednou klávesou (**Ctrl+C**) malému Pomocníkovi na PC. Ten ho přeloží a pošle do společné databáze, takže ho pak mají česky všichni hráči.
- Nic dalšího se neinstaluje – Pomocník běží v PowerShellu, který je součástí Windows.

## Instalace

1. Nahoře na této stránce klikni na zelené tlačítko **Code** → **Download ZIP**.
2. Zip **rozbal** (pravým tlačítkem → *Extrahovat vše*) někam natrvalo, třeba do Dokumentů.
   Složku pak **nemaž** – addon ve hře je na ni jen odkaz.
3. Spusť **`Instalace do hry.bat`** a vyber složku **World of Warcraft** (správnou verzi hry najde sama).
4. Spusť **`Spustit pomocnika.bat`**. Poprvé se zeptá, jestli chceš pomáhat s překlady – doporučujeme **Ano**.
5. Spusť hru a na obrazovce výběru postavy v **AddOns** zkontroluj, že je **WoWpoCesku** zaškrtnutý.
6. V nastavení hry přepni *Options → Graphics → Display Mode* na **Windowed (Fullscreen)**, aby bylo okno Pomocníka vidět nad hrou.

> Když Windows ukáže modré okno **„Systém Windows ochránil počítač“**, klikni na **Další informace** → **Přesto spustit**. Je to běžné u každého skriptu staženého z internetu.

**Aktualizace jsou automatické:** Pomocník při spuštění sám nabídne novou verzi a nové překlady od ostatních hráčů se stahují samy.

## Mac

Na Macu funguje stejný addon, Pomocník má vlastní verzi (`pomocnik-mac.js`). Nic se neinstaluje – běží přes `osascript`, který je součástí macOS.

1. **Code** → **Download ZIP**, zip rozbal a složku přesuň natrvalo do `/Applications/World of Warcraft`.
2. Dvojklikni na **`Spustit pomocnika.command`**. Poprvé macOS soubor zablokuje (je stažený z internetu) – v *Nastavení systému → Soukromí a zabezpečení* klikni na **Přesto otevřít**.
3. Pomocník při prvním spuštění sám zkopíruje addon do hry a zeptá se, jestli chceš pomáhat s překlady.
4. Nepřeložený quest: v panelu klikni na **Načíst překlady (/reload)**, počkej asi 20 s a klikni znovu (nebo text zkopíruj přes **Cmd+C**).

Mac verze umí vše kromě okna *Opravit překlad*. Podrobnosti: [NAVOD-MAC.txt](NAVOD-MAC.txt).

## Hraní

- Spusť **`Spustit pomocnika.bat`** – nejlépe ještě před hrou.
- **Přeložený quest** → český text se ukáže v panelu vedle okna questu.
- **Nepřeložený quest** → addon text označí → zmáčkni **Ctrl+C** → překlad se hned ukáže v Pomocníkovi. Po `/reload` ho uvidíš česky i ve hře.
- **Špatný překlad** → v panelu klikni na **Opravit překlad**, oprav text v Pomocníkovi a ulož.
- **Nastavení** → ikona knihy u minimapy (nebo `/czq nastaveni`).

Podrobný návod včetně řešení častých potíží: [NAVOD.txt](NAVOD.txt) (je i v zipu, otevře se v Poznámkovém bloku).

## Stav

Testování na betě WoW Forever (klient 1.60.1). Překlady jsou strojové (Google) s automatickými úpravami (tykání, časté chyby) a postupně se ručně opravují. Když narazíš na špatný překlad, oprav ho tlačítkem **Opravit překlad** – oprava se po schválení dostane ke všem.

## Obsah repozitáře

| Cesta | Co to je |
|---|---|
| `WoWpoCesku/` | samotný addon (patří do `Interface\AddOns`) |
| `Spustit pomocnika.bat`, `pomocnik.ps1` | Pomocník – hlídá schránku, překládá nové questy, stahuje aktualizace |
| `Spustit pomocnika.command`, `pomocnik-mac.js` | Pomocník pro Mac (totéž bez okna „Opravit překlad“) |
| `Instalace do hry.bat` | propojí addon se složkou hry |
| `preklady.json`, `rozhovory.json` | databáze překladů včetně anglických originálů |
| `pravidla.json` | automatické úpravy strojového překladu |
| `sberna/`, `tools/`, `.github/` | společná databáze a její zpracování (pro správce) |

## Licence a zdroje

- Kód: [MIT](LICENSE)
- Písmo Noto Sans: SIL Open Font License 1.1 (`WoWpoCesku/Fonts/OFL.txt`)
- Anglické texty klasických questů pochází z open-source databáze [CMaNGOS classic-db](https://github.com/cmangos/classic-db). Texty questů jsou © Blizzard Entertainment; toto je neoficiální fanouškovský překlad.

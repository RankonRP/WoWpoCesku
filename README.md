# WoWpoČesku

Český překlad questů pro **World of Warcraft: Forever**.

- Česky se ukáže zadání questu, texty při odevzdání, úkoly v přehledu, názvy questů, rozhovory s NPC i knihy a dopisy – u víc než 4000 questů hned po instalaci.
- Nový quest, který ještě přeložený není, předáš jednou klávesou (**Ctrl+C**) malému Pomocníkovi na PC. Ten ho přeloží a pošle do společné databáze, takže ho pak mají česky všichni hráči.
- **Kronika Azerothu** – kniha na pergamenu s příběhem oblasti, kde právě jsi, česky (viz níže).
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

## Hraní

- Spusť **`Spustit pomocnika.bat`** – nejlépe ještě před hrou.
- **Přeložený quest** → český text se ukáže v panelu vedle okna questu.
- **Nepřeložený quest** → addon text označí → zmáčkni **Ctrl+C** → překlad se hned ukáže v Pomocníkovi. Po `/reload` ho uvidíš česky i ve hře.
- **Špatný překlad** → v panelu klikni na **Opravit překlad**, oprav text v Pomocníkovi a ulož.
- **Ikona knihy u minimapy** → klik = Kronika Azerothu, **Ctrl+klik** = nastavení (nebo `/czq nastaveni`), pravý klik = zapnout/vypnout překlad, **Shift+klik** = načíst nové překlady.

## Kronika Azerothu

Kniha, která vždy ukazuje **jen oblast nebo dungeon, kde právě jsi** – pro všech 41 klasických oblastí, 24 dungeonů a raidů i nový Zephras Isle z WoW Forever. Otevře se klikem na ikonu u minimapy nebo `/czq lore`; při vstupu do nové oblasti se ukáže krátký titulek. Vpravo má pět záložek:

- **Letopis** – příběh oblasti v kapitolách a kapitola **Z knih a legend** (lore z románů a Warcraftu I–III, i se spoilery). V dungeonu příběh dungeonu, přehled bossů (poražení se sami odškrtnou) a **questy k dungeonu** pro tvou frakci – kdo je dává, od jakého levelu a odměny; splněné se odškrtnou.
- **Tajemství** – easter eggy, skrytá místa, slavné questové příběhy a zajímavosti, které se vyplatí najít.
- **Poutníkův deník** – zajímavá místa oblasti; navštívená se sama odškrtávají.
- **Bestiář** – vzácní (rare) mobové oblasti. Klik na moba vyznačí lebkou na mapě (**M**), kde se může objevit.
- **Tvůj příběh** – deník každé postavy zvlášť: kronika sama zapisuje nové oblasti a dungeony, poražené bosse, úrovně, pečetě, vzácné tvory, slavné postavy a pády v boji jako vyprávění.
- **Zkouška kronikáře** – kvíz z lore oblasti nebo dungeonu (i se spoilery); za pět správných odpovědí pečeť Znalec.
- **Pečetě** – úspěchy jako achievementy, s malovanými voskovými pečetěmi, body a hodností kronikáře (Učedník → Legenda Azerothu): prozkoumání oblasti, vyčištěný dungeon, vzácní mobové, cestování, čtení kroniky, **Legendy Azerothu** (slavné questové příběhy – zvlášť pro Alianci a Hordu) a **skryté pečetě** (easter eggy). Najetím myší uvidíš, co ještě chybí. Pečetě jsou společné pro účet a u každé je jméno postavy, která ji získala.

K tomu:

- **Upozornění na vzácné moby** – když se poblíž objeví rare, ukáže se hláška se zvukem a tlačítko pro zaměření. Seznam viděných: `/czq vzacni`, vypnutí `/czq vzacni vyp`.
- **Poznámky k postavám** – u přes 250 důležitých postav světa (Thrall, Hogger, Tirion, VanCleef…) se v popisku ukáže, kdo to je.
- **Příběhy předmětů** – u legendárních a slavných předmětů (Thunderfury, Atiesh, Corrupted Ashbringer, Head of Onyxia…) se v popisku ukáže jejich příběh.
- **Místa na mapě** – na velké mapě jsou značky míst z Poutníkova deníku (objevená odškrtnutá) a po najetí myší i tip ze záložky Tajemství.

Texty jsou psané vlastními slovy podle klasického WoW a [Warcraft Wiki](https://warcraft.wiki.gg/) a ověřené. Ve WoW Forever se může něco lišit – když narazíš na chybu, napiš.

Podrobný návod včetně řešení častých potíží: [NAVOD.txt](NAVOD.txt) (je i v zipu, otevře se v Poznámkovém bloku).

## Stav

Testování na betě WoW Forever (klient 1.60.1). Překlady jsou strojové (Google) s automatickými úpravami (tykání, časté chyby) a postupně se ručně opravují. Když narazíš na špatný překlad, oprav ho tlačítkem **Opravit překlad** – oprava se po schválení dostane ke všem.

## Obsah repozitáře

| Cesta | Co to je |
|---|---|
| `WoWpoCesku/` | samotný addon (patří do `Interface\AddOns`) |
| `Spustit pomocnika.bat`, `pomocnik.ps1` | Pomocník – hlídá schránku, překládá nové questy, stahuje aktualizace |
| `Instalace do hry.bat` | propojí addon se složkou hry |
| `preklady.json`, `rozhovory.json` | databáze překladů včetně anglických originálů |
| `pravidla.json` | automatické úpravy strojového překladu |
| `sberna/`, `tools/`, `.github/` | společná databáze a její zpracování (pro správce) |

## Licence a zdroje

- Kód: [MIT](LICENSE)
- Písmo Noto Sans: SIL Open Font License 1.1 (`WoWpoCesku/Fonts/OFL.txt`)
- Anglické texty klasických questů pochází z open-source databáze [CMaNGOS classic-db](https://github.com/cmangos/classic-db). Texty questů jsou © Blizzard Entertainment; toto je neoficiální fanouškovský překlad.

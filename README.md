# WoWpoČesku

Český překlad questů pro **World of Warcraft: Forever**.

- Česky se ukáže zadání questu, texty při odevzdání, úkoly v přehledu, názvy questů, rozhovory s NPC i knihy a dopisy – u víc než 4000 questů hned po instalaci.
- Nový text, který ještě přeložený není (quest, rozhovor, kniha), si addon sám zapamatuje a malý Pomocník na PC ho přeloží a pošle do společné databáze, takže ho pak mají česky všichni hráči. **Ctrl+C není nutné** – jen urychlí překlad.
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
- **Nepřeložený text** → nic dělat nemusíš: napiš `/reload` (nebo se odhlas), Pomocník texty ze hry sám přeloží a po zprávě **HOTOVO** napiš `/reload` znovu – a je to česky.
- **Chceš to hned?** Zmáčkni **Ctrl+C** na označeném textu (addon ho označí sám) – překlad se ukáže hned v Pomocníkovi a po `/reload` ho uvidíš ve hře.
- **Překlad se ti nelíbí?** V panelu klikni na **Nelíbí se mi – poslat Claudovi**: text se označí (jen v tvé hře, nikam se neposílá) a při příštím sezení ho Claude přeloží ručně. Po označení napiš `/reload`, ať se označení uloží.
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

Podrobný návod včetně řešení častých potíží: [docs/NAVOD.txt](docs/NAVOD.txt) (je i v zipu, otevře se v Poznámkovém bloku).

## Stav

Testování na betě WoW Forever (klient 1.60.1). Překlady jsou strojové (Google) s automatickými úpravami (tykání, časté chyby) a postupně se ručně opravují. Když narazíš na špatný překlad, oprav ho tlačítkem **Opravit překlad** – oprava se po schválení dostane ke všem.

## Obsah repozitáře

| Cesta | Co to je |
|---|---|
| `Instalace do hry.bat` | propojí addon se složkou hry (spouští `program/instalace.ps1`) |
| `Spustit pomocnika.bat` | spustí Pomocníka – hlídá schránku, překládá nové texty, stahuje aktualizace (`program/pomocnik.ps1`) |
| `WoWpoCesku/` | samotný addon (patří do `Interface\AddOns`) |
| `program/` | Pomocník, instalace a číslo verze (`verze.txt`) |
| `data/` | databáze překladů (`preklady.json`, `rozhovory.json`, `rozhrani.json`), `pravidla.json`, `filtr.json`, `slovnicek.txt` |
| `nastaveni/` | tvoje nastavení (`nastaveni.json` – nikomu ho neposílej) a stavové soubory |
| `docs/` | návod a licence textů a dat |
| `sberna/`, `tools/`, `.github/` | společná databáze a její zpracování (pro správce) |

## Licence a zdroje

- Kód: [MIT](LICENSE)
- **Překlady, texty Kroniky, databáze a obrázky: [docs/LICENSE-DATA.md](docs/LICENSE-DATA.md)** – addon můžeš používat a doporučovat, ale texty a data nelze kopírovat do jiných addonů ani projektů bez povolení.
- Písmo Noto Sans: SIL Open Font License 1.1 (`WoWpoCesku/Fonts/OFL.txt`)
- Anglické texty klasických questů pochází z open-source databáze [CMaNGOS classic-db](https://github.com/cmangos/classic-db). Texty questů jsou © Blizzard Entertainment; toto je neoficiální fanouškovský překlad.


**Discord:** https://discord.gg/2CnEbAMJK5 – chyby, nápady a návrhy překladů.

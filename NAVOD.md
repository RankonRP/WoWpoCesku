# WoWpoČesku – český překlad questů pro WoW Forever

## Instalace (jednou)
1. Nainstaluj WoW Forever a aspoň jednou ho spusť, aby vznikla jeho složka.
2. Dvojklik na **`Instalace do hry.bat`** → vyber složku hry (např. `...\World of Warcraft\_classic_beta_` (beta verze Forever)).
   Addon se do hry propojí odkazem, takže soubory zůstávají tady.
3. Ve hře na výběru postavy → **AddOns** → zaškrtni **WoWpoCesku**.
   (Kdyby byl označený jako zastaralý, zaškrtni „Načíst zastaralé doplňky“.)
4. Hru přepni na **Okno (bez rámečku)** / *Windowed (Fullscreen)*, aby bylo okno Pomocníka vidět nad hrou.

## Hraní
1. Dvojklik na **`Spustit pomocnika.bat`** → otevře se okno Pomocníka a stáhnou se nové překlady. Nejlépe ho spusť ještě před hrou.
2. Ve hře otevři quest:
   - **přeložený** → český text se ukáže v panelu vedle okna questu,
   - **nepřeložený** → addon text označí → zmáčkni **Ctrl+C** → překlad se hned ukáže v Pomocníkovi.
3. Občas napiš **`/reload`** – nově přeložené questy pak uvidíš česky přímo ve hře.

## Předpřipravené překlady
Addon už obsahuje **4245 klasických questů** přeložených Googlem (z open-source databáze CMaNGOS, verze 1.12).
- Když má quest ve hře jiný anglický název než v databázi (Forever ho změnil), addon ho sám nabídne k novému překladu.
- Když název sedí, ale text ne, klikni v panelu na **„Nesedí? Přeložit znovu“**.

## Příkazy ve hře
| Příkaz | Co dělá |
|---|---|
| `/czq` | zapne / vypne překlad |
| `/czq reset` | vrátí panel na výchozí místo (panel jde přetáhnout myší) |
| `/czq focus` | zapne / vypne automatické označení textu |
| `/czq stav` | počet přeložených questů |

## Přepnutí na Claude (lepší překlad)
1. Vytvoř API klíč na <https://console.anthropic.com> (cca 0,003 $ za quest).
2. V `nastaveni.json` nastav `"prekladac": "claude"` a vlož klíč do `"claude_api_klic"`.
3. Restartuj Pomocníka. Claude se řídí pravidly a pojmy ve **`slovnicek.txt`**.

## Soubory
- `WoWpoCesku/` – addon (Data.lua generuje Pomocník, neupravuj ručně)
- `preklady.json` – všechny překlady + anglické originály. **Tady opravuj chyby**, po restartu Pomocníka se propíšou do hry.
- `nastaveni.json` – volba překladače a API klíč (nikomu neposílej).
- `slovnicek.txt` – pravidla pro Claude.

> Font `WoWpoCesku/Fonts/cz.ttf` je Arial z Windows – pro vlastní použití OK. Kdybys addon zveřejňoval, nahraď ho volným fontem (např. Noto Sans).

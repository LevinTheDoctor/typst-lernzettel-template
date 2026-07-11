# Typst-Lernzettel-Template

[![Typst](https://img.shields.io/badge/Typst-0.15%2B-239dad?logo=typst&logoColor=white)](https://typst.app)
[![Lizenz: MIT](https://img.shields.io/badge/Lizenz-MIT-green.svg)](LICENSE)
[![R-Anbindung](https://img.shields.io/badge/R-Anbindung-276DC3?logo=r&logoColor=white)](r/)

Professionelles [Typst](https://typst.app)-Template für Lernzettel,
Zusammenfassungen und Prüfungsvorbereitungen — die Typst-Portierung des
gleichnamigen LaTeX-Templates. Kompiliert in **unter einer Sekunde** mit
einem einzigen Befehl, ohne LaTeX-Distribution.

> 📚 **Neu bei Typst?** Der Branch
> [`einstieg-in-typst`](../../tree/einstieg-in-typst/docs/einstieg) enthält
> einen kompletten deutschsprachigen Einstieg: Typst-Grundlagen, Styling mit
> set/show-Regeln (das „CSS von Typst"), der Quarto/RStudio-Workflow und eine
> Befehlsreferenz.

---

## Features

- 🎨 **Durchgestyltes Design** — Titelseite mit Fach-Badge, farbige
  Überschriften, Kopf-/Fußzeile, gestyltes Inhaltsverzeichnis
- 🧰 **Baukasten mit 10+ Komponenten** — Infoboxen, Merksätze, Aufgaben,
  Prozess-Abläufe, Pro/Contra, Tabellen mit Zebra-Streifen u. v. m.
- 🎯 **Ein zentraler Ort für alle Design-Tokens** — Farben, Schriften und
  Abstände ausschließlich in `config/colormeta.typ`
- 📈 **R-Anbindung** — R-Skripte erzeugen Plots und CSV-Daten, Typst bindet
  sie mit `image()` und `csv()` ein
- ⚡ **Einfachste Kompilierung** — `typst compile main.typ`, fertig
- 📄 **Einfache Kapitel-Erweiterung** — Datei in `content/` anlegen, eine
  `#include`-Zeile in `main.typ`, fertig
- 🤖 **Claude-Code-Skills** — `it-lektorat` und `lektorat` für automatisches
  Fachlektorat (in `.claude/skills/`)

Das kompilierte Beispieldokument liegt als [`main.pdf`](main.pdf) im Repo.

---

## Voraussetzungen

Nur Typst — keine LaTeX-Distribution, kein Biber, kein latexmk:

```bash
# macOS (Homebrew)
brew install typst

# Windows (winget)
winget install --id Typst.Typst

# Linux (die meisten Paketmanager) oder via Cargo
cargo install --locked typst-cli
```

Optional für die R-Anbindung: [R](https://www.r-project.org/) (`Rscript`
muss im PATH liegen). Das Template kompiliert auch ohne R — die erzeugten
Beispiel-Assets sind versioniert.

---

## Kompilieren

```bash
# Einmaliger Build → main.pdf
make build
# oder direkt:
typst compile main.typ

# Kontinuierlicher Rebuild bei Dateiänderungen
make watch

# R-Skripte ausführen (Plots/Daten nach assets/) und danach bauen
make all

# Druckbares Befehls-Cheat-Sheet → cheatsheet.pdf
make cheatsheet
```

---

## Neues Kapitel hinzufügen

1. Datei anlegen, z. B. `content/sortieren.typ`:

   ```typst
   #import "../lib/components.typ": *

   = Sortieralgorithmen

   #merksatz(title: [Stabilität])[
     Ein Sortierverfahren ist _stabil_, wenn gleiche Elemente ihre
     Reihenfolge behalten.
   ]
   ```

2. In `main.typ` einbinden:

   ```typst
   #include "content/sortieren.typ"
   ```

Das ist alles — jede Ebene-1-Überschrift (`=`) beginnt automatisch auf einer
neuen Seite.

---

## Anpassung

| Was ändern?                     | Datei                  |
|---------------------------------|------------------------|
| Autor, Matrikelnummer, Semester | `config/usermeta.typ`  |
| Titel, Fach, Beschreibung       | `config/topicmeta.typ` |
| Farben, Schriften, Abstände     | `config/colormeta.typ` |
| Eigene Komponenten              | `lib/components.typ`   |
| Layout, Kopf-/Fußzeile, TOC     | `lib/template.typ`     |
| Inhalt                          | `content/`             |

**Grundregel:** Farben und Schriften sind **ausschließlich** in
`config/colormeta.typ` definiert. Nichts anderes muss für ein Re-Design
geändert werden.

---

## Baukasten (Kurzreferenz)

```typst
// Infobox / Warnbox / Merksatz — Titel jeweils optional
#infobox(title: [Definition: Algorithmus])[ ... ]
#warnbox(title: [Achtung!])[ ... ]
#merksatz(title: [Master-Theorem])[ ... ]

// Beispiel (Chip zeigt „Beispiel: Titel")
#beispiel(title: [Quicksort auf \[3, 1, 4\]])[ ... ]

// Aufgabe mit automatischer Nummerierung
#aufgabe(title: [Laufzeitanalyse])[ ... ]
#resetaufgaben()   // Zähler zurücksetzen

// Nummerierter Ablauf — ein Argument pro Schritt
#process(
  [Erster Schritt],
  [Zweiter Schritt],
)

// Vor- und Nachteile nebeneinander
#procon(
  pro: ([Vorteil 1], [Vorteil 2]),
  con: ([Nachteil 1], [Nachteil 2]),
)

// Tabelle mit farbiger Kopfzeile und Zebra-Zeilen
#stdtable(
  columns: (auto, 1fr, 1fr),
  header: ([Algorithmus], [Komplexität], [Notiz]),
  [Bubble Sort], [$O(n^2)$], [Einfach],
)

// Zwei Inhalte nebeneinander
#zweispaltig([Inhalt links], [Inhalt rechts])

// Übersichtskarte (darf alle anderen Komponenten enthalten)
#konzeptkarte(title: [Quicksort])[ ... ]
```

Code braucht keine eigene Komponente — Typst bringt Syntax-Highlighting mit:

````typst
Inline-Code mit `Backticks`, Blöcke mit Sprachangabe:

```python
def hello():
    print("Hallo Welt")
```
````

> 🖨️ **Zum Ausdrucken:** [`cheatsheet.pdf`](cheatsheet.pdf) — alle Befehle
> mit Code und gerendertem Ergebnis auf zwei Seiten (`make cheatsheet`).

---

## R-Anbindung

R-Skripte in `r/` erzeugen Assets, die Typst direkt einbindet:

```bash
make r        # führt alle r/*.R aus
```

```typst
// Plot aus R einbinden
#figure(
  image("../assets/images/komplexitaet.png", width: 72%),
  caption: [Wachstum der O-Klassen],
)

// CSV aus R als Tabelle rendern
#let daten = csv("../assets/data/sortier_benchmark.csv")
#stdtable(
  columns: (auto, 1fr, 1fr),
  header: daten.first(),
  ..daten.slice(1).flatten(),
)
```

Das Beispielskript [`r/komplexitaet.R`](r/komplexitaet.R) kommt mit base R
aus (keine Paket-Installation nötig) und zeigt beides: Plot-Export und einen
echten Sortier-Benchmark als CSV.

Wer R-Code lieber **direkt im Dokument** schreiben will (Code-Chunks wie in
R Markdown), findet im Guide-Branch das Kapitel zu
[Quarto + RStudio](../../tree/einstieg-in-typst/docs/einstieg/03-quarto-rstudio.md).

---

## VS-Code-Einrichtung

Eine Extension genügt — [Tinymist](https://marketplace.visualstudio.com/items?itemName=myriad-dreamin.tinymist)
(Typst-LSP mit Live-Vorschau, Autocomplete und Formatter):

```bash
code --install-extension myriad-dreamin.tinymist
```

Die Projekt-Einstellungen liegen in `.vscode/settings.json`
(PDF-Export beim Speichern). Live-Vorschau: `Cmd+Shift+P` →
*Typst Preview: Preview current file*.

---

## Projektstruktur

```
typst-lernzettel-template/
├── main.typ                  ← Einstiegspunkt (Kapitel hier einbinden)
├── cheatsheet.typ            ← druckbares Befehls-Cheat-Sheet
├── config/
│   ├── usermeta.typ          ← Autor, Kurs, Matrikelnummer
│   ├── topicmeta.typ         ← Titel, Fach, Beschreibung
│   └── colormeta.typ         ← ALLE Farben, Schriften, Abstände
├── lib/
│   ├── template.typ          ← Layout, Titelseite, Überschriften, Kopfzeile
│   └── components.typ        ← Baukasten (infobox, merksatz, procon, …)
├── content/
│   ├── doku.typ              ← Baukasten-Doku mit Beispielen
│   └── example.typ           ← Beispielkapitel (inkl. R-Assets)
├── assets/
│   ├── images/               ← Abbildungen (auch aus R)
│   └── data/                 ← CSV-Daten (auch aus R)
├── r/
│   └── komplexitaet.R        ← Beispiel: Plot + Benchmark-CSV erzeugen
├── .claude/skills/           ← Claude-Code-Skills (it-lektorat, lektorat)
├── .vscode/                  ← Tinymist-Einstellungen
├── Makefile                  ← build / watch / r / all / clean
└── README.md
```

---

## Unterschiede zum LaTeX-Template

| LaTeX                                  | Typst                                    |
|----------------------------------------|------------------------------------------|
| `\begin{infobox}[Titel] … \end{infobox}` | `#infobox(title: [Titel])[ … ]`        |
| `\icode{...}`                          | `` `...` `` (Backticks)                  |
| `codebox` / `syntaxbox`                | ` ```python … ``` ` (Highlighting nativ) |
| `\sidetables{}{}` / `\kzweispaltig{}{}` | `#zweispaltig([...], [...])`            |
| `\subsubsubsection{…}`                 | `==== …` (native 4. Ebene)               |
| Kompilierung: latexmk + LuaLaTeX + Biber, ~30 s | `typst compile`, < 1 s          |
| Bibliographie (biblatex/Biber)         | bewusst weggelassen (Lernzettel)         |

---

## Lizenz

Dieses Template steht unter der [MIT-Lizenz](LICENSE).
Du kannst es frei verwenden, anpassen und weitergeben.

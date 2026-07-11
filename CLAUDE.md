# Typst-Lernzettel-Template — Kontext für Claude

Typst-Portierung eines LaTeX-Lernzettel-Templates. Deutsch ist die
Projektsprache (Inhalte, Kommentare, Commits).

## Build

```bash
typst compile main.typ   # → main.pdf (oder: make build)
typst watch main.typ     # Live-Rebuild (oder: make watch)
make r                   # R-Skripte ausführen → assets/ (benötigt Rscript)
make cheatsheet          # Befehls-Cheat-Sheet → cheatsheet.pdf
```

Erwartung: Kompilierung läuft ohne Fehler durch. Die Warnung
„unknown font family: jetbrains mono" ist harmlos (Font-Fallback auf Menlo).

## Architektur

- `main.typ` — Einstiegspunkt. Neue Kapitel = Datei in `content/` +
  `#include`-Zeile hier.
- `config/colormeta.typ` — **einzige** Quelle für Farben, Schriften, Abstände.
  Niemals Farben anderswo hart kodieren.
- `config/usermeta.typ`, `config/topicmeta.typ` — Metadaten (Autor, Titel, …).
- `lib/template.typ` — `lernzettel()`-Funktion: Seite, Titelseite,
  Überschriften, Kopf-/Fußzeile, TOC, Code-Styling (show-Regeln für `raw`).
- `lib/components.typ` — Baukasten: `infobox`, `warnbox`, `merksatz`,
  `beispiel`, `aufgabe`/`resetaufgaben`, `process`, `procon`, `stdtable`,
  `zweispaltig`, `konzeptkarte`. Gemeinsame Basis: `titledbox()`
  (Titel-Chip via `place()` über der Box-Oberkante).
- `content/doku.typ` — zeigt jede Komponente; bei Änderungen am Baukasten
  mitpflegen.
- `cheatsheet.typ` — eigenständiges, druckbares Befehls-Cheat-Sheet
  (nutzt components + colormeta, aber NICHT lib/template.typ); bei
  Baukasten-Änderungen ebenfalls mitpflegen.
- `r/*.R` — nur base R verwenden (keine Paket-Installationspflicht).
  Skripte werden im Repo-Root ausgeführt, Pfade relativ dazu.

## Konventionen

- Inline-Code/Bezeichner: Backticks (kein eigener icode-Befehl).
- Codeblöcke: ```` ```sprache ```` — Highlighting ist nativ.
- Typst-Pfade (`image()`, `csv()`) sind relativ zur aufrufenden Datei —
  aus `content/` heraus also `../assets/...`.
- Erzeugte Assets (PNG/CSV) und `main.pdf` werden versioniert, damit das
  Repo ohne R kompilierbar bleibt.

## Skills

- `.claude/skills/it-lektorat` — Fachlektorat für IT-Lernzettel in diesem Template.
- `.claude/skills/lektorat` — generelles Lektorat, fachunabhängig.

## Branches

- `main` — das Template.
- `einstieg-in-typst` — zusätzlich `docs/einstieg/` mit deutschem
  Typst-Grundlagen-Guide (Syntax, set/show vs. CSS, Quarto/RStudio, Referenz).

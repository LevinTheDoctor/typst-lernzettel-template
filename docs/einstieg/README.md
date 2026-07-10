# Einstieg in Typst

Deutschsprachiger Einstiegs-Guide für dieses Template — geschrieben für
Umsteiger:innen von LaTeX, ohne Vorwissen zu Typst.

| Kapitel | Inhalt |
|---|---|
| [1 · Typst-Grundlagen](01-typst-grundlagen.md) | Was ist Typst, Markup- vs. Code-Modus, `#`-Befehle, Funktionen, Mathe, `#import`/`#include` |
| [2 · Styling mit set und show](02-styling-set-show.md) | Das „CSS" von Typst: set-Regeln, show-Regeln, das Template-Pattern, Design-Tokens |
| [3 · R, Quarto und RStudio](03-quarto-rstudio.md) | Beide Wege der R-Anbindung: R-Skripte + `csv()`/`image()` sowie Quarto-`.qmd` mit R-Chunks in RStudio |
| [4 · Grundbefehle & Referenz](04-grundbefehle.md) | Cheat-Sheet: Markup, Mathe (LaTeX → Typst), wichtige Funktionen, alle Template-Komponenten, Stolperfallen |

**Empfohlene Reihenfolge:** einfach 1 → 4. Wer nur schnell etwas
nachschlagen will, springt direkt zu Kapitel 4.

Parallel dazu lohnt ein Blick in den Code des Templates selbst:

- `content/doku.typ` — jede Komponente einmal in Aktion
- `lib/components.typ` — wie die Komponenten gebaut sind
- `lib/template.typ` — das komplette Layout als ein einziges, lesbares Stück Typst

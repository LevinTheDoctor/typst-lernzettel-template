# 1 · Typst-Grundlagen

> Teil des [Einstiegs-Guides](README.md) —
> weiter mit [2 · Styling mit set und show](02-styling-set-show.md)

## Was ist Typst?

[Typst](https://typst.app) ist ein modernes Satzsystem — derselbe Job wie
LaTeX (aus Quelltext wird ein perfekt gesetztes PDF), aber mit einer
Sprache, die sich wie eine Mischung aus Markdown und einer richtigen
Programmiersprache anfühlt. Die wichtigsten Unterschiede zu LaTeX:

| | LaTeX | Typst |
|---|---|---|
| Kompilierzeit | Sekunden bis Minuten, mehrere Läufe | **< 1 Sekunde**, ein Lauf |
| Installation | 4+ GB (TeX Live/MacTeX) | ein einzelnes Binary (~40 MB) |
| Fehlermeldungen | kryptisch (`Undefined control sequence`) | präzise, mit Zeilenangabe und Vorschlag |
| Syntax | `\befehl{...}`, Umgebungen | Markdown-artig + `#funktion(...)` |
| Eigene Befehle | Makro-Magie (`\newcommand`, `\makeatletter`) | normale Funktionen und Variablen |

## Installation & Kompilieren

```bash
brew install typst          # macOS
winget install Typst.Typst  # Windows

typst compile main.typ      # → main.pdf
typst watch main.typ        # Live-Rebuild bei jeder Änderung
typst fonts                 # zeigt alle Schriften, die Typst sieht
```

In diesem Repo gibt es zusätzlich `make build`, `make watch` und `make all`
(führt vorher die R-Skripte aus).

## Die zwei Modi: Markup und Code

Das Wichtigste, um Typst zu verstehen: Eine `.typ`-Datei ist immer in einem
von zwei Modi.

### Markup-Modus (Standard)

Alles, was du tippst, ist Text — mit Markdown-ähnlichen Abkürzungen:

```typst
= Überschrift Ebene 1        // wie \section
== Überschrift Ebene 2       // wie \subsection
=== Ebene 3, ==== Ebene 4    // \subsubsection usw.

*fett* und _kursiv_

- Aufzählung
- noch ein Punkt

+ nummerierte Liste
+ zweiter Punkt

`Inline-Code` und Links: https://typst.app

Absätze trennst du durch eine Leerzeile. // Kommentar bis Zeilenende
/* Block-Kommentar */
```

### Code-Modus (mit `#`)

Ein `#` schaltet in den Code-Modus — dort lebt die Programmiersprache:

```typst
#let name = "Levin"          // Variable definieren
#let quadrat(x) = x * x      // Funktion definieren

Hallo #name!                 // Variable im Text verwenden → „Hallo Levin!"
$4^2 = #quadrat(4)$          // → „4² = 16"

#if quadrat(4) > 10 [groß] else [klein]

#for algo in ("Bubble", "Merge", "Quick") [
  - #algo Sort
]
```

Das ist der fundamentale Unterschied zu LaTeX: **Es gibt keine Makros,
sondern echte Variablen, Funktionen, Schleifen und if/else.** Alles, was in
diesem Template wie ein „Befehl" aussieht (`#infobox(...)`), ist eine ganz
normale Funktion, die in `lib/components.typ` mit `#let` definiert wurde.

### Content-Blöcke: `[...]`

Eckige Klammern verpacken Markup als Wert („Content"), den man an Funktionen
übergeben kann:

```typst
#infobox(title: [Definition])[
  Ein *Algorithmus* ist eine endliche Folge von Anweisungen.
]
```

Hier bekommt `infobox` zwei Dinge: das benannte Argument `title` (ein
Content-Block) und den Body (der zweite Content-Block). Das entspricht
LaTeX-Umgebungen — nur ohne `\begin`/`\end`.

## Mathe-Modus

Formeln stehen zwischen Dollarzeichen. **Mit Leerzeichen an den Rändern**
wird die Formel abgesetzt (wie `\[...\]`), ohne bleibt sie im Text (wie `$...$`):

```typst
Im Text: $O(n log n)$ ist quasilinear.

Abgesetzt:
$ T(n) = 2 T(n \/ 2) + O(n) $
```

Wichtige Unterschiede zu LaTeX-Mathe:

- Kein Backslash: `alpha`, `beta`, `sum`, `infinity` statt `\alpha` …
- Funktionen wie `log`, `sin` erkennt Typst automatisch.
- `^` und `_` wie gewohnt; mehrzeichige Exponenten in runden Klammern:
  `n^(log_b a)` statt `n^{\log_b a}`.
- Text in Formeln in Anführungszeichen: `$"links" + "rechts"$`.
- Brüche einfach mit `/`: `$n/2$` — wörtliche Schrägstriche mit `\/`.

Eine große Vergleichstabelle LaTeX ↔ Typst steht in
[4 · Grundbefehle](04-grundbefehle.md).

## Dateien aufteilen: `#import` und `#include`

Zwei Befehle, zwei Zwecke — im Template siehst du beide in `main.typ`:

```typst
#import "config/usermeta.typ": *      // holt DEFINITIONEN (Variablen, Funktionen)
#include "content/doku.typ"           // fügt INHALT ein (gerenderte Seiten)
```

- `#import` = „gib mir die `#let`-Definitionen aus dieser Datei"
  (wie `\usepackage`, aber explizit).
- `#include` = „rendere diese Datei an dieser Stelle"
  (wie `\input`).

**Deshalb ist ein neues Kapitel in diesem Template so einfach:** Datei in
`content/` anlegen, oben `#import "../lib/components.typ": *`, und in
`main.typ` eine `#include`-Zeile ergänzen.

## Pfade

Pfade in `image()`, `csv()`, `#include` sind **relativ zur Datei, in der sie
stehen**. Aus `content/example.typ` heraus heißt das Bild also
`../assets/images/komplexitaet.png`.

## Weiter

→ [2 · Styling mit set und show — das „CSS" von Typst](02-styling-set-show.md)

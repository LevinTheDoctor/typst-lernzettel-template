// cheatsheet.typ — Befehls-Cheat-Sheet für das Typst-Lernzettel-Template
// Kompilieren: typst compile cheatsheet.typ → cheatsheet.pdf (oder: make cheatsheet)
//
// Bewusst eigenständig (nutzt lib/template.typ NICHT): kompaktes
// 2-Spalten-Layout zum Ausdrucken. Komponenten und Farben kommen aus
// denselben Quellen wie das Hauptdokument.
// ─────────────────────────────────────────────────────────────────────────────

#import "config/colormeta.typ": *
#import "lib/components.typ": *

#set document(title: "Befehls-Cheat-Sheet — Typst-Lernzettel-Template")
#set text(font: mainfont, size: 8.5pt, lang: "de", region: "DE")
#set par(justify: false, spacing: 0.65em + 2pt)
#set list(indent: 0.6em)
#set heading(numbering: none)

// ── Code-Styling (kompakte Fassung der show-Regeln aus lib/template.typ) ─────
#show raw: set text(font: monofont, size: 0.95em)
#show raw.where(block: false): it => box(
  fill: codeblock,
  radius: 2pt,
  inset: (x: 2.5pt),
  outset: (y: 2.5pt),
  text(fill: primary.darken(15%), it),
)
#show raw.where(block: true): it => block(
  width: 100%,
  fill: codeblock,
  stroke: 0.5pt + codeframe,
  radius: 3pt,
  inset: 5pt,
  breakable: true,
  above: 0.8em,
  below: 0.7em,
  it,
)

// ── Kompakte Überschriften (ohne Seitenumbruch) ──────────────────────────────
#show heading.where(level: 1): it => block(above: 1.3em, below: 0.7em, {
  text(size: 10.5pt, fill: primary, weight: "bold", it.body)
  v(0.25em)
  line(length: 100%, stroke: 0.5pt + primary.lighten(50%))
})
#show heading.where(level: 2): it => block(
  above: 1em, below: 0.5em,
  text(size: 9pt, fill: accent, weight: "bold", it.body),
)

// ── Seite: 2 Spalten, Titelleiste in der Kopfzeile ──────────────────────────
#set page(
  paper: "a4",
  margin: (x: 1.1cm, top: 2.1cm, bottom: 1.4cm),
  columns: 2,
  header: {
    grid(
      columns: (1fr, auto),
      align(left + horizon,
        text(size: 10.5pt, fill: primary, weight: "bold")[Typst-Lernzettel-Template — Befehls-Cheat-Sheet]),
      align(right + horizon,
        link("https://github.com/LevinTheDoctor/typst-lernzettel-template",
          text(size: 7pt, fill: accent)[github.com/LevinTheDoctor/\ typst-lernzettel-template])),
    )
    v(-0.4em)
    line(length: 100%, stroke: 0.4pt + primary)
  },
  footer: align(center,
    text(size: 8pt, fill: primary, context counter(page).display("1 / 1", both: true))),
)

// Hilfsformat für die Nachschlage-Tabellen
#let reftable(..zeilen) = table(
  columns: (auto, 1fr),
  stroke: none,
  inset: (x: 5pt, y: 3.5pt),
  fill: (x, y) => if calc.odd(y) { tablerowalt } else { white },
  ..zeilen,
)

= Workflow

#reftable(
  [`typst compile main.typ`], [Build → `main.pdf` (`make build`)],
  [`typst watch main.typ`], [Live-Rebuild (`make watch`)],
  [`make r`], [R-Skripte → Assets in `assets/`],
  [`make all`], [R-Skripte + Build],
  [`make cheatsheet`], [dieses Blatt → `cheatsheet.pdf`],
)

*Neues Kapitel:* Datei `content/thema.typ` anlegen, oben
`#import "../lib/components.typ": *`, dann in `main.typ`:
`#include "content/thema.typ"`.

*Wo wird was eingestellt?*

#reftable(
  [`config/usermeta.typ`], [Autor, Matrikelnr., Semester],
  [`config/topicmeta.typ`], [Titel, Fach, Beschreibung],
  [`config/colormeta.typ`], [ALLE Farben, Schriften, Abstände],
  [`lib/components.typ`], [der Baukasten (Boxen, Tabellen)],
  [`lib/template.typ`], [Layout, Titelseite, Kopfzeile, TOC],
)

= Markup-Grundlagen

#reftable(
  [`= Titel`], [Überschrift 1 — *beginnt neue Seite*],
  [`==` `===` `====`], [Überschrift 2–4 (4 nicht im TOC)],
  [`*fett*`], [*fett*],
  [`_kursiv_`], [_kursiv_],
  [#raw("`code`")], [`code` (Monospace-Chip)],
  [`- Punkt`], [Aufzählung],
  [`+ Punkt`], [nummerierte Liste],
  [`/ Wort: Text`], [Beschreibungsliste],
  [`#footnote[Text]`], [Fußnote],
  [`#link("https://…")[Text]`], [Link (petrol)],
  [`#pagebreak()`], [neue Seite],
  [#raw("\\") am Zeilenende], [Zeilenumbruch],
  [`\#  \[  \]`], [wörtliche Zeichen `#` `[` `]`],
  [`// Kommentar`], [Kommentar bis Zeilenende],
)

= Mathematik

Inline: `$O(n log n)$` → $O(n log n)$ · abgesetzt: Leerzeichen nach/vor `$`.

#reftable(
  [`x^(n+1)`], [$x^(n+1)$],
  [`x_1, log_b a`], [$x_1, log_b a$],
  [`n/2` bzw. `n \/ 2`], [$n/2$ bzw. $n \/ 2$ (Bruch/Schrägstrich)],
  [`floor(n/2), ceil(n/2)`], [$floor(n/2), ceil(n/2)$],
  [`sqrt(x), abs(x)`], [$sqrt(x), abs(x)$],
  [`sum_(i=1)^n i`], [$sum_(i=1)^n i$],
  [`alpha, Theta, epsilon`], [$alpha, Theta, epsilon$],
  [`<=  >=  !=  in  subset.eq`], [$<= space >= space != space in space subset.eq$],
  [`dot  times  infinity`], [$dot space times space infinity$],
  [`RR, NN, ZZ`], [$RR, NN, ZZ$],
  [`"Text" in Formeln`], [$"Text" in "Formeln"$],
)

Fallunterscheidung:

```typst
$ f(n) = cases(1 & "falls" n = 0, n dot f(n-1) & "sonst") $
```
$ f(n) = cases(1 & "falls" n = 0, n dot f(n-1) & "sonst") $

= Boxen

Titel ist bei allen optional (`title:` weglassen → Box ohne Chip).

```typst
#infobox(title: [Definition])[…]
```
#infobox(title: [Definition])[
  Zusatzinfo, Hintergrund, Definitionen.
]

```typst
#warnbox(title: [Achtung])[…]
```
#warnbox(title: [Achtung])[
  Warnung, Stolperfalle oder Prüfungs-Tipp.
]

```typst
#merksatz(title: [Regel])[…]
```
#merksatz(title: [Regel])[
  Zentrale Kernaussage — sparsam einsetzen, maximal eine pro Abschnitt.
]

```typst
#beispiel(title: [Sortieren])[…]
```
#beispiel(title: [Sortieren])[
  Chip zeigt automatisch „Beispiel: Titel“.
]

```typst
#aufgabe(title: [Analyse])[…]
#resetaufgaben()   // Zähler auf 0
```
#aufgabe(title: [Analyse])[
  Wird automatisch durchnummeriert.
]
#resetaufgaben()

= Strukturelemente

```typst
#process(
  [Erster Schritt],
  [Zweiter Schritt],
)
```
#process(
  [Erster Schritt],
  [Zweiter Schritt],
)

```typst
#procon(
  pro: ([Vorteil 1], [Vorteil 2]),
  con: ([Nachteil 1],),
)
```
#procon(
  pro: ([Vorteil 1], [Vorteil 2]),
  con: ([Nachteil 1],),
)

#text(size: 7.5pt, fill: primary.darken(20%))[
  ⚠ Bei nur _einem_ Eintrag das Komma nicht vergessen: `pro: ([Vorteil],)`
]

```typst
#zweispaltig([links], [rechts])
```
#zweispaltig(
  [Beliebiger Inhalt links…],
  […und rechts (Tabellen, Listen, Boxen).],
)

```typst
#konzeptkarte(title: [Thema])[…]
```
#konzeptkarte(title: [Thema])[
  Übersichtskarte — darf alle anderen Komponenten enthalten,
  auch `zweispaltig` und `stdtable`.
]

= Tabellen

```typst
#stdtable(
  columns: (auto, 1fr),
  header: ([Algorithmus], [Average]),
  [Merge Sort], [$O(n log n)$],
  [Quick Sort], [$O(n log n)$],
)
```
#stdtable(
  columns: (auto, 1fr),
  header: ([Algorithmus], [Average]),
  [Merge Sort], [$O(n log n)$],
  [Quick Sort], [$O(n log n)$],
)

CSV aus R einlesen (Pfad relativ zur `.typ`-Datei!):

```typst
#let d = csv("../assets/data/datei.csv")
#stdtable(
  columns: (auto, 1fr, 1fr),
  header: d.first(),
  ..d.slice(1).flatten(),
)
```

= Code & Bilder

Codeblock mit Syntax-Highlighting — Sprache hinter die Backticks:

````typst
```python
def hello():
    print("Hallo Welt")
```
````

```python
def hello():
    print("Hallo Welt")
```

Abbildung mit Beschriftung und Referenz:

```typst
#figure(
  image("../assets/images/plot.png", width: 72%),
  caption: [Beschriftung],
) <fig-plot>

Siehe @fig-plot.
```

= Stolperfallen

- Pfade (`image()`, `csv()`, `#include`) sind relativ zur *aufrufenden
  Datei* — aus `content/` heraus: `../assets/…`
- `#` startet Code-Modus → wörtlich als `\#`
- Mehrbuchstabige Wörter in Formeln sind Variablen → `$"Text"$` quoten
- Eckige Klammern im Text escapen: `\[3, 1, 4\]`
- Warnung „unknown font family: jetbrains mono“ ist harmlos
  (Fallback auf Menlo) — verschwindet mit
  `brew install --cask font-jetbrains-mono`

# 2 · Styling mit set und show — das „CSS" von Typst

> Teil des [Einstiegs-Guides](README.md) —
> zurück zu [1 · Typst-Grundlagen](01-typst-grundlagen.md)

In LaTeX verteilt sich Styling auf Pakete, Präambel-Magie und
`\renewcommand`. In Typst gibt es genau **zwei Mechanismen**: `set` und
`show`. Wer CSS kennt, fühlt sich sofort zu Hause — die Analogie trägt
erstaunlich weit.

## set-Regeln ≈ CSS-Eigenschaften

Eine `set`-Regel setzt Standardwerte für die Argumente eines Elements —
wie eine CSS-Eigenschaft für einen Elementtyp:

```typst
#set text(font: "Helvetica Neue", size: 11pt, lang: "de")
#set par(justify: true)
#set page(paper: "a4", margin: 2.5cm)
#set heading(numbering: "1.1")
```

Das CSS-Pendant wäre sinngemäß:

```css
body    { font-family: "Helvetica Neue"; font-size: 11pt; }
p       { text-align: justify; }
@page   { size: A4; margin: 2.5cm; }
```

**Gültigkeitsbereich wie CSS-Vererbung:** Eine `set`-Regel gilt ab ihrer
Position bis zum Ende des umschließenden Blocks. Innerhalb von `[...]` oder
`{...}` gesetzt, gilt sie nur dort — wie ein Selektor, der nur einen
Container trifft:

```typst
#[
  #set text(fill: red)
  Dieser Text ist rot.
]
Dieser wieder normal.
```

## show-Regeln ≈ CSS-Selektoren

Eine `show`-Regel wählt Elemente aus und gestaltet sie um — das ist der
Selektor-Teil von CSS, nur mächtiger, weil rechts beliebiger Code stehen darf.

**Variante 1: show + set** (wie ein einfacher CSS-Selektor):

```typst
// „Alle Links petrol färben" — a { color: #048A81; }
#show link: set text(fill: rgb("#048A81"))

// „Nur Inline-Code kleiner setzen" — code:not(pre code) { font-size: 92%; }
#show raw.where(block: false): set text(size: 0.92em)
```

`.where(...)` filtert nach Eigenschaften — wie ein Attribut-Selektor
(`code[block=false]`).

**Variante 2: show mit Umbau-Funktion** (dafür gibt es in CSS kein
Gegenstück — eher ein „Komponente ersetzen"):

```typst
// Jeden Block-Code in einen grauen Kasten packen
#show raw.where(block: true): it => block(
  width: 100%,
  fill: rgb("#F5F5F5"),
  stroke: 0.5pt + rgb("#CCCCCC"),
  radius: 3pt,
  inset: 8pt,
  it,                       // ← das Original-Element
)
```

`it` ist das getroffene Element; die Funktion gibt zurück, was stattdessen
gerendert wird. Genau so entstehen in diesem Template die Überschriften mit
Farbverlauf und Trennlinie — siehe `lib/template.typ`:

```typst
#show heading.where(level: 1): it => {
  pagebreak(weak: true)                    // jedes Kapitel auf neuer Seite
  set text(size: 17pt, fill: primary, weight: "bold")
  block({
    counter(heading).display(it.numbering) // die Kapitelnummer
    h(0.75em)
    it.body                                // der Überschriften-Text
    v(0.45em)
    line(length: 100%, stroke: 0.6pt + primary.lighten(50%))
  })
}
```

## Das Template-Pattern: `#show: funktion`

Die mächtigste Form: `#show: f` schickt **das gesamte restliche Dokument**
durch die Funktion `f`. So funktionieren Typst-Templates — auch dieses:

```typst
// main.typ
#show: lernzettel.with(
  title: doctitle,
  author: docauthor,
  // ...
)
```

`lernzettel` (definiert in `lib/template.typ`) ist eine Funktion, die den
Dokumentinhalt als letztes Argument bekommt, alle `set`/`show`-Regeln
anwendet, Titelseite und Inhaltsverzeichnis voranstellt und dann den Inhalt
ausgibt. `.with(...)` füllt die Metadaten-Argumente vor.

In CSS-Sprache: Das ist das zentrale Stylesheet, das einmal eingebunden wird
— danach schreibst du nur noch semantisches „HTML" (dein Inhalt).

## Farben und Design-Tokens

Typst-Farben können gerechnet werden — das ersetzt LaTeX-Ausdrücke wie
`primary!50!white`:

```typst
#let primary = rgb("#2E4057")

primary.lighten(50%)   // LaTeX: primary!50!white
primary.darken(20%)    // LaTeX: primary!80!black
```

Dieses Template folgt dabei einer strikten Regel — alle Farben, Schriften
und Abstände liegen als Variablen in **`config/colormeta.typ`** (wie
CSS-Custom-Properties in `:root { --primary: … }`). Für ein komplettes
Re-Design musst du nur diese eine Datei anfassen.

## Spickzettel: CSS ↔ Typst

| CSS | Typst |
|---|---|
| `body { font-size: 11pt }` | `#set text(size: 11pt)` |
| `h1 { color: navy }` | `#show heading.where(level: 1): set text(fill: navy)` |
| `a { color: teal }` | `#show link: set text(fill: teal)` |
| `code[block] { … }` | `#show raw.where(block: true): …` |
| Selektor + kompletter Umbau | `#show elem: it => …` |
| `:root { --primary: … }` | `#let primary = rgb("…")` in einer Config-Datei |
| zentrales Stylesheet | `#show: template-funktion` |

## Weiter

→ [3 · R, Quarto und RStudio](03-quarto-rstudio.md)

// components.typ — Eigene Boxen und Befehle (Baukasten)
// Alle Farben kommen aus config/colormeta.typ; nichts ist hart kodiert.
// ═══════════════════════════════════════════════════════════════════════════

#import "../config/colormeta.typ": *

// ═══════════════════════════════════════════════════════════════════════════
// Basis: Box mit optionalem Titel-Chip, der oben links über den Rahmen ragt
// (Nachbau von tcolorbox „attach boxed title to top left").
// Wird von infobox, warnbox, merksatz, beispiel und aufgabe verwendet.
// ═══════════════════════════════════════════════════════════════════════════
#let titledbox(title: none, fill: white, frame: black, body) = {
  if title == none {
    block(
      width: 100%,
      fill: fill,
      stroke: 1pt + frame,
      radius: 4pt,
      inset: boxinnersep,
      breakable: true,
      above: 1.2em,
      below: 1.2em,
      body,
    )
  } else {
    block(
      width: 100%,
      inset: (top: 10pt),          // Platz für den überstehenden Titel-Chip
      above: 1.4em,
      below: 1.2em,
      breakable: true,
      {
        block(
          width: 100%,
          fill: fill,
          stroke: 1pt + frame,
          radius: 4pt,
          inset: (x: boxinnersep, top: boxinnersep + 4pt, bottom: boxinnersep),
          breakable: true,
          above: 0pt,
          below: 0pt,
          body,
        )
        place(
          top + left,
          dx: 4mm,
          dy: -10pt,               // Chip ragt über die Oberkante hinaus
          box(
            fill: frame,
            radius: 3pt,
            inset: (x: 7pt, y: 4.5pt),
            text(fill: white, weight: "bold", size: 0.9em, title),
          ),
        )
      },
    )
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// 1.  process — Nummerierter Schritt-für-Schritt-Ablauf
//     mit farbigem linken Rand. Jedes Argument ist ein Schritt.
//
//  Verwendung:
//    #process(
//      [Erster Schritt],
//      [Zweiter Schritt],
//    )
// ═══════════════════════════════════════════════════════════════════════════
#let process(..steps) = block(
  width: 100%,
  fill: stepcolor.lighten(94%),
  stroke: (left: 3pt + stepcolor),
  radius: (top-right: 3pt, bottom-right: 3pt),
  inset: (left: 10pt, right: 8pt, top: 8pt, bottom: 8pt),
  breakable: true,
  above: 1.2em,
  below: 1.2em,
  {
    for (i, s) in steps.pos().enumerate() {
      block(
        above: if i == 0 { 0pt } else { 8pt },
        below: 0pt,
        grid(
          columns: (auto, 1fr),
          column-gutter: 6pt,
          box(
            fill: stepcolor,
            radius: 2pt,
            inset: (x: 5pt, y: 2.5pt),
            baseline: 2.5pt,
            text(fill: white, weight: "bold", size: 0.8em, str(i + 1)),
          ),
          s,
        ),
      )
    }
  },
)

// ═══════════════════════════════════════════════════════════════════════════
// 2.  infobox — Farbige Infobox mit optionalem Titel
//
//  Verwendung:
//    #infobox(title: [Mein Titel])[ ... ]
//    #infobox[ ... ]                        // ohne Titel
// ═══════════════════════════════════════════════════════════════════════════
#let infobox(title: none, body) = titledbox(
  title: title, fill: infocolor, frame: infoframe, body,
)

// ═══════════════════════════════════════════════════════════════════════════
// 3.  warnbox — Warnbox / Tipp-Box mit optionalem Titel
// ═══════════════════════════════════════════════════════════════════════════
#let warnbox(title: none, body) = titledbox(
  title: title, fill: warncolor, frame: warnframe, body,
)

// ═══════════════════════════════════════════════════════════════════════════
// 4.  procon — Zwei-Spalten-Gegenüberstellung Vorteile / Nachteile
//
//  Verwendung:
//    #procon(
//      pro: ([Vorteil 1], [Vorteil 2]),
//      con: ([Nachteil 1], [Nachteil 2]),
//    )
// ═══════════════════════════════════════════════════════════════════════════
#let procon(pro: (), con: ()) = {
  let seite(titel, items, bg, frame) = block(
    width: 100%,
    stroke: 1pt + frame,
    radius: 4pt,
    fill: bg,
    clip: true,
    above: 0pt,
    below: 0pt,
    {
      block(
        width: 100%,
        fill: frame,
        inset: (x: 8pt, y: 5pt),
        above: 0pt,
        below: 0pt,
        text(fill: white, weight: "bold", titel),
      )
      block(
        width: 100%,
        inset: (x: 8pt, top: 6pt, bottom: 8pt),
        above: 0pt,
        below: 0pt,
        list(tight: true, spacing: 6pt, ..items),
      )
    },
  )
  block(
    width: 100%,
    above: 1.2em,
    below: 1.2em,
    grid(
      columns: (1fr, 1fr),
      column-gutter: 5%,
      align: top,
      seite([Vorteile], pro, procolor, proframe),
      seite([Nachteile], con, concolor, conframe),
    ),
  )
}

// ═══════════════════════════════════════════════════════════════════════════
// 5.  Code — kein eigener Befehl nötig!
//     Typst bringt Syntax-Highlighting mit; das Styling (grauer Kasten,
//     Inline-Chip) ist in lib/template.typ über show-Regeln definiert.
//
//     Codeblock:   ```python ... ```   (ersetzt codebox UND syntaxbox)
//     Inline-Code: `quicksort(arr)`    (ersetzt \icode)
// ═══════════════════════════════════════════════════════════════════════════

// ═══════════════════════════════════════════════════════════════════════════
// 6.  zweispaltig — Zwei beliebige Inhalte nebeneinander
//     (ersetzt \sidetables und \kzweispaltig aus dem LaTeX-Template)
//
//  Verwendung:
//    #zweispaltig([Inhalt links], [Inhalt rechts])
// ═══════════════════════════════════════════════════════════════════════════
#let zweispaltig(links, rechts) = block(
  width: 100%,
  above: 1.2em,
  below: 1.2em,
  grid(
    columns: (1fr, 1fr),
    column-gutter: 5%,
    align: top,
    links, rechts,
  ),
)

// ═══════════════════════════════════════════════════════════════════════════
// 7.  stdtable — Formatierte Tabelle mit farbiger Kopfzeile
//     und alternierend eingefärbten Zeilen.
//
//  Verwendung:
//    #stdtable(
//      columns: (auto, 1fr, 1fr),
//      header: ([Algorithmus], [Komplexität], [Notiz]),
//      [Bubble Sort], [$O(n^2)$], [Einfach],
//    )
// ═══════════════════════════════════════════════════════════════════════════
#let stdtable(columns: (), header: (), ..cells) = block(
  width: 100%,
  above: 1.2em,
  below: 1.2em,
  table(
    columns: columns,
    stroke: none,
    inset: (x: 8pt, y: 6pt),
    fill: (x, y) => if y == 0 { tableheader } else if calc.odd(y) { tablerowalt } else { white },
    table.header(
      ..header.map(h => text(fill: tableheadertext, weight: "bold", h)),
    ),
    ..cells,
  ),
)

// ═══════════════════════════════════════════════════════════════════════════
// 8.  merksatz — Wichtiger Satz / Merkeintrag (Indigo)
//
//  Verwendung:
//    #merksatz(title: [Satz von Pythagoras])[
//      In einem rechtwinkligen Dreieck gilt: $a^2 + b^2 = c^2$.
//    ]
// ═══════════════════════════════════════════════════════════════════════════
#let merksatz(title: none, body) = titledbox(
  title: title, fill: merksatzcolor, frame: merksatzframe, body,
)

// ═══════════════════════════════════════════════════════════════════════════
// 9.  beispiel — Beispiel-Box (Smaragdgrün), Titel immer „Beispiel[: …]"
//
//  Verwendung:
//    #beispiel(title: [Quicksort auf [3,1,4,1,5]])[
//      Pivot = 3, links: [1,1], rechts: [4,5] …
//    ]
// ═══════════════════════════════════════════════════════════════════════════
#let beispiel(title: none, body) = titledbox(
  title: if title == none { [Beispiel] } else { [Beispiel: #title] },
  fill: beispielcolor,
  frame: beispielframe,
  body,
)

// ═══════════════════════════════════════════════════════════════════════════
// 10.  aufgabe — Aufgaben-Box mit automatischer Nummerierung (Goldgelb)
//      Zähler zurücksetzen: #resetaufgaben()
//
//  Verwendung:
//    #aufgabe(title: [Laufzeitanalyse])[
//      Bestimmen Sie die Zeitkomplexität von Bubblesort.
//    ]
// ═══════════════════════════════════════════════════════════════════════════
#let aufgabe-zaehler = counter("aufgabe")
#let resetaufgaben() = aufgabe-zaehler.update(0)

#let aufgabe(title: none, body) = {
  aufgabe-zaehler.step()
  context {
    let n = aufgabe-zaehler.get().first()
    titledbox(
      title: if title == none { [Aufgabe #n] } else { [Aufgabe #n: #title] },
      fill: aufgabecolor,
      frame: aufgabeframe,
      body,
    )
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// 11.  konzeptkarte — Strukturierte Übersichtskarte mit Titelleiste.
//      Innen können alle anderen Komponenten und #zweispaltig
//      verwendet werden.
//
//  Verwendung:
//    #konzeptkarte(title: [Quicksort])[
//      Kurze Beschreibung.
//      #zweispaltig([...], [...])
//    ]
// ═══════════════════════════════════════════════════════════════════════════
#let konzeptkarte(title: [], body) = block(
  width: 100%,
  stroke: 0.8pt + primary.lighten(65%),
  radius: 5pt,
  fill: konzeptcolor,
  clip: true,
  breakable: true,
  above: 1.2em,
  below: 1.2em,
  {
    block(
      width: 100%,
      fill: primary,
      inset: (x: 10pt, y: 7pt),
      above: 0pt,
      below: 0pt,
      text(fill: white, weight: "bold", size: 1.1em, title),
    )
    block(
      width: 100%,
      inset: (x: 10pt, top: 8pt, bottom: 10pt),
      above: 0pt,
      below: 0pt,
      body,
    )
  },
)

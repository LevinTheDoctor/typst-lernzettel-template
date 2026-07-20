// formelsammlung.typ — Eigenständige, druckbare Formelsammlung
// ═══════════════════════════════════════════════════════════════════════════
// Rendert NUR das Kapitel content/Formelsammlung.typ als separates PDF –
// ohne Titelseite und ohne Inhaltsverzeichnis. Die Formeln bleiben damit in
// der content-Datei die einzige Quelle (sie ist zusätzlich in main.typ
// eingebunden); geändert wird nur dort.
//
// Kompilieren:  typst compile formelsammlung.typ   (→ formelsammlung.pdf)
//
// Das Styling (Schriften, Kopfzeile, Überschriften) spiegelt lib/template.typ
// wider, verzichtet aber bewusst auf Titelseite und TOC.
// ═══════════════════════════════════════════════════════════════════════════

#import "config/colormeta.typ": *
#import "config/topicmeta.typ": *
#import "config/usermeta.typ": *

// ── Grundschrift & Absätze ───────────────────────────────────────────────────
#set document(title: "Formelsammlung — " + doctitle, author: docauthor)
#set text(font: mainfont, size: 11pt, lang: "de", region: "DE")
#set par(justify: true, spacing: 0.65em + parskipval, first-line-indent: 0pt)
#set list(indent: 1em)
#set enum(indent: 1em)
#show link: set text(fill: accent)

// ── Seite mit Kopfzeile und Seitenzahl ───────────────────────────────────────
#set page(
  paper: "a4",
  margin: contentmargin,
  numbering: "1",
  header: {
    set text(size: 0.9em, fill: primary)
    grid(
      columns: (1fr, 1fr),
      align(left, "Formelsammlung"),
      align(right, docauthor),
    )
    v(-0.5em)
    line(length: 100%, stroke: 0.4pt)
  },
)

// ── Überschriften (identisch zu lib/template.typ) ────────────────────────────
#set heading(numbering: "1.1")

#show heading.where(level: 1): it => {
  pagebreak(weak: true)   // am Dokumentanfang wirkungslos (kein Leerblatt)
  set text(size: 17pt, fill: primary, weight: "bold")
  block(above: 1.2em, below: 1em, {
    if it.numbering != none {
      counter(heading).display(it.numbering)
      h(0.75em)
    }
    it.body
    v(0.45em)
    line(length: 100%, stroke: 0.6pt + primary.lighten(50%))
  })
}

#show heading.where(level: 2): it => {
  set text(size: 14pt, weight: "bold")
  block(above: 1.2em, below: 0.7em, {
    if it.numbering != none {
      text(fill: accent, counter(heading).display(it.numbering))
      h(0.75em)
    }
    text(fill: primary.darken(20%), it.body)
  })
}

#show heading.where(level: 3): it => {
  set text(size: 11pt, fill: accent, weight: "bold")
  block(above: 1.1em, below: 0.6em, {
    if it.numbering != none {
      counter(heading).display(it.numbering)
      h(0.75em)
    }
    it.body
  })
}

#show heading.where(level: 4): it => {
  set text(size: 11pt, fill: primary.darken(20%), weight: "bold", style: "italic")
  block(above: 1em, below: 0.5em, {
    if it.numbering != none {
      counter(heading).display(it.numbering)
      h(0.6em)
    }
    it.body
  })
}

// ── Inhalt ───────────────────────────────────────────────────────────────────
#include "content/Formelsammlung.typ"

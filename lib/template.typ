// template.typ — Seitenlayout, Schriften, Überschriften, Kopf-/Fußzeile,
// Titelseite, Inhaltsverzeichnis und Code-Styling.
// Alle Farben und Schriften kommen aus config/colormeta.typ.
// ═══════════════════════════════════════════════════════════════════════════

#import "../config/colormeta.typ": *

#let lernzettel(
  title: "",
  subtitle: "",
  subject: "",
  description: "",
  author: "",
  studentid: "",
  course: "",
  semester: "",
  date: "",
  body,
) = {
  // ── Dokument & Grundschrift ────────────────────────────────────────────────
  set document(title: title, author: author)
  set text(font: mainfont, size: 11pt, lang: "de", region: "DE")
  set par(justify: true, spacing: 0.65em + parskipval, first-line-indent: 0pt)

  // ── Listen ─────────────────────────────────────────────────────────────────
  set list(indent: 1em)
  set enum(indent: 1em)

  // ── Links ──────────────────────────────────────────────────────────────────
  show link: set text(fill: accent)

  // ── Code: Inline-Chip und Codeblock (ersetzt \icode, codebox, syntaxbox) ──
  show raw: set text(font: monofont, size: 0.92em)
  show raw.where(block: false): it => box(
    fill: codeblock,
    radius: 2pt,
    inset: (x: 3pt),
    outset: (y: 3pt),
    text(fill: primary.darken(15%), it),
  )
  show raw.where(block: true): it => block(
    width: 100%,
    fill: codeblock,
    stroke: 0.5pt + codeframe,
    radius: 3pt,
    inset: (x: 8pt, y: 8pt),
    breakable: true,
    above: 1.2em,
    below: 1.2em,
    it,
  )

  // ── Abbildungs-Beschriftungen ──────────────────────────────────────────────
  show figure.caption: it => {
    set text(size: 0.9em)
    context {
      text(weight: "bold", fill: primary)[#it.supplement #it.counter.display(it.numbering).]
      [ ]
      it.body
    }
  }

  // ── Überschriften ──────────────────────────────────────────────────────────
  set heading(numbering: "1.1")

  // Ebene 1: neue Seite, groß, primary, Linie darunter
  show heading.where(level: 1): it => {
    pagebreak(weak: true)
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

  // Ebene 2: dunkles primary, Nummer in accent
  show heading.where(level: 2): it => {
    set text(size: 14pt, weight: "bold")
    block(above: 1.2em, below: 0.7em, {
      if it.numbering != none {
        text(fill: accent, counter(heading).display(it.numbering))
        h(0.75em)
      }
      text(fill: primary.darken(20%), it.body)
    })
  }

  // Ebene 3: accent
  show heading.where(level: 3): it => {
    set text(size: 11pt, fill: accent, weight: "bold")
    block(above: 1.1em, below: 0.6em, {
      if it.numbering != none {
        counter(heading).display(it.numbering)
        h(0.75em)
      }
      it.body
    })
  }

  // Ebene 4: fett-kursiv (ersetzt \subsubsubsection; nicht im Inhaltsverzeichnis)
  show heading.where(level: 4): it => {
    set text(size: 11pt, fill: primary.darken(20%), weight: "bold", style: "italic")
    block(above: 1em, below: 0.5em, {
      if it.numbering != none {
        counter(heading).display(it.numbering)
        h(0.6em)
      }
      it.body
    })
  }

  // ── Titelseite (ohne Kopf-/Fußzeile, ohne Seitenzahl) ─────────────────────
  set page(paper: "a4", margin: contentmargin)

  {
    set align(center)
    v(2.5cm)

    // Fach-Badge
    box(
      fill: accent,
      inset: (x: 8pt, y: 5pt),
      text(fill: white, size: 0.9em, subject),
    )
    v(1.2cm)

    // Haupttitel & Untertitel
    text(size: 25pt, weight: "bold", fill: primary, title)
    v(0.5cm)
    text(size: 14pt, fill: accent, subtitle)

    v(0.8cm)
    line(length: 60%, stroke: 1.5pt + primary.lighten(60%))
    v(0.5cm)

    // Beschreibung
    text(fill: primary.darken(30%), description)

    v(1fr)

    // Metadaten-Tabelle
    grid(
      columns: (auto, auto),
      column-gutter: 8pt,
      row-gutter: 8pt,
      align: (right, left),
      ..(
        ([Autor], author),
        ([Matrikelnummer], studentid),
        ([Studiengang], course),
        ([Semester], semester),
        ([Datum], date),
      ).map(((label, wert)) => (
        text(size: 0.9em, fill: primary.darken(40%), label),
        text(wert),
      )).flatten(),
    )

    v(2cm)
    line(length: 100%, stroke: 0.6pt + primary.lighten(70%))
    v(0.3cm)
    text(size: 0.9em, fill: primary.darken(50%))[Lernzettel]
  }

  pagebreak()

  // ── Kopf- und Fußzeile für den Rest des Dokuments ─────────────────────────
  set page(
    numbering: "1",
    header: {
      set text(size: 0.9em, fill: primary)
      grid(
        columns: (1fr, 1fr),
        align(left, subject),
        align(right, author),
      )
      v(-0.5em)
      line(length: 100%, stroke: 0.4pt)
    },
  )
  counter(page).update(1)

  // ── Inhaltsverzeichnis ─────────────────────────────────────────────────────
  {
    // Titel im Stil einer Ebene-1-Überschrift (ohne Nummer, ohne TOC-Eintrag)
    block(above: 1.2em, below: 1em, {
      text(size: 17pt, fill: primary, weight: "bold")[Inhaltsverzeichnis]
      v(0.45em)
      line(length: 100%, stroke: 0.6pt + primary.lighten(50%))
    })

    show outline.entry.where(level: 1): set outline.entry(fill: none)
    show outline.entry.where(level: 1): it => {
      v(4pt)
      strong(text(fill: primary, it))
    }
    show outline.entry.where(level: 2): set text(fill: primary.darken(20%))
    show outline.entry.where(level: 3): set text(fill: primary.darken(20%))

    outline(title: none, depth: 3)
  }

  // ── Inhalt ─────────────────────────────────────────────────────────────────
  body
}

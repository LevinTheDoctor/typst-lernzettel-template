# 4 · Grundbefehle & Referenz

> Teil des [Einstiegs-Guides](README.md) —
> zurück zu [3 · R, Quarto und RStudio](03-quarto-rstudio.md)

Cheat-Sheet zum Nachschlagen: erst Typst allgemein (mit LaTeX-Übersetzung),
dann die Komponenten dieses Templates.

## Text-Markup

| Was | Typst | LaTeX |
|---|---|---|
| Überschrift 1–4 | `=`, `==`, `===`, `====` | `\section` … `\subsubsection`, eigener Befehl |
| Fett | `*fett*` | `\textbf{…}` |
| Kursiv | `_kursiv_` | `\emph{…}` / `\textit{…}` |
| Inline-Code | `` `code` `` | `\texttt{…}` / `\icode{…}` |
| Codeblock | ```` ```python … ``` ```` | `lstlisting` / `syntaxbox` |
| Aufzählung | `- Punkt` | `itemize` |
| Nummerierte Liste | `+ Punkt` | `enumerate` |
| Beschreibungsliste | `/ Begriff: Erklärung` | `description` |
| Fußnote | `#footnote[Text]` | `\footnote{…}` |
| Link | `#link("https://…")[Text]` | `\href{…}{…}` |
| Zeilenumbruch | `\` am Zeilenende | `\\` |
| Neue Seite | `#pagebreak()` | `\clearpage` |
| Geschütztes Leerzeichen | `~` | `~` |
| Kommentar | `// …` und `/* … */` | `% …` |

## Mathematik (LaTeX → Typst)

| LaTeX | Typst |
|---|---|
| `$x^{n+1}$` | `$x^(n+1)$` |
| `\frac{a}{b}` | `a/b` oder `frac(a, b)` |
| `\alpha, \beta, \Theta` | `alpha, beta, Theta` |
| `\log, \sin` | `log, sin` (automatisch erkannt) |
| `\cdot` | `dot` |
| `\times` | `times` |
| `\leq, \geq, \neq` | `<=, >=, !=` (oder `lt.eq` …) |
| `\in, \subseteq` | `in, subset.eq` |
| `\infty` | `infinity` (oder `oo`) |
| `\sum_{i=1}^{n}` | `sum_(i=1)^n` |
| `\int_0^1` | `integral_0^1` |
| `\sqrt{x}` | `sqrt(x)` |
| `\lfloor x \rfloor` | `floor(x)` |
| `\text{falls}` | `"falls"` |
| `\begin{cases}…\end{cases}` | `cases(…, …)` |
| `\mathbb{R}` | `RR` |
| Vektor `\vec{v}` | `arrow(v)` |

Abgesetzte Formel: Leerzeichen innerhalb der Dollarzeichen —
`$ E = m c^2 $` statt `\[ E = mc^2 \]`.

## Wichtige Funktionen

```typst
// Bild einbinden (Pfad relativ zur .typ-Datei!)
#image("../assets/images/plot.png", width: 70%)

// Abbildung mit Beschriftung und Label
#figure(
  image("../assets/images/plot.png"),
  caption: [Meine Beschriftung],
) <fig-plot>

// Referenz darauf
Siehe @fig-plot.

// Tabelle (roh — im Template lieber #stdtable verwenden)
#table(
  columns: (auto, 1fr),
  [Kopf A], [Kopf B],
  [Zelle], [Zelle],
)

// Raster für Layout (ohne Tabellen-Semantik)
#grid(columns: (1fr, 1fr), column-gutter: 5%, [links], [rechts])

// Daten einlesen — zur Kompilierzeit
#let daten = csv("../assets/data/werte.csv")
#let konfig = json("../assets/data/konfig.json")

// Abstände
#v(1cm)   // vertikal
#h(1fr)   // horizontal (1fr = „so viel wie geht")

// Box und Block (Grundbausteine für eigene Komponenten)
#box(fill: gray, inset: 4pt, radius: 2pt)[inline]
#block(fill: gray, inset: 10pt, width: 100%)[eigener Absatz]
```

## Komponenten dieses Templates

Definiert in `lib/components.typ` — in jeder Content-Datei verfügbar nach
`#import "../lib/components.typ": *`.

| Komponente | Zweck |
|---|---|
| `#infobox(title: [T])[…]` | Info/Definition (blau-türkis), Titel optional |
| `#warnbox(title: [T])[…]` | Warnung/Stolperfalle (amber), Titel optional |
| `#merksatz(title: [T])[…]` | Kernaussage/Regel (indigo), Titel optional |
| `#beispiel(title: [T])[…]` | Beispiel (grün), Chip „Beispiel: T" |
| `#aufgabe(title: [T])[…]` | Übungsaufgabe (gold), automatisch nummeriert |
| `#resetaufgaben()` | Aufgaben-Zähler auf 0 |
| `#process([S1], [S2], …)` | nummerierter Ablauf mit Badge je Schritt |
| `#procon(pro: (…), con: (…))` | Vorteile/Nachteile nebeneinander |
| `#stdtable(columns: …, header: (…), …)` | Tabelle mit farbigem Kopf + Zebra |
| `#zweispaltig([L], [R])` | zwei Inhalte nebeneinander |
| `#konzeptkarte(title: [T])[…]` | Übersichtskarte mit Titelleiste |

Vollständige Beispiele für jede Komponente: `content/doku.typ`
(bzw. Seiten 2–5 der kompilierten `main.pdf`).

## Typische Stolperfallen (aus LaTeX-Sicht)

1. **Pfade** sind relativ zur aufrufenden `.typ`-Datei, nicht zum
   Projekt-Root — aus `content/` heraus also `../assets/…`.
2. **`#` beginnt Code.** Ein wörtliches `#` im Text: `\#`.
3. **Mathe-Bezeichner mit mehreren Buchstaben** werden als Variablen-Namen
   interpretiert: `$abc$` sucht die Variable `abc`. Text in Formeln in
   Anführungszeichen setzen: `$"links"$`.
4. **`[…]` im Text** startet einen Content-Block. Wörtliche eckige Klammern
   escapen: `\[3, 1, 4\]`.
5. **Kein zweiter Kompilierlauf nötig** — Inhaltsverzeichnis, Referenzen und
   Zähler stimmen nach einem einzigen `typst compile`.

## Offizielle Ressourcen

- [Typst-Dokumentation](https://typst.app/docs) — Referenz aller Funktionen
- [Typst-Tutorial](https://typst.app/docs/tutorial) — offizieller 4-Kapitel-Einstieg
- [Guide für LaTeX-Umsteiger](https://typst.app/docs/guides/guide-for-latex-users/)
- [Typst Universe](https://typst.app/universe) — Pakete und Templates
- [Quarto: Typst-Format](https://quarto.org/docs/output-formats/typst.html)

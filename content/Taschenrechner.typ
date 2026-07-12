#import "../lib/components.typ": *

// Nur für die Standalone-Vorschau der Datei (IDE): Die @tr-…-Verweise brauchen
// nummerierte Überschriften. Über main.typ setzt das Template dieselbe Regel.
#set heading(numbering: "1.1")

// ── Kapitel-lokale Helfer: Tasten-Chips und Display-Nachbauten ───────────────
// Farben kommen aus config/colormeta.typ (über components.typ verfügbar);
// das LC-Display selbst ist bewusst schwarz-weiß wie die echte Hardware.

// Einzelne Taste als Chip, z. B. #taste[OPTN]
#let taste(beschriftung) = box(
  fill: primary,
  radius: 2.5pt,
  inset: (x: 4.5pt, y: 3pt),
  baseline: 3pt,
  text(font: monofont, fill: white, weight: "bold", size: 0.75em, beschriftung),
)

// Tastenfolge mit Pfeilen dazwischen: #tasten([MENU], [6], [1])
#let tasten(..t) = t.pos().map(taste).join(
  h(3pt) + text(size: 0.8em, fill: primary, sym.arrow.r) + h(3pt),
)

// Nachbau des monochromen LC-Displays: weißer Grund, schwarzer Rahmen, Monospace
#let display(breite: 4.6cm, inhalt) = box(
  width: breite,
  fill: white,
  stroke: 1.2pt + black,
  radius: 2.5pt,
  inset: 6pt,
  {
    set text(font: monofont, size: 8pt, fill: black)
    set par(leading: 0.55em, spacing: 0.55em, justify: false)
    set align(left)
    inhalt
  },
)

// Display (oder tabkalk) mit kursiver Unterschrift darunter
#let screen(unterschrift: none, breite: 4.6cm, disp) = if unterschrift == none {
  disp
} else {
  grid(
    rows: 2,
    row-gutter: 5pt,
    align: center,
    disp,
    block(
      width: breite,
      text(size: 8pt, fill: primary.darken(10%), style: "italic", unterschrift),
    ),
  )
}

// Mehrere Screens nebeneinander, zentriert
#let screens(..eintraege) = align(
  center,
  block(
    above: 1.1em,
    below: 1.1em,
    grid(
      columns: eintraege.pos().len(),
      column-gutter: 18pt,
      align: top,
      ..eintraege.pos(),
    ),
  ),
)

// Tabellenkalkulations-Ansicht: invertierte Kopfzeile und Zeilennummern wie auf
// dem Gerät, unten die Statuszeile mit dem Inhalt der aktuellen Zelle.
#let tabkalk(breite: 5.4cm, spalten: ("A", "B", "C", "D"), status: none, ..zeilen) = display(
  breite: breite,
  {
    table(
      columns: (auto,) + (1fr,) * spalten.len(),
      inset: (x: 3pt, y: 2.5pt),
      align: (col, row) => if col == 0 { center } else { right },
      stroke: 0.4pt + black,
      fill: (col, row) => if row == 0 or col == 0 { black } else { white },
      table.header([], ..spalten.map(s => text(fill: white, weight: "bold", s))),
      ..zeilen
        .pos()
        .enumerate()
        .map(((i, zeile)) => (text(fill: white, weight: "bold", str(i + 1)), ..zeile))
        .flatten(),
    )
    if status != none {
      v(2pt)
      status
    }
  },
)

= Taschenrechner: Casio fx-991DE X ClassWiz

Der _Casio fx-991DE X ClassWiz_ ist in der Klausur zugelassen – und er kann deutlich mehr als Plus und Mal: alle Kennwerte einer Stichprobe, lineare Regression samt Korrelationskoeffizient, kumulierte Normalverteilung und mit einem kleinen Trick sogar Chi-Quadrat. Dieses Kapitel zeigt die Handgriffe Schritt für Schritt; alle Anzeigen sind dem Original-Display nachgebaut.

#grid(
  columns: (1fr, 1.55fr),
  column-gutter: 6%,
  align: top,
  figure(
    image("../assets/images/Taschenrechner.png", width: 100%),
    caption: [Casio fx-991DE X ClassWiz],
  ),
  [
    *Die wichtigsten Tasten*

    #table(
      columns: (auto, 1fr),
      inset: (x: 6pt, y: 5pt),
      stroke: none,
      align: (center + horizon, left),
      table.hline(),
      table.header([*Taste*], [*Funktion*]),
      table.hline(stroke: 0.5pt),
      taste[MENU], [öffnet das Hauptmenü – von hier erreichst du alle Modi],
      taste[OPTN], [Optionen des aktuellen Modus, z. B. die Kennwerte-Berechnung],
      taste[SHIFT], [Zweitbelegung einer Taste (gelbe Beschriftung)],
      taste[ALPHA], [Drittbelegung (rot), u. a. Buchstaben und `=` für Formeln],
      taste[=], [Eingabe bestätigen bzw. Ergebnis berechnen],
      taste[AC], [Eingabe verwerfen, zurück zum Eingabebildschirm],
      taste[S⇔D], [schaltet ein Ergebnis zwischen Bruch und Dezimalzahl um],
      table.hline(),
    )
  ],
)

Für die Klausur brauchst du nur drei Menüs. Diese Tabelle ist der Wegweiser durchs Kapitel:

#stdtable(
  columns: (1fr, auto, auto),
  header: ([Aufgabe in der Klausur], [Menü], [Abschnitt]),
  [Mittelwert, Median, Quartile, Standardabweichung], [`6: Statistik`], [@tr-statistik],
  [Regressionsgerade und Korrelationskoeffizient $r$], [`6: Statistik`], [@tr-regression],
  [Summen, Zwischenrechnungen, eigene Formeln], [`8: Tabellenkalk.`], [@tr-tabkalk],
  [Wahrscheinlichkeiten der Normalverteilung], [`7: Verteilungsfkt.`], [@tr-normal],
  [Chi-Quadrat-Wert aufsummieren], [`8: Tabellenkalk.`], [@tr-chi],
)

#warnbox(title: [Kein QR-Code in der Klausur])[
  Die Original-Doku bewirbt an mehreren Stellen die Online-Visualisierung per QR-Code, etwa um Box-Plots anzuzeigen. Dafür braucht es ein Smartphone – in der Klausur fällt das also aus. Den Box-Plot zeichnest du stattdessen von Hand: Alle fünf Werte dafür (Minimum, $Q_1$, Median, $Q_3$, Maximum) liefert die Kennwerte-Berechnung aus @tr-statistik.
]

== Stichprobe und Kennwerte (Menü 6: Statistik) <tr-statistik>

#merksatz(title: [Ein Durchlauf, alle Kennwerte])[
  Stichprobe einmal in Menü `6: Statistik` eintippen, dann #tasten([OPTN], [3]) drücken: Der Rechner liefert Mittelwert, Median, beide Quartile, Minimum, Maximum und Standardabweichung in einer einzigen Liste.
]

=== Stichprobe eingeben

Als Beispiel dient die Stichprobe aus der Taschenrechner-Doku: 39, 72, 23, 22, 24, 23, 16, 21, 16, 19.

#process(
  [#tasten([MENU], [6]) öffnet das Statistik-Menü.],
  [#taste[1] wählt `1: 1-Variable` – eine Messreihe ohne zweite Variable.],
  [Jeden Wert eintippen und mit #taste[=] bestätigen; der Cursor springt automatisch in die nächste Zeile.],
)

#screens(
  screen(
    unterschrift: [Typ-Auswahl nach #tasten([MENU], [6])],
    breite: 4.2cm,
    display(breite: 4.2cm)[
      1:1-Variable\
      2:y=a+bx\
      3:y=a+bx+cx²\
      4:y=a+b·ln(x)
    ],
  ),
  screen(
    unterschrift: [Werteliste im Statistik-Editor (Ausschnitt)],
    breite: 3.4cm,
    tabkalk(
      breite: 3.4cm,
      spalten: ("x",),
      status: [22],
      ([39],), ([72],), ([23],), ([22],),
    ),
  ),
)

=== Kennwerte ablesen

#process(
  [#taste[OPTN] öffnet die Optionen des Statistik-Menüs.],
  [#taste[3] wählt `3: 1-Variab-Berech` – alle Kennwerte erscheinen als Liste.],
)

#screens(
  screen(
    unterschrift: [Optionen nach #taste[OPTN]],
    breite: 4.2cm,
    display(breite: 4.2cm)[
      1:Typ auswählen\
      2:Editor\
      3:1-Variab-Berech\
      4:Statistik-Rechn
    ],
  ),
  screen(
    unterschrift: [Ergebnisliste (auf dem Gerät mit #taste[▼] scrollen)],
    breite: 4.6cm,
    display(breite: 4.6cm)[
      #grid(
        columns: (auto, 1fr),
        column-gutter: 10pt,
        row-gutter: 4pt,
        align: (left, right),
        [x̄], [27,5],
        [Σx], [275],
        [Σx²], [10137],
        [σx], [16,04524852],
        [sx], [16,91317698],
        [n], [10],
        [min(x)], [16],
        [Q1], [19],
        [Med], [22,5],
        [Q3], [24],
        [max(x)], [72],
      )
    ],
  ),
)

So übersetzt du die Anzeige in die Begriffe aus dem Kapitel _Deskriptive Statistik_:

#table(
  columns: (auto, 1.1fr, 1fr),
  inset: (x: 8pt, y: 5pt),
  stroke: none,
  align: (left + horizon, left, left),
  table.hline(),
  table.header([*Anzeige*], [*Bedeutung*], [*Bezug zum Lernzettel*]),
  table.hline(stroke: 0.5pt),
  [x̄], [Mittelwert], [Lagemaße],
  [Σx, Σx²], [Summe der Werte bzw. ihrer Quadrate], [Zwischenwerte für die Varianz „von Hand“],
  [σx], [Standardabweichung (geteilt durch $n$)], [entspricht unserem $S$],
  [sx], [korrigierte Standardabweichung ($n - 1$)], [brauchen wir nicht],
  [n], [Anzahl der Werte], [–],
  [min(x), max(x)], [kleinster bzw. größter Wert], [Spannweite = max − min],
  [Med], [Median], [Lagemaße],
  [Q1, Q3], [unteres bzw. oberes Quartil], [$"IQR" = Q_3 - Q_1$, Box-Plot],
  table.hline(),
)

#warnbox(title: [σx oder sx?])[
  Der Rechner zeigt zwei Standardabweichungen an. Unsere Varianz-Formel teilt durch $n$ – in der Klausur liest du also *σx* ab. Das daneben stehende sx teilt durch $n - 1$ und gehört zur Inferenzstatistik; es wäre hier falsch.
]

#infobox(title: [Häufigkeitstabellen])[
  Liegt die Stichprobe als Häufigkeitstabelle vor (Wert und Anzahl), schalte die Häufigkeitsspalte ein: #tasten([SHIFT], [MENU]) → `Statistik` → `Häufigkeit Ein`. Der Editor bekommt dann eine zweite Spalte `Häufig` für die Anzahl je Wert – die Kennwerte-Berechnung funktioniert genauso.
]

== Tabellenkalkulation (Menü 8) <tr-tabkalk>

Menü `8: Tabellenkalk.` ist ein Mini-Excel mit fünf Spalten (A–E) und 45 Zeilen – praktisch für Zwischenrechnungen, Summen und alles, wofür es kein fertiges Menü gibt.

=== Werte eingeben und auswerten

#process(
  [#tasten([MENU], [8]) öffnet die Tabellenkalkulation.],
  [Werte in Spalte A eintippen, jeden mit #taste[=] bestätigen.],
  [Cursor auf eine leere Zelle setzen, #taste[OPTN] drücken und z. B. `1: Minimum` wählen.],
  [Den Bereich angeben, etwa `A1:A6` (Buchstaben über #taste[ALPHA]), und mit #taste[=] bestätigen.],
)

#screens(
  screen(
    unterschrift: [Stichprobe in Spalte A],
    breite: 4.0cm,
    tabkalk(
      breite: 4.0cm,
      spalten: ("A", "B", "C"),
      ([19], [], []), ([12], [], []), ([23], [], []),
      ([22], [], []), ([16], [], []), ([21], [], []),
    ),
  ),
  screen(
    unterschrift: [Auswahl nach #taste[OPTN] (Ausschnitt)],
    breite: 3.6cm,
    display(breite: 3.6cm)[
      1:Minimum\
      2:Maximum\
      3:Mittelwert\
      4:Summe
    ],
  ),
  screen(
    unterschrift: [Ergebnis in Zelle A7],
    breite: 4.0cm,
    tabkalk(
      breite: 4.0cm,
      spalten: ("A", "B", "C"),
      status: [Min(A1:A6)],
      ([19], [], []), ([12], [], []), ([23], [], []),
      ([22], [], []), ([16], [], []), ([21], [], []),
      ([12], [], []),
    ),
  ),
)

Genauso liefern `3: Mittelwert` → `Mean(A1:A6)` den Wert 18,8333 und `4: Summe` → `Sum(A1:A6)` den Wert 113.

=== Eigene Formeln und „Formel füllen“

Formeln funktionieren wie in Excel: Sie beginnen mit `=`, das du über #tasten([ALPHA], [CALC]) eingibst, und rechnen mit Zellbezügen. `=A1+5` in Zelle B1 addiert also 5 auf den Wert aus A1.

Damit du eine Formel nicht sechsmal eintippen musst, gibt es #taste[OPTN] → `Formel füllen`: Die Formel wird in einen ganzen Bereich kopiert, die Zellbezüge wandern automatisch mit – aus `=A2+5` wird in Zeile 3 ein `=A3+5` und so weiter.

#screens(
  screen(
    unterschrift: [Dialog „Formel füllen“],
    breite: 4.2cm,
    display(breite: 4.2cm)[
      Formel füllen\
      Formel=A2+5\
      Zellen:B2:B6
    ],
  ),
  screen(
    unterschrift: [Spalte B nach dem Füllen],
    breite: 4.4cm,
    tabkalk(
      breite: 4.4cm,
      spalten: ("A", "B", "C"),
      status: [=A2+5],
      ([19], [24], []), ([12], [17], []), ([23], [28], []),
      ([22], [27], []), ([16], [21], []), ([21], [26], []),
    ),
  ),
)

#warnbox(title: [Erst ablesen, dann Menü wechseln])[
  Die Tabellenkalkulation hat keinen Speicher: Beim Wechsel in ein anderes Menü oder beim Ausschalten sind alle Zellen leer. Ergebnisse also notieren, bevor du weiterspringst.
]

== Lineare Regression und Korrelation (Menü 6: y=a+bx) <tr-regression>

Zusammenhangsmaße laufen über dasselbe Statistik-Menü wie die Kennwerte – nur wählst du als Typ `2: y=a+bx`. Der Editor bekommt dann zwei Spalten für die Wertepaare $(x, y)$.

#process(
  [#tasten([MENU], [6], [2]) – Statistik-Menü mit Typ `2: y=a+bx`.],
  [Erst alle $x$-Werte eingeben, dann mit den Pfeiltasten in die $y$-Spalte wechseln und die $y$-Werte eintippen.],
  [#tasten([OPTN], [4]) wählt `4: Regressions-Berech` – der Rechner zeigt $a$, $b$ und $r$.],
)

#beispiel(title: [Angebotspreis und Absatzmenge (aus der Doku)])[
  Untersucht wird, wie der Angebotspreis $y$ (in €) mit der Absatzmenge $x$ zusammenhängt:

  #stdtable(
    columns: (auto, 1fr, 1fr, 1fr, 1fr),
    header: ([Zahlenpaar], [1], [2], [3], [4]),
    [Absatzmenge $x$], [109], [98], [109], [94],
    [Angebotspreis $y$], [7,3], [7,7], [9], [6,6],
  )

  #screens(
    screen(
      unterschrift: [Wertepaare im Editor],
      breite: 3.8cm,
      tabkalk(
        breite: 3.8cm,
        spalten: ("x", "y"),
        ([109], [7,3]), ([98], [7,7]), ([109], [9]), ([94], [6,6]),
      ),
    ),
    screen(
      unterschrift: [Ergebnis von `Regressions-Berech`],
      breite: 4.8cm,
      display(breite: 4.8cm)[
        y=a+bx\
        #grid(
          columns: (auto, 1fr),
          column-gutter: 8pt,
          row-gutter: 4pt,
          align: (left, right),
          [a], [-1,152259887],
          [b], [0,0858757062],
          [r], [0,6541947207],
        )
      ],
    ),
  )

  Die Regressionsgerade lautet also $y = -1","1523 + 0","0859 dot x$. Der Korrelationskoeffizient $r = 0","654$ zeigt eine mittelstarke positive Korrelation – wie du $r$ einordnest, steht im Abschnitt _r-Wert_ des Kapitels _Deskriptive Statistik_.
]

== Normalverteilung (Menü 7: Verteilungsfkt.) <tr-normal>

Die kumulierte Normalverteilung – also die Wahrscheinlichkeit, dass $X$ zwischen zwei Grenzen liegt – rechnet Menü `7: Verteilungsfkt.` direkt aus, ganz ohne z-Transformation und Tabelle.

#process(
  [#tasten([MENU], [7]) öffnet die Verteilungsfunktionen.],
  [#taste[2] wählt `2: Kumul. Normal-V`.],
  [Vier Werte eintragen, jeweils mit #taste[=]: untere Grenze, obere Grenze, σ und µ.],
  [Noch einmal #taste[=] drücken – der Rechner zeigt $P$.],
)

#warnbox(title: [Reihenfolge der Eingabe])[
  Nach den beiden Grenzen fragt der Rechner erst *σ* und dann *µ* ab – nicht andersherum. Wer die beiden vertauscht, bekommt ohne Fehlermeldung ein falsches Ergebnis.
]

Einseitige Wahrscheinlichkeiten baust du über die Grenzen nach:

#table(
  columns: (1fr, auto, auto),
  inset: (x: 8pt, y: 5pt),
  stroke: none,
  align: (left, center, center),
  table.hline(),
  table.header([*Gesucht*], [*untere Grenze*], [*obere Grenze*]),
  table.hline(stroke: 0.5pt),
  [$P(a <= X <= b)$ – zwischen zwei Grenzen], [$a$], [$b$],
  [$P(X <= b)$ – höchstens $b$], [sehr klein wählen], [$b$],
  [$P(X >= a)$ – mindestens $a$], [$a$], [sehr groß wählen],
  table.hline(),
)

„Sehr klein“ bzw. „sehr groß“ heißt: deutlich außerhalb aller plausiblen Werte – die Doku nennt das eine Notlösung. Unten reicht oft 0 (wenn keine negativen Werte vorkommen), oben z. B. 10 000.

#pagebreak()
#beispiel(title: [Abfüllanlage mit µ = 354 und σ = 10,28])[
  Eine Anlage füllt Flaschen im Mittel mit µ = 354 ml bei einer Standardabweichung von σ = 10,28 ml (Beispiel aus der Doku).

  #screens(
    screen(
      unterschrift: [Eingabemaske für Fall a)],
      breite: 4.2cm,
      display(breite: 4.2cm)[
        Kumul. Normal-V\
        #grid(
          columns: (auto, 1fr),
          column-gutter: 8pt,
          row-gutter: 4pt,
          align: (left, right),
          [Untere:], [360],
          [Obere:], [400],
          [σ:], [10,28],
          [µ:], [354],
        )
      ],
    ),
    screen(
      unterschrift: [Ergebnis für Fall a)],
      breite: 4.6cm,
      display(breite: 4.6cm)[
        P=\
        #align(right)[0,2797215279]
      ],
    ),
  )

  #table(
    columns: (1fr, auto, auto, auto),
    inset: (x: 8pt, y: 5pt),
    stroke: none,
    align: (left, center, center, right),
    table.hline(),
    table.header([*Gesucht*], [*untere*], [*obere*], [*Ergebnis*]),
    table.hline(stroke: 0.5pt),
    [a) $P(360 <= X <= 400)$], [360], [400], [0,2797],
    [b) $P(X <= 360)$], [0], [360], [0,7203],
    [c) $P(X >= 360)$], [360], [10 000], [0,2797],
    table.hline(),
  )
]

#infobox(title: [Rechenweg trotzdem hinschreiben])[
  In der Klausur zählt der Weg über die z-Transformation und die Normalverteilungstabelle (Kapitel _Normalverteilung_) – der Rechner dient zur Kontrolle. Für Fall b) von oben: z = (360 − 354) / 10,28 ≈ 0,58, Tabelle: Φ(0,58) = 0,7190. Die kleine Abweichung zum Rechnerwert 0,7203 kommt nur vom Runden auf z = 0,58.
]

#pagebreak()
== Chi-Quadrat mit der Tabellenkalkulation <tr-chi>

Für den Chi-Quadrat-Test hat der fx-991DE X kein eigenes Menü. Die Teststatistik

$ chi^2 = sum_(i=1)^k (B_i - E_i)^2 / E_i $

mit den beobachteten Häufigkeiten $B_i$ und den erwarteten Häufigkeiten $E_i$ baust du aber in drei Schritten in der Tabellenkalkulation aus @tr-tabkalk auf. Die Theorie dazu – Hypothesen, Freiheitsgrade, kritischer Wert – steht im Kapitel _Inferenzstatistik_; hier geht es nur um den Rechenweg.

#process(
  [Beobachtete Häufigkeiten in Spalte A eintippen, erwartete in Spalte B.],
  [#taste[OPTN] → `Formel füllen` mit Formel `=(A1-B1)²÷B1` und Zellen `C1:C6` – Spalte C enthält danach alle Einzelbeiträge.],
  [Die Summe in eine freie Zelle holen: `=Sum(C1:C6)` ergibt den Chi-Quadrat-Wert.],
)

#beispiel(title: [Ist der Würfel fair?])[
  Ein Würfel wird 120-mal geworfen. Bei einem fairen Würfel erwartet man 120 / 6 = 20 Würfe pro Augenzahl; beobachtet werden 25, 17, 15, 23, 24 und 16.

  #screens(
    screen(
      unterschrift: [Spalte C per „Formel füllen“, Summe in C7],
      breite: 5.2cm,
      tabkalk(
        breite: 5.2cm,
        spalten: ("A", "B", "C"),
        status: [=Sum(C1:C6)],
        ([25], [20], [1,25]), ([17], [20], [0,45]), ([15], [20], [1,25]),
        ([23], [20], [0,45]), ([24], [20], [0,8]), ([16], [20], [0,8]),
        ([], [], [5]),
      ),
    ),
  )

  Der Rechner liefert $chi^2 = 5$. Ob das „viel“ ist, entscheidet der Vergleich mit dem kritischen Wert aus der Chi-Quadrat-Tabelle (bei $k - 1 = 5$ Freiheitsgraden und α = 0,05 liegt er bei 11,07) – hier gibt es also keinen Hinweis, dass der Würfel unfair ist.
]

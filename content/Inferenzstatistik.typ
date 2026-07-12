#import "../lib/components.typ": *

// Nur für die Standalone-Vorschau der Datei (IDE): Verweise brauchen
// nummerierte Überschriften. Über main.typ setzt das Template dieselbe Regel.
#set heading(numbering: "1.1")

= Inferenzstatistik

Die deskriptive Statistik beschreibt die Daten, die man hat. Die Inferenzstatistik geht einen Schritt weiter: Sie schließt von einer Stichprobe auf die Grundgesamtheit und prüft Hypothesen – also Fragen wie „Ist dieser Würfel fair?“ oder „Ist diese Abweichung noch Zufall?“.

== Chi-Quadrat-Test

Der Chi-Quadrat-Test vergleicht *beobachtete* Häufigkeiten mit den Häufigkeiten, die man unter einer angenommenen Verteilung *erwarten* würde. Er beantwortet die Frage: Sind die Abweichungen zwischen Beobachtung und Erwartung noch zufällige Schwankung – oder so groß, dass die Annahme nicht stimmen kann?

=== Hypothesen

Wie jeder Hypothesentest beginnt der Chi-Quadrat-Test mit zwei Hypothesen:

- $H_0$ (Nullhypothese): Die Daten folgen der erwarteten Verteilung, Abweichungen sind reiner Zufall. Beispiel: „Der Würfel ist fair.“
- $H_1$ (Gegenhypothese): Die Daten folgen der erwarteten Verteilung nicht. Beispiel: „Der Würfel ist manipuliert.“

Der Test kann $H_0$ nur *verwerfen* oder *nicht verwerfen* – beweisen kann er sie nicht.

=== Die Formel

$ chi^2 = sum_(i=1)^k (O_i - E_i)^2 / E_i $

#stdtable(
  columns: (auto, 1fr),
  header: ([Zeichen], [Bedeutung]),
  [$O_i$], [beobachtete Häufigkeit (_observed_) in Kategorie $i$],
  [$E_i$], [erwartete Häufigkeit (_expected_) in Kategorie $i$: $E_i = n dot p_i$],
  [$k$], [Anzahl der Kategorien (z. B. 6 Augenzahlen)],
  [$n$], [Gesamtzahl der Beobachtungen],
)

So liest du die Formel: Für jede Kategorie wird die Abweichung $O_i - E_i$ gebildet und *quadriert* – dadurch zählen positive und negative Abweichungen gleich viel und heben sich nicht gegenseitig auf. Die Division durch $E_i$ setzt die Abweichung ins Verhältnis zur Erwartung: Eine Abweichung von 5 ist bei $E_i = 5$ dramatisch, bei $E_i = 500$ fast nichts. Zum Schluss wird über alle Kategorien summiert. Je größer $chi^2$, desto schlechter passen Beobachtung und Erwartung zusammen – bei perfekter Übereinstimmung ist $chi^2 = 0$.

=== Freiheitsgrade

$ "df" = k - 1 $

Die Zahl der Freiheitsgrade (_degrees of freedom_, df) ist die Anzahl der Kategorien minus 1.

#infobox(title: [Warum minus 1?])[
  Freiheitsgrade sind die Anzahl der *frei wählbaren* Werte. Die Gesamtzahl $n$ steht fest – und damit auch die Summe aller Häufigkeiten. Bei 6 Kategorien kannst du also nur 5 Felder frei befüllen; das letzte ergibt sich zwangsläufig als Rest. Deshalb $"df" = 6 - 1 = 5$.
]

=== Kritischer Wert und Entscheidung

Der kritische Wert $chi^2_"krit"$ ist die Schwelle, ab der eine Abweichung nicht mehr als Zufall durchgeht. Du liest ihn aus der Chi-Quadrat-Tabelle ab (sie wird in der Klausur gestellt), und zwar an der Kreuzung von zwei Angaben:

- dem *Signifikanzniveau* α – meist α = 0,05, also 5 % Irrtumswahrscheinlichkeit. Das ist das Risiko, $H_0$ zu verwerfen, obwohl sie eigentlich stimmt.
- den *Freiheitsgraden* df aus dem letzten Abschnitt.

#merksatz(title: [Entscheidungsregel])[
  $chi^2 > chi^2_"krit"$ #h(0.6em)→#h(0.6em) $H_0$ verwerfen: Die Abweichung ist signifikant. \
  $chi^2 <= chi^2_"krit"$ #h(0.6em)→#h(0.6em) $H_0$ nicht verwerfen: kein Nachweis einer Abweichung.
]

=== Ablauf in der Klausur

#process(
  [Hypothesen aufstellen: $H_0$ (erwartete Verteilung gilt) und $H_1$.],
  [Erwartete Häufigkeiten berechnen: $E_i = n dot p_i$.],
  [Teststatistik $chi^2$ mit der Formel berechnen – von Hand oder per Tabellenkalkulation (siehe Kapitel _Taschenrechner_).],
  [Freiheitsgrade bestimmen: $"df" = k - 1$.],
  [Kritischen Wert für α und df aus der gegebenen Tabelle ablesen.],
  [Vergleichen und entscheiden: Ist $chi^2 > chi^2_"krit"$, wird $H_0$ verworfen.],
)

#pagebreak()
#beispiel(title: [Ist der Würfel manipuliert? (Probeklausur)])[
  Ein Würfel wird 30-mal geworfen, getestet wird mit α = 0,05. $H_0$: „Der Würfel ist fair.“

  #table(
    columns: (auto,) + (1fr,) * 6,
    inset: (x: 6pt, y: 5pt),
    align: (left,) + (center,) * 6,
    stroke: none,
    table.hline(),
    table.header([*Augenzahl*], [*1*], [*2*], [*3*], [*4*], [*5*], [*6*]),
    table.hline(stroke: 0.5pt),
    [Beobachtet ($O_i$)], [0], [10], [10], [10], [0], [0],
    [Erwartet ($E_i$)], [5], [5], [5], [5], [5], [5],
    table.hline(),
  )

  *Erwartete Häufigkeiten:* Bei einem fairen Würfel ist $p_i = 1\/6$ für jede Augenzahl, also

  $ E_i = 30 dot 1/6 = 5 $

  *Teststatistik:* Drei Kategorien weichen um $0 - 5 = -5$ ab, drei um $10 - 5 = 5$:

  $ chi^2 = 3 dot (0 - 5)^2 / 5 + 3 dot (10 - 5)^2 / 5 = 15 + 15 = 30 $

  *Freiheitsgrade:* $"df" = k - 1 = 6 - 1 = 5$

  *Kritischer Wert:* Tabelle bei α = 0,05 und df = 5: $chi^2_"krit" = 11","07$

  *Entscheidung:* $chi^2 = 30 > 11","07$ → $H_0$ wird verworfen, der Würfel ist nicht fair.
]

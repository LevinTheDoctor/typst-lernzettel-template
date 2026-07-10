// example.typ — Beispielkapitel mit realistischem Lernzettel-Inhalt
// Demonstriert: infobox, process, procon, warnbox, Codeblock,
//               zweispaltig, stdtable, R-Grafik (image) und R-Daten (csv).
// ─────────────────────────────────────────────────────────────────────────────

#import "../lib/components.typ": *

= Grundlagen der Algorithmen

== Definition

#infobox(title: [Definition: Algorithmus])[
  Ein *Algorithmus* ist eine endliche, eindeutige Folge von Anweisungen,
  die ein Problem in einer endlichen Anzahl von Schritten löst.
  Er besitzt stets eine klare Eingabe, eine definierte Ausgabe und terminiert
  nach endlich vielen Schritten.
]

Algorithmen sind das Herzstück der Informatik. Seit Dijkstra 1959 seinen
wegweisenden Kürzeste-Wege-Algorithmus vorstellte, ist die formale Analyse
von Algorithmen ein eigenständiges Forschungsfeld.

== Eigenschaften eines korrekten Algorithmus

Ein Algorithmus muss folgende Eigenschaften erfüllen:

#process(
  [*Finitheit:* Der Algorithmus endet nach einer endlichen Anzahl von
   Schritten unter allen zulässigen Eingaben.],
  [*Eindeutigkeit:* Jede Anweisung ist klar und unmissverständlich
   definiert; kein Schritt lässt Interpretationsspielraum.],
  [*Ausführbarkeit:* Alle Schritte sind mit den zur Verfügung stehenden
   Mitteln tatsächlich durchführbar.],
  [*Determiniertheit:* Gleiche Eingaben liefern stets dasselbe Ergebnis
   (bei deterministischen Algorithmen).],
  [*Effizienz:* Der Ressourcenverbrauch (Zeit, Speicher) ist in einem
   akzeptablen Verhältnis zur Problemgröße.],
)

== Vorteile und Nachteile formaler Algorithmen

#procon(
  pro: (
    [Wiederverwendbar und übertragbar auf verschiedene Probleminstanzen],
    [Formale Korrektheitsnachweise möglich],
    [Laufzeit- und Speicherverbrauch systematisch analysierbar],
    [Unabhängig von Programmiersprache oder Plattform beschreibbar],
  ),
  con: (
    [Formale Beschreibung kann komplex und schwer lesbar werden],
    [Optimierung für konkrete Hardware oft notwendig],
    [Nicht alle Probleme sind algorithmisch lösbar (Halteproblem)],
    [Erheblicher Aufwand für den Korrektheitsbeweis],
  ),
)

== Wichtiger Hinweis zur Komplexitätsanalyse

#warnbox(title: [Achtung: Asymptotische Notation])[
  Die *O-Notation* beschreibt das _asymptotische_ Wachstum und
  ignoriert konstante Faktoren sowie untere Terme.
  Ein Algorithmus mit $O(n log n)$ kann für kleine $n$ langsamer sein als
  ein $O(n^2)$-Algorithmus mit kleinen Konstanten!
  Stets auch den _praktischen_ Anwendungsfall berücksichtigen.
]

// ─────────────────────────────────────────────────────────────────────────────
= Laufzeitkomplexität

== Überblick und Notation

#infobox(title: [Wichtige O-Klassen (von schnell nach langsam)])[
  #grid(
    columns: (auto, auto),
    column-gutter: 2em,
    row-gutter: 6pt,
    [$O(1)$], [konstant],
    [$O(log n)$], [logarithmisch],
    [$O(n)$], [linear],
    [$O(n log n)$], [quasilinear],
    [$O(n^2)$], [quadratisch],
    [$O(2^n)$], [exponentiell],
    [$O(n!)$], [faktoriell],
  )
]

== Abbildung: Wachstum der O-Klassen

Die folgende Grafik wurde mit R erzeugt (`r/komplexitaet.R`) und liegt als
PNG in `assets/images/` — so funktioniert die R-Anbindung des Templates.

#figure(
  image("../assets/images/komplexitaet.png", width: 72%),
  caption: [Wachstumsverhalten verschiedener Komplexitätsklassen für
    $n in [1, 20]$. Quelle: eigene Darstellung, erzeugt mit R.],
)

== Vergleich bekannter Sortieralgorithmen

Die folgende Tabelle vergleicht gebräuchliche Sortierverfahren anhand ihrer
asymptotischen Laufzeiten.

#stdtable(
  columns: (auto, 1fr, 1fr, 1fr, auto),
  header: ([Algorithmus], [Best Case], [Average Case], [Worst Case], [Stabil?]),
  [Bubble Sort], [$O(n)$], [$O(n^2)$], [$O(n^2)$], [Ja],
  [Selection Sort], [$O(n^2)$], [$O(n^2)$], [$O(n^2)$], [Nein],
  [Insertion Sort], [$O(n)$], [$O(n^2)$], [$O(n^2)$], [Ja],
  [Merge Sort], [$O(n log n)$], [$O(n log n)$], [$O(n log n)$], [Ja],
  [Quick Sort], [$O(n log n)$], [$O(n log n)$], [$O(n^2)$], [Nein],
  [Heap Sort], [$O(n log n)$], [$O(n log n)$], [$O(n log n)$], [Nein],
  [Counting Sort], [$O(n + k)$], [$O(n + k)$], [$O(n + k)$], [Ja],
)

=== Gemessene Laufzeiten (Daten aus R)

Diese Tabelle wird zur Kompilierzeit aus `assets/data/sortier_benchmark.csv`
gelesen — die Datei stammt aus einem echten R-Benchmark (`make r`):

#{
  let daten = csv("../assets/data/sortier_benchmark.csv")
  stdtable(
    columns: (auto, 1fr, 1fr),
    header: daten.first(),
    ..daten.slice(1).flatten(),
  )
}

=== Zwei Tabellen nebeneinander (zweispaltig)

#zweispaltig(
  [
    *Interne Sortierverfahren*

    #table(
      columns: (auto, auto),
      stroke: none,
      inset: (x: 6pt, y: 5pt),
      table.hline(stroke: 1pt),
      table.header([*Verfahren*], [*In-Place?*]),
      table.hline(stroke: 0.5pt),
      [Insertion Sort], [Ja],
      [Quick Sort], [Ja],
      [Merge Sort], [Nein],
      [Heap Sort], [Ja],
      table.hline(stroke: 1pt),
    )
  ],
  [
    *Externe Sortierverfahren*

    #table(
      columns: (auto, auto),
      stroke: none,
      inset: (x: 6pt, y: 5pt),
      table.hline(stroke: 1pt),
      table.header([*Verfahren*], [*Passes*]),
      table.hline(stroke: 0.5pt),
      [Externes Merge], [$O(log n)$],
      [Polyphasen-Merge], [$O(log n)$],
      [Replacement Sel.], [$O(n)$],
      table.hline(stroke: 1pt),
    )
  ],
)

// ─────────────────────────────────────────────────────────────────────────────
= Implementierungsbeispiel

== Merge Sort in Python

Der folgende Code zeigt eine kompakte Python-Implementierung von Merge Sort.

```python
def merge_sort(arr):
    if len(arr) <= 1:
        return arr

    mid   = len(arr) // 2
    left  = merge_sort(arr[:mid])
    right = merge_sort(arr[mid:])
    return merge(left, right)

def merge(left, right):
    result, i, j = [], 0, 0
    while i < len(left) and j < len(right):
        if left[i] <= right[j]:
            result.append(left[i]); i += 1
        else:
            result.append(right[j]); j += 1
    return result + left[i:] + right[j:]

# Beispielaufruf
data = [38, 27, 43, 3, 9, 82, 10]
print(merge_sort(data))   # -> [3, 9, 10, 27, 38, 43, 82]
```

== Laufzeit-Analyse des Merge-Sort-Schritts

#process(
  [Teile das Array der Länge $n$ in zwei Hälften der Länge $floor(n \/ 2)$
   und $ceil(n \/ 2)$.],
  [Sortiere jede Hälfte rekursiv — Laufzeit je $T(n \/ 2)$.],
  [Füge die zwei sortierten Hälften zusammen — lineare Arbeit $O(n)$.],
  [Die Rekurrenz $T(n) = 2 T(n \/ 2) + O(n)$ ergibt nach dem Master-Theorem
   $T(n) = O(n log n)$.],
)

#infobox(title: [Master-Theorem (Fall 2)])[
  Gilt $T(n) = a T(n \/ b) + Theta(n^(log_b a))$, so ist
  $T(n) = Theta(n^(log_b a) log n)$.
  Für Merge Sort: $a = 2, b = 2, f(n) = n = Theta(n^(log_2 2)) = Theta(n)$,
  also $T(n) = Theta(n log n)$.
]

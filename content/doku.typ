// doku.typ — Vorlage-Dokumentation & Referenz
// Zeigt alle Komponenten mit echten Beispielen.
// Inhalt: Sortieralgorithmen als roter Faden.
// ─────────────────────────────────────────────────────────────────────────────

#import "../lib/components.typ": *

= Informations- und Hinweis-Boxen

== infobox — Infos und Definitionen

#infobox(title: [Definition: Algorithmus])[
  Ein *Algorithmus* ist eine endliche, eindeutige Folge von Anweisungen,
  die ein Problem in endlicher Zeit löst. Jeder Algorithmus muss
  _terminieren_, _korrekt_ und _eindeutig_ sein.
]

#infobox[
  Infoboxen können auch ohne Titel verwendet werden — z. B. für kurze
  Hinweise oder ergänzende Informationen im Fließtext.
]

== warnbox — Warnhinweise und Fallstricke

#warnbox(title: [Off-by-one-Fehler])[
  Beim Zugriff auf Array-Indizes stets prüfen, ob der Index im Bereich
  $[0, n - 1]$ liegt. Ein häufiger Fehler ist der Zugriff auf Index $n$,
  was zu einer `IndexOutOfBoundsException` führt.
]

== merksatz — Wichtige Sätze und Regeln

#merksatz(title: [Master-Theorem])[
  Für Rekurrenzen der Form $T(n) = a dot T(n \/ b) + f(n)$ gilt:
  $ T(n) = cases(
    Theta(n^(log_b a)) & "falls " f(n) = O(n^(log_b a - epsilon)),
    Theta(n^(log_b a) log n) & "falls " f(n) = Theta(n^(log_b a)),
    Theta(f(n)) & "falls " f(n) = Omega(n^(log_b a + epsilon)),
  ) $
]

#merksatz[
  Merksätze können auch ohne Titel stehen — etwa für kurze, prägnante
  Regeln, die man unbedingt im Kopf behalten muss.
]

== beispiel — Konkrete Beispiele

#beispiel(title: [Quicksort auf \[3, 1, 4, 1, 5, 9\]])[
  *Pivot* = 3 (erstes Element). Partition ergibt:
  - Links $lt.eq 3$: `[1, 1]`
  - Rechts $> 3$: `[4, 5, 9]`
  Rekursiver Aufruf auf beide Teile, dann zusammensetzen:
  `[1, 1, 3, 4, 5, 9]`.
]

== aufgabe — Übungsaufgaben

#aufgabe(title: [Laufzeitanalyse])[
  Bestimmen Sie die durchschnittliche Zeitkomplexität von Quicksort mithilfe
  des Master-Theorems. Welche Rekurrenz beschreibt den Algorithmus?
]

#aufgabe[
  Implementieren Sie Mergesort in Python und vergleichen Sie die Laufzeit
  empirisch mit Bubblesort für $n in {100, 1000, 10000}$.
]

// ─────────────────────────────────────────────────────────────────────────────
= Strukturelemente

== process — Schrittfolgen

#process(
  [Pivot-Element aus der Liste wählen (z. B. erstes, letztes oder mittleres)],
  [Liste in zwei Teile partitionieren: Elemente $lt.eq$ Pivot links, $>$ Pivot rechts],
  [Quicksort rekursiv auf den linken Teilbereich anwenden],
  [Quicksort rekursiv auf den rechten Teilbereich anwenden],
  [Ergebnis: $"links" + ["pivot"] + "rechts"$],
)

== procon — Vor- und Nachteile

#procon(
  pro: (
    [Sehr schnell in der Praxis ($O(n log n)$ im Durchschnitt)],
    [In-place — kein zusätzlicher Speicher nötig],
    [Cache-freundlich durch sequentiellen Speicherzugriff],
  ),
  con: (
    [Worst-case $O(n^2)$ bei schlechter Pivot-Wahl],
    [Nicht stabil — gleiche Elemente können die Reihenfolge tauschen],
    [Rekursionstiefe kann bei großen $n$ zum Stack-Overflow führen],
  ),
)

== konzeptkarte — Strukturierte Übersichtskarte

Die #raw("konzeptkarte") fasst Beschreibung, Tabelle und Ablauf in einer
visuellen Karte zusammen. Mit `zweispaltig` lassen sich zwei Inhalte
nebeneinander setzen:

#konzeptkarte(title: [Quicksort])[
  Teile-und-herrsche-Verfahren: Die Liste wird an einem Pivot-Element
  partitioniert und beide Hälften werden rekursiv sortiert.

  #zweispaltig(
    stdtable(
      columns: (auto, 1fr),
      header: ([Eigenschaft], [Wert]),
      [Stabil], [Nein],
      [In-place], [Ja],
      [Average], [$O(n log n)$],
    ),
    process(
      [Pivot wählen],
      [Partitionieren],
      [Rekursiv sortieren],
    ),
  )
]

// ─────────────────────────────────────────────────────────────────────────────
= Code und Tabellen

== Inline-Code und Codeblöcke

Für Inline-Code genügen Backticks: Die Funktion `quicksort(arr)` gibt ein
sortiertes Array zurück. Typst bringt Syntax-Highlighting von Haus aus mit —
einfach die Sprache hinter die öffnenden Backticks schreiben:

```python
def quicksort(arr):
    if len(arr) <= 1:
        return arr
    pivot = arr[0]
    links  = [x for x in arr[1:] if x <= pivot]
    rechts = [x for x in arr[1:] if x >  pivot]
    return quicksort(links) + [pivot] + quicksort(rechts)
```

== stdtable — Formatierte Tabellen

#stdtable(
  columns: (auto, 1fr, 1fr),
  header: ([Algorithmus], [Average Case], [Notiz]),
  [Bubble Sort], [$O(n^2)$], [Nur für sehr kleine Eingaben],
  [Merge Sort], [$O(n log n)$], [Stabil, nicht in-place],
  [Quick Sort], [$O(n log n)$], [In der Praxis am schnellsten],
)

#import "../lib/components.typ": *
= R
R ist eine Programmiersprache, die speziell für Statistik und Datenvisualisierung ausgelegt ist, insbesondere durch Bibliotheken wie ggplot2. R ist kostenlos, Open Source und steht unter einer GNU-Lizenz. Als Entwicklungsumgebung kann man RStudio nutzen, da es viele nützliche Features für R mitliefert; allerdings klappt die Arbeit über Extensions auch in VS Code oder Google Colab. R ist eine interpretierte Sprache, die prozedural sowie funktional geschrieben wird, aber auch Objektorientierung unterstützt. R gibt es seit 1993.
\ 
- R ist Case Sensitive also unterscheide Groß und Klein schreibung wird unterschiden. 
- Bei R wird *.* als Dezimal kenzeichen genutzt, aslo nicht wie herkömlich ein *,*.
- Fehlende Werte als Null wird mit *NA* dargestellt.
- Zuweisungen erfolgen über *<\-*
- übergaben über *|>*
== Grundlagen
=== Datenhandling
#table(
    columns: (auto,auto),
    inset: 10pt,
    align: horizon,
    table.header([*Befehl*],[*Erklärung*]),
    ```R filter()```,
    [Beobachtung Filtern],
    ```R select()```,
    [Variablen Wählen],
    ```R mutate()```,
    [Variablen verändern / erzuegen],
    ```R case_when() ```,
    [Fall unterscheidung],
    ```R %>%; |>  ```,
    [übergabe von Ergebnissen]
)
=== Rechnen
#table(
    columns: (auto,auto),
    inset: 10pt,
    align: horizon,
    table.header([*Befehl*],[*Erklärung*]),
    ```R +```,
    [Addition],
    ```R -```,
    [Subtraktion],
    ```R *```,
    [Multiplikation],
    ```R /```,
    [Division],
    ```R ^```,
    [Potenz],
    ```R sqrt(x)```,
    [Quadratwurzel $sqrt(x)$],
    ```R exp(x)```,
    [Exponentialfunktion $e^x$],
    ```R log(x)```,
    [Natürlicher Logarithmus $ln(x)$],
    ```R abs(x)```,
    [Absolutbetrag $|x|$]
)
=== Logik
#table(
    columns: (auto,auto),
    inset: 10pt,
    align: horizon,
    table.header([*Befehl*],[*Erklärung*]),
    ```R ==```,
    [Prüfung auf Gleicheit],
    ```R !=```,
    [Prüfung auf Ungleicheit],
    ```R > ; <```,
    [Größer und Kleiner],
    ```R >= ; <=```,
    [Größer gleich und Kleiner gleich],
    ```R &```,
    [und],
    ```R |```,
    [oder]
)
== Datenanalyse
=== Grafische Verfahren
#table(
    columns: (auto,auto),
    inset: 10pt,
    align: horizon,
    table.header([*Befehl*],[*Erklärung*]),
    ```R gf_bar()```,
    [Säulendiagramm],
    ```R gf_histogram()```,
    [Histogramm],
    ```R gf_boxplot()```,
    [Boxplot],
    ```R gf_point()```,
    [Streudiagramm],
    ```R mosaicplot()```,
    [Mosaikplot (nicht ggformula)]
)
#infobox(title: [`gf_*` = ggformula = ggplot2])[
  Die `gf_*`-Befehle stammen aus dem Paket *ggformula*. Sie sind nur eine
  Formel-Schreibweise – `gf_point(umsatz ~ jahr, data = df)` –, die im
  Hintergrund ganz normale *ggplot2*-Grafiken erzeugt. Wer `gf_*` nutzt,
  arbeitet also bereits mit ggplot2, nur bequemer. Einzige Ausnahme oben:
  `mosaicplot()` gehört zu base R und *nicht* zu ggformula.
]
=== Kennzahlen
#table(
    columns: (auto,auto),
    inset: 10pt,
    align: horizon,
    table.header([*Befehl*],[*Erklärung*]),
    ```R tally()```,
    [Tabellierung, Häufigkeiten],
    ```R prop()```,
    [Anteile],
    ```R count()```,
    [Anzahl],
    ```R diffprop()```,
    [Differenz zweier Anteile],
    ```R favstats()```,
    [Kennzahlübersicht],
    ```R sum()```,
    [Summe],
    ```R diffmean()```,
    [Differenz zweier Mittelwerte],
    ```R cor()```,
    [Korrelationskoeffizient],
    ```R pdata()```,
    [Empirische Verteilungsfunktion],
    ```R qdata()```,
    [Quantilsfunktion]
)
== Grafik mit ggplot2
ggplot2 baut auf der _Grammar of Graphics_ auf: Eine Grafik entsteht
schichtweise, indem man Bausteine mit `+` aneinanderhängt. Man beschreibt
also, _was_ dargestellt werden soll, nicht _wie_ es gezeichnet wird.
#merksatz(title: [Aufbau einer ggplot-Grafik])[
  Jede Grafik besteht aus drei Kernteilen: den *Daten*, der *Ästhetik*
  (`aes`: welche Variable auf welche Achse/Farbe kommt) und mindestens einer
  *Geometrie* (`geom_*`: Balken, Punkte, Linien …).
]
```R
ggplot(df, aes(x = kategorie, y = umsatz)) +  # Daten + Zuordnung (aes)
  geom_col() +                                # Geometrie (Schicht)
  labs(title = "Umsatz", x = "Kategorie") +   # Beschriftung
  theme_minimal()                             # Aussehen / Design
```
=== Geometrien (`geom_`)
#table(
    columns: (auto,auto),
    inset: 10pt,
    align: horizon,
    table.header([*Befehl*],[*Erklärung*]),
    ```R geom_col()```,
    [Balken (Werte direkt vorgegeben)],
    ```R geom_bar()```,
    [Balken (zählt Häufigkeiten selbst)],
    ```R geom_line()```,
    [Liniendiagramm],
    ```R geom_point()```,
    [Streudiagramm],
    ```R geom_histogram(bins=30)```,
    [Histogramm],
    ```R geom_boxplot()```,
    [Boxplot],
    ```R geom_density()```,
    [Dichtekurve],
    ```R geom_tile()```,
    [Heatmap]
)
=== Bausteine (Layer)
#table(
    columns: (auto,auto),
    inset: 10pt,
    align: horizon,
    table.header([*Befehl*],[*Erklärung*]),
    ```R aes()```,
    [Zuordnung Variable → Achse / Farbe / …],
    ```R labs()```,
    [Titel und Achsenbeschriftungen],
    ```R facet_wrap(~ var)```,
    [Kleine Vielfache: ein Panel je Gruppe],
    ```R facet_grid(a ~ b)```,
    [Panel-Raster (Zeilen × Spalten)],
    ```R theme_minimal()```,
    [Aussehen / Design (auch `theme_bw()` …)],
    ```R scale_*_*()```,
    [Achsen- und Farbskalen anpassen],
    ```R ggsave("plot.png")```,
    [Grafik als Datei speichern]
)
=== Ästhetik-Zuordnungen (`aes`)
#table(
    columns: (auto,auto),
    inset: 10pt,
    align: horizon,
    table.header([*Zuordnung*],[*Erklärung*]),
    ```R x, y```,
    [Position auf x- und y-Achse],
    ```R color```,
    [Farbe (Punkte, Linien, Ränder)],
    ```R fill```,
    [Füllfarbe (Flächen, Balken)],
    ```R size```,
    [Größe der Elemente],
    ```R shape```,
    [Form der Punkte],
    ```R alpha```,
    [Transparenz (0–1)]
)
== Verteilungen & Simulation
=== Normalverteilung
#table(
    columns: (auto,auto),
    inset: 10pt,
    align: horizon,
    table.header([*Befehl*],[*Erklärung*]),
    ```R xpnorm()```,
    [Verteilungsfunktion Normalverteilung],
    ```R xqnorm()```,
    [Quantilsfunktion Normalverteilung],
    ```R gf_qq()```,
    [QQ-Plot (allgemein)]
)
=== Randomisierung & Simulation
#table(
    columns: (auto,auto),
    inset: 10pt,
    align: horizon,
    table.header([*Befehl*],[*Erklärung*]),
    ```R set.seed()```,
    [Zufallszahlengenerator setzen],
    ```R rflip()```,
    [Münzwurf],
    ```R do() *```,
    [Wiederholung (Schleife)],
    ```R sample()```,
    [Stichprobe ohne Zurücklegen],
    ```R resample()```,
    [Stichprobe mit Zurücklegen],
    ```R shuffle()```,
    [Permutation]
)
== Modellierung
#table(
    columns: (auto,auto),
    inset: 10pt,
    align: horizon,
    table.header([*Befehl*],[*Erklärung*]),
    ```R lm()```,
    [Lineare Regression],
    ```R glm(, family="binomial")```,
    [Logistische Regression],
    ```R residuals()```,
    [Residuen],
    ```R fitted()```,
    [Angepasste Werte],
    ```R predict()```,
    [Vorhersagen]
)
== Inferenz
#table(
    columns: (auto,auto),
    inset: 10pt,
    align: horizon,
    table.header([*Befehl*],[*Erklärung*]),
    ```R prop.test()```,
    [Binomialtest (approximativ)],
    ```R xchisq.test()```,
    [Chi-Quadrat-Test],
    ```R t.test()```,
    [t-Test],
    ```R aov()```,
    [Varianzanalyse]
)
== Daten einlesen
#table(
    columns: (auto,auto),
    inset: 10pt,
    align: horizon,
    table.header([*Befehl*],[*Erklärung*]),
    ```R getwd()```,
    [Aktuelles Arbeitsverzeichnis],
    ```R read.csv2("Pfad/Datei")```,
    [CSV-Tabelle einlesen],
    ```R library(readxl)```,
    [Paket für xlsx-Import laden],
    ```R read_excel("Pfad/Datei")```,
    [xlsx-Tabelle einlesen]
)
== Tidyverse
#warnbox(title: [Nicht klausurrelevant])[
  Dieser Abschnitt ist reines Hintergrundwissen (nice-to-know) und wird in
  der Klausur *nicht* abgefragt. Er soll nur einordnen, woher die vielen
  `%>%`-, `gf_*`- und `str_*`-Befehle eigentlich kommen.
]
Das _Tidyverse_ ist kein einzelnes Paket, sondern eine Sammlung von R-Paketen,
die eine gemeinsame Philosophie und einheitliche Syntax teilen. Alle sind mit
einem einzigen `library(tidyverse)` geladen.
=== Historie
#table(
    columns: (auto,auto),
    inset: 10pt,
    align: horizon,
    table.header([*Jahr*],[*Meilenstein*]),
    [2007],
    [_ggplot2_ erscheint (Hadley Wickham) und setzt die Grammar of Graphics um],
    [2014],
    [_dplyr_ löst das ältere _plyr_ ab; Wickhams Aufsatz _Tidy Data_ prägt die Idee],
    [2016],
    [Das Meta-Paket _tidyverse_ bündelt die Einzelpakete unter einem Dach],
    [2022],
    [RStudio benennt sich in _Posit_ um und pflegt das Tidyverse weiter],
)
#merksatz(title: [Tidy Data])[
  Das Ordnungsprinzip hinter dem Tidyverse: *jede Variable* ist eine Spalte,
  *jede Beobachtung* eine Zeile, *jede Beobachtungseinheit* eine Tabelle.
]
=== Kern-Pakete
#table(
    columns: (auto,auto),
    inset: 10pt,
    align: horizon,
    table.header([*Paket*],[*Zweck*]),
    ```R dplyr```,
    [Datentransformation (`filter`, `select`, `mutate`, `summarise`)],
    ```R tidyr```,
    [Daten umstrukturieren (`pivot_longer` / `pivot_wider`)],
    ```R ggplot2```,
    [Visualisierung (Grammar of Graphics)],
    ```R readr```,
    [Dateien einlesen (`read_csv`)],
    ```R tibble```,
    [Moderne Variante des `data.frame`],
    ```R purrr```,
    [Funktionales Programmieren (`map`)],
    ```R stringr```,
    [Strings bearbeiten (`str_*`)],
    ```R forcats```,
    [Faktoren / Kategorien (`fct_*`)],
    ```R lubridate```,
    [Datum und Uhrzeit],
)
#infobox(title: [Was ist ein tibble?])[
  Ein *tibble* ist die moderne Tabelle des Tidyverse – im Kern ein
  `data.frame`, nur angenehmer im Umgang:
  - Es druckt in der Konsole nur die ersten 10 Zeilen und zeigt zusätzlich
    jeden *Spaltentyp* an (`<dbl>`, `<chr>` …).
  - Es wandelt Text *nicht* heimlich in Faktoren um.
  - Es warnt bei unbekannten Spaltennamen, statt still `NULL` zurückzugeben.

  Erzeugt wird es mit `tibble(...)` oder aus einer bestehenden Tabelle per
  `as_tibble(df)`.
]
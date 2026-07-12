#import "../lib/components.typ": *
= Deskriptive Statistik
Deskriptive Statistik bedeutet, dass man versucht, Daten durch Tabellen, Kennzahlen und Grafiken übersichtlich darzustellen und zu ordnen.
== Lagemaße
=== Median
Der Median ist der mittlere Wert der sortierten Werte. Bei einer geraden Anzahl von Werten nimmt man die zwei mittelsten Werte, addiert diese und teilt sie durch 2. Bei einer ungeraden Anzahl nimmt man den mittleren Wert.
=== Modus
Der Modus ist der Wert, der am häufigsten vorkommt. Es kann mehrere Modi geben, dann ist die Verteilung multimodal.

=== Mittelwert
Der Mittelwert gibt den durchschnittlichen Wert an.

\ *Formel:* \
$ "Mittelwert" = (sum_(i=1)^n x_i)/n $
=== MAD
MAD steht für Mittlere Absolute Abweichung.

\ *Formel:* \
$ "MAD" = (sum_(i=1)^n abs("Mittelwert" - x_i))/n $
=== Quartile
Die Quartile basieren darauf, dass du deine Daten der Größe nach sortierst. Danach schneidest du die Reihe in vier gleich große Teile, also vier Viertel. Die Schnittstellen sind die Quartile.

- $Q_1$ (unteres Quartil): Unterhalb dieses Wertes liegen 25 % aller Daten.
- $Q_2$ (mittleres Quartil): Das ist genau der Median, 50 % liegen darunter.
- $Q_3$ (oberes Quartil): Unterhalb liegen 75 % aller Daten, also nur noch 25 % darüber.
#warnbox(title: [Wichtig])[
Ein Quartil ist ein Ort auf der Zahlenachse, kein Anteil.
]
=== Quartile berechnen

Zuerst werden alle Werte *aufsteigend sortiert*. Dabei ist $n$ die Anzahl der
Elemente und $x_((i))$ der Wert an Position $i$ der sortierten Liste.

$ x_p = cases(
  x_((ceil(n dot p))) &"falls" n dot p in.not ZZ,
  1/2 dot (x_((n dot p)) + x_((n dot p + 1))) &"falls" n dot p in ZZ,
) $

*Quartil 1* (unteres Quartil, $p = 0.25$):

$ Q_1 = cases(
  x_((ceil(0.25 dot n))) &"falls" 0.25 dot n in.not ZZ,
  1/2 dot (x_((0.25 dot n)) + x_((0.25 dot n + 1))) &"falls" 0.25 dot n in ZZ,
) $

*Quartil 3* (oberes Quartil, $p = 0.75$):

$ Q_3 = cases(
  x_((ceil(0.75 dot n))) &"falls" 0.75 dot n in.not ZZ,
  1/2 dot (x_((0.75 dot n)) + x_((0.75 dot n + 1))) &"falls" 0.75 dot n in ZZ,
) $

== Streuungsmaße
=== Spannweite
Der Abstand zwischen dem kleinsten und dem größten Wert.
=== Interquartilsabstand – IQR
$ "IQR" = Q_3 - Q_1 $
Der IQR ist ein Streuungsmaß, genau wie Varianz oder Standardabweichung. Er beantwortet die Frage: „Wie breit ist der Bereich, in dem die mittlere Hälfte meiner Daten liegt?“
=== Standardabweichung
Die Standardabweichung ist einfach die Wurzel aus der Varianz. Sie gibt an, wie stark die Werte im Schnitt vom Mittelwert abweichen, aber wieder in der ursprünglichen Einheit (nicht quadriert wie bei der Varianz).
*Formel:*
$ S = sqrt(S^2) $
Kann auch mit $sigma$ dargestellt werden.

=== Varianz
Varianz ist ein Maß dafür, wie stark die Werte einer Datenreihe im Durchschnitt von ihrem Mittelwert abweichen. Sie beschreibt also die Streuung der Daten. Die Varianz wird bei Einheiten (z. B. cm) quadriert angegeben, also in $"cm"^2$.
*Formel:*
$ S^2 = (sum_(i=1)^n (x_i - "Mittelwert")^2)/n $
Kann auch mit $sigma^2$ dargestellt werden.
#pagebreak()
== Zusammenhangsmaße
=== Korrelation
Eine Korrelation beschreibt eine Beziehung zwischen zwei oder mehreren Merkmalen, Zuständen oder Funktionen.
#figure(
  image("../assets/images/Kolleration.png"),
  caption: [Korrelation]
) <koleration>
=== Kovarianz
Misst, wie zwei Variablen gemeinsam um ihren Mittelwert streuen (positiv = gleichläufig, negativ = gegenläufig).
=== r-Wert – Korrelationskoeffizient
Der Korrelationskoeffizient *r* misst Stärke und Richtung eines linearen Zusammenhangs zweier metrischer Variablen, −1 ≤ r ≤ +1. Der Betrag |r| gibt die Stärke an (nahe 1 stark, nahe 0 schwach), das Vorzeichen die Richtung.
#pagebreak()
== Diagramme
=== Box-Plot
Ein Box-Plot ist ein Diagramm zur grafischen Darstellung von Minimum, Maximum, Median und den Quartilen.
\ Durch den Box-Plot erhält man einen schnellen Überblick über die Werte.
#figure(
  image("../assets/images/boxplot.png",width: 60%),
  caption:  [Box-Plot]
) <box-plot>
=== Säulendiagramm / Balkendiagramm
Häufigkeit von Merkmalsausprägungen (nominal,
ordinal, metrisch diskret).
#figure(
  image("../assets/images/saeulendiagramm.png",width: 60%),
  caption: [Säulendiagramm]
) <saeulendiagramm>
#pagebreak()
=== Streudiagramm / Scatterplot
Darstellung der Merkmalsausprägungen von zwei i.d.R.
metrischen Merkmalen. Bei kategorialen oder metrisch diskreten Merkmalen ggfs. verwackeln.
#figure(
  image("../assets/images/scatterplot.png",width: 60%),
  caption: [Streudiagramm]
) <streudiagramm>
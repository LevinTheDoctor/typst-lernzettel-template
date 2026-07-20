#import "../lib/components.typ": *

// Nur für die Standalone-Vorschau der Datei (IDE): Verweise brauchen
// nummerierte Überschriften. Über main.typ setzt das Template dieselbe Regel.
#set heading(numbering: "1.1")

= Formelsammlung

#infobox(title: [Auf einen Blick])[
  Diese Formelsammlung fasst *sämtliche Formeln* aus den vorherigen Kapiteln
  kompakt zusammen — ideal zum schnellen Nachschlagen in der Klausur. Am Ende
  folgt die *Normalverteilungstabelle*. Sie wird in der Klausur gestellt und ist
  hier nur der Vollständigkeit halber noch einmal abgedruckt.
]

Notation: $overline(x)$ ist der Mittelwert (Erwartungswert $mu$), $n$ die Anzahl
der Werte, $x_((i))$ der Wert an Position $i$ der aufsteigend sortierten Liste.

== Deskriptive Statistik

=== Lage- und Streuungsmaße

#stdtable(
  columns: (auto, auto, 1fr),
  header: ([Größe], [Formel], [Bedeutung]),
  [Mittelwert], [$overline(x) = (sum_(i=1)^n x_i) / n$],
  [durchschnittlicher Wert],
  [MAD], [$"MAD" = (sum_(i=1)^n abs(overline(x) - x_i)) / n$],
  [mittlere absolute Abweichung vom Mittelwert],
  [Varianz], [$S^2 = (sum_(i=1)^n (x_i - overline(x))^2) / n$],
  [mittlere quadratische Streuung (auch $sigma^2$); Einheit quadriert],
  [Standardabweichung], [$S = sqrt(S^2)$],
  [Streuung in der Originaleinheit (auch $sigma$)],
  [Spannweite], [$R = x_"max" - x_"min"$],
  [Abstand von größtem und kleinstem Wert],
  [IQR], [$"IQR" = Q_3 - Q_1$],
  [Breite des Bereichs der mittleren 50 % der Daten],
)

=== Quantile

Für ein $p$-Quantil ($0 < p < 1$) werden die Werte zuerst aufsteigend sortiert:

$ x_p = cases(
  x_((ceil(n dot p))) &"falls" n dot p in.not ZZ,
  1/2 dot (x_((n dot p)) + x_((n dot p + 1))) &"falls" n dot p in ZZ,
) $

$ Q_1 = x_(0.25) quad Q_2 = x_(0.5) = "Median" quad Q_3 = x_(0.75) $

=== Zusammenhangsmaße

Kovarianz — misst, wie zwei Variablen gemeinsam um ihren Mittelwert streuen
(positiv = gleichläufig, negativ = gegenläufig):

$ S_(x y) = 1/n sum_(i=1)^n (x_i - overline(x)) (y_i - overline(y)) $

Korrelationskoeffizient $r$ — Stärke und Richtung eines linearen Zusammenhangs,
$-1 <= r <= +1$ (Betrag = Stärke, Vorzeichen = Richtung):

$ r = S_(x y) / (S_x dot S_y) $

== Wahrscheinlichkeit & Normalverteilung

#stdtable(
  columns: (auto, auto, 1fr),
  header: ([Größe], [Formel], [Bedeutung]),
  [z-Transformation],
  [$z = (x - mu) / sigma$],
  [beliebige Verteilung → Standardnormalverteilung ($mu = 0$, $sigma = 1$); nötig für die Tabelle],
  [Symmetrie],
  [$Phi(-u) = 1 - Phi(u)$],
  [negative $u$-Werte aus der Tabelle bestimmen],
)

#warnbox(title: [Nur zur Vollständigkeit])[
  Die folgenden beiden Funktionen müssen wir *nicht* auswendig können — dafür
  gibt es die $z$-Transformation und die Tabelle.

  Dichtefunktion (Höhe der Glockenkurve an der Stelle $x$):
  $ f(x) = 1 / sqrt(2 pi sigma^2) e^(-(x - mu)^2 / (2 sigma^2)) $

  Verteilungsfunktion (kumulierte Wahrscheinlichkeit $P(X <= x)$):
  $ F(x) = integral_(-infinity)^x 1 / sqrt(2 pi sigma^2) e^(-(u - mu)^2 / (2 sigma^2)) dif u $
]

== Inferenzstatistik — Chi-Quadrat-Test

$ chi^2 = sum_(i=1)^k (O_i - E_i)^2 / E_i quad quad E_i = n dot p_i quad quad "df" = k - 1 $

#stdtable(
  columns: (auto, 1fr),
  header: ([Zeichen], [Bedeutung]),
  [$O_i$], [beobachtete Häufigkeit (_observed_) in Kategorie $i$],
  [$E_i$], [erwartete Häufigkeit (_expected_) in Kategorie $i$: $E_i = n dot p_i$],
  [$k$], [Anzahl der Kategorien],
  [$n$], [Gesamtzahl der Beobachtungen],
  [df], [Freiheitsgrade (_degrees of freedom_): $"df" = k - 1$],
)

#merksatz(title: [Entscheidungsregel])[
  $chi^2 > chi^2_"krit"$ #h(0.6em)→#h(0.6em) $H_0$ verwerfen: Die Abweichung ist signifikant. \
  $chi^2 <= chi^2_"krit"$ #h(0.6em)→#h(0.6em) $H_0$ nicht verwerfen: kein Nachweis einer Abweichung.
]

Den kritischen Wert $chi^2_"krit"$ liest du aus der Chi-Quadrat-Tabelle an der
Kreuzung von Signifikanzniveau $alpha$ (meist $0","05$) und Freiheitsgraden df ab.

== Normalverteilungstabelle

Die Tabelle gibt $Phi(u) = P(Z <= u)$ für die Standardnormalverteilung an. Der
$u$-Wert setzt sich aus der Zeile (erste Nachkommastelle) und der Spalte (zweite
Nachkommastelle) zusammen.

\ *Negativen Wert berechnen* \
$Phi(-u) = 1 - Phi(u)$

\ *Tabelle*
// Kopfzeile: die Nachkommastelle (zweite Stelle von u)
#let spalten-kopf = ("0,00", "0,01", "0,02", "0,03", "0,04",
                     "0,05", "0,06", "0,07", "0,08", "0,09")

// Jede Zeile: erst der u-Wert, dann die 10 Phi(u)-Werte
#let phi-zeilen = (
  ("0,0", "0,5000","0,5040","0,5080","0,5120","0,5160","0,5199","0,5239","0,5279","0,5319","0,5359"),
  ("0,1", "0,5398","0,5438","0,5478","0,5517","0,5557","0,5596","0,5636","0,5675","0,5714","0,5753"),
  ("0,2", "0,5793","0,5832","0,5871","0,5910","0,5948","0,5987","0,6026","0,6064","0,6103","0,6141"),
  ("0,3", "0,6179","0,6217","0,6255","0,6293","0,6331","0,6368","0,6406","0,6443","0,6480","0,6517"),
  ("0,4", "0,6554","0,6591","0,6628","0,6664","0,6700","0,6736","0,6772","0,6808","0,6844","0,6879"),
  ("0,5", "0,6915","0,6950","0,6985","0,7019","0,7054","0,7088","0,7123","0,7157","0,7190","0,7224"),
  ("0,6", "0,7257","0,7291","0,7324","0,7357","0,7389","0,7422","0,7454","0,7486","0,7517","0,7549"),
  ("0,7", "0,7580","0,7611","0,7642","0,7673","0,7704","0,7734","0,7764","0,7794","0,7823","0,7852"),
  ("0,8", "0,7881","0,7910","0,7939","0,7967","0,7995","0,8023","0,8051","0,8079","0,8106","0,8133"),
  ("0,9", "0,8159","0,8186","0,8212","0,8238","0,8264","0,8289","0,8315","0,8340","0,8365","0,8389"),
  ("1,0", "0,8413","0,8438","0,8461","0,8485","0,8508","0,8531","0,8554","0,8577","0,8599","0,8621"),
  ("1,1", "0,8643","0,8665","0,8686","0,8708","0,8729","0,8749","0,8770","0,8790","0,8810","0,8830"),
  ("1,2", "0,8849","0,8869","0,8888","0,8907","0,8925","0,8944","0,8962","0,8980","0,8997","0,9015"),
  ("1,3", "0,9032","0,9049","0,9066","0,9082","0,9099","0,9115","0,9131","0,9147","0,9162","0,9177"),
  ("1,4", "0,9192","0,9207","0,9222","0,9236","0,9251","0,9265","0,9279","0,9292","0,9306","0,9319"),
  ("1,5", "0,9332","0,9345","0,9357","0,9370","0,9382","0,9394","0,9406","0,9418","0,9429","0,9441"),
  ("1,6", "0,9452","0,9463","0,9474","0,9484","0,9495","0,9505","0,9515","0,9525","0,9535","0,9545"),
  ("1,7", "0,9554","0,9564","0,9573","0,9582","0,9591","0,9599","0,9608","0,9616","0,9625","0,9633"),
  ("1,8", "0,9641","0,9649","0,9656","0,9664","0,9671","0,9678","0,9686","0,9693","0,9699","0,9706"),
  ("1,9", "0,9713","0,9719","0,9726","0,9732","0,9738","0,9744","0,9750","0,9756","0,9761","0,9767"),
  ("2,0", "0,9773","0,9778","0,9783","0,9788","0,9793","0,9798","0,9803","0,9808","0,9812","0,9817"),
  ("2,1", "0,9821","0,9826","0,9830","0,9834","0,9838","0,9842","0,9846","0,9850","0,9854","0,9857"),
  ("2,2", "0,9861","0,9864","0,9868","0,9871","0,9875","0,9878","0,9881","0,9884","0,9887","0,9890"),
  ("2,3", "0,9893","0,9896","0,9898","0,9901","0,9904","0,9906","0,9909","0,9911","0,9913","0,9916"),
  ("2,4", "0,9918","0,9920","0,9922","0,9925","0,9927","0,9929","0,9931","0,9932","0,9934","0,9936"),
  ("2,5", "0,9938","0,9940","0,9941","0,9943","0,9945","0,9946","0,9948","0,9949","0,9951","0,9952"),
  ("2,6", "0,9953","0,9955","0,9956","0,9957","0,9959","0,9960","0,9961","0,9962","0,9963","0,9964"),
  ("2,7", "0,9965","0,9966","0,9967","0,9968","0,9969","0,9970","0,9971","0,9972","0,9973","0,9974"),
  ("2,8", "0,9974","0,9975","0,9976","0,9977","0,9977","0,9978","0,9979","0,9979","0,9980","0,9981"),
  ("2,9", "0,9981","0,9982","0,9983","0,9983","0,9984","0,9984","0,9985","0,9985","0,9986","0,9986"),
)

#[
#set text(size: 8pt)  // damit 12 Spalten auf die Seite passen

#table(
  // 12 Spalten: u links, 10 Werte, u rechts (wie im Original)
  columns: (auto,) + (1fr,) * 10 + (auto,),
  inset: 4pt,
  align: center + horizon,
  stroke: none,                       // keine Gitterlinien, nur gezielte Striche
  table.hline(),                      // Linie oben
  table.header(
    [*u*],
    ..spalten-kopf.map(kopf => [*#kopf*]),   // 10 Kopfzellen aus dem Array
    [*u*],
  ),
  table.hline(),                      // Linie unter dem Header
  // Fuer jede Zeile: u-Wert, alle 10 Werte, u-Wert nochmal
  ..phi-zeilen.map(zeile => (
    [*#zeile.at(0)*],                 // erste Spalte: u
    ..zeile.slice(1).map(wert => [#wert]),
    [*#zeile.at(0)*],                 // letzte Spalte: u
  )).flatten(),
  table.hline(),                      // Linie unten
  // Vertikale Trennstriche links und rechts vom Werteblock
  table.vline(x: 1), table.vline(x: 11),
)
]
\ *Quantiltabelle* \
Die Quantiltabelle liefert den umgekehrten Weg: zu einer Wahrscheinlichkeit $p$
den zugehörigen $u$-Wert $u_p$ (mit $Phi(u_p) = p$).
#let quantile = (
  ("0,8", "0,84162"), ("0,9", "1,28155"), ("0,95", "1,6449"),
  ("0,975", "1,9600"), ("0,98", "2,0538"), ("0,99", "2,3264"),
  ("0,995", "2,5758"),
)

#table(
  columns: (auto,) + (1fr,) * quantile.len(),  // 1 Beschriftungsspalte + n Werte
  inset: 6pt,
  align: center,
  stroke: none,
  table.hline(),
  [$p$],   ..quantile.map(paar => [#paar.at(0)]),
  table.hline(stroke: 0.5pt),
  [$u_p$], ..quantile.map(paar => [#paar.at(1)]),
  table.hline(),
  table.vline(x: 1),
)

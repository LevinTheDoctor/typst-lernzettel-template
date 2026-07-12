Demowerte <- function(Mittelwert, Standardabweichung) {
  index <- 3
  werte <- c(Mittelwert)
  negativ <- c()
  
  while (index >= 1) {
    negativ <- c(negativ, Mittelwert - Standardabweichung * index)
    index <- index - 1
  }
  
  positiv <- c()
  index <- 1
  
  while (index <= 3) {
    positiv <- c(positiv, Mittelwert + Standardabweichung * index)
    index <- index + 1
  }
  
  # WICHTIG: hier muss "werte" ueberschrieben werden, nicht "Demowerte"!
  # sonst bleibt werte nur c(Mittelwert) und seq() hat keine Spannweite
  werte <- c(negativ, werte, positiv)
  
  nv_werte <- seq(min(werte), max(werte), length.out = 300)
  
  ergebnis <- list(
    Mittelwert = Mittelwert,
    Standardabweichung = Standardabweichung,
    werte = werte,
    nv_werte = nv_werte,
    varianz = Standardabweichung^2
  )
  
  return(ergebnis)
}

NormalVerteilung_Plot_func <- function(demowerte_liste) {
  library(ggplot2)
  
  y_kurve <- dnorm(
    demowerte_liste$nv_werte,
    mean = demowerte_liste$Mittelwert,
    sd = demowerte_liste$Standardabweichung
  )
  daten_kurve <- data.frame(x = demowerte_liste$nv_werte, y = y_kurve)
  
  daten_punkte <- data.frame(
    x = demowerte_liste$werte,
    y = dnorm(
      demowerte_liste$werte,
      mean = demowerte_liste$Mittelwert,
      sd = demowerte_liste$Standardabweichung
    )
  )
  
  plot <- ggplot(daten_kurve, aes(x = x, y = y)) +
    # geom_area faerbt die komplette Flaeche unter der Kurve ein
    # fill = Fuellfarbe (entspricht "col" aus Base-R), color = Randlinie (entspricht "border")
    geom_area(fill = "#DDF3F5", color = "#048A81", linewidth = 1) +
    geom_point(data = daten_punkte, aes(x = x, y = y), color = "darkred", size = 2) +
    geom_vline(xintercept = demowerte_liste$werte, linetype = "dashed", color = "grey60") +
    labs(title = "Normalverteilung", x = "x", y = "Dichte") +
    theme_minimal()
  
  return(plot)
}

Wahrscheinlichkeit_Plot_func <- function(demowerte_liste, x_wert) {
  library(ggplot2)
  
  y_kurve <- dnorm(
    demowerte_liste$nv_werte,
    mean = demowerte_liste$Mittelwert,
    sd = demowerte_liste$Standardabweichung
  )
  daten_kurve <- data.frame(x = demowerte_liste$nv_werte, y = y_kurve)
  
  # subset() filtert nur die Zeilen, bei denen x kleiner/gleich x_wert ist,
  # das ist die Teilflaeche, die wir einfaerben wollen
  daten_flaeche <- subset(daten_kurve, x <= x_wert)
  
  # pnorm() berechnet die kumulierte Wahrscheinlichkeit P(X <= x_wert),
  # also genau die Flaeche unter der Kurve bis zu diesem Punkt
  wahrscheinlichkeit <- pnorm(
    x_wert,
    mean = demowerte_liste$Mittelwert,
    sd = demowerte_liste$Standardabweichung
  )
  
  plot <- ggplot(daten_kurve, aes(x = x, y = y)) +
    # erst die gesamte Kurve als duenne Linie zeichnen
    geom_line(color = "steelblue", linewidth = 1) +
    # dann NUR den gefilterten Teil (bis x_wert) als Flaeche einfaerben
    geom_area(data = daten_flaeche, aes(x = x, y = y), fill = "#DDF3F5", color = "#048A81", linewidth = 1) +
    geom_vline(xintercept = x_wert, linetype = "dashed", color = "darkred") +
    labs(
      title = "Wahrscheinlichkeit der Normalverteilung",
      # paste0() haengt Text und Werte ohne Leerzeichen dazwischen zusammen
      # round(..., 4) rundet die Wahrscheinlichkeit auf 4 Nachkommastellen
      subtitle = paste0("P(X <= ", x_wert, ") = ", round(wahrscheinlichkeit, 4)),
      x = "x", y = "Dichte"
    ) +
    theme_minimal()
  
  return(plot)
}

# Beispiel: Wahrscheinlichkeit, dass X <= 3 ist, bei Mittelwert 0, Standardabweichung 3


NormalVerteilung_Plot_func(Demowerte(0, 3))

Wahrscheinlichkeit_Plot_func(Demowerte(0, 3), 3)
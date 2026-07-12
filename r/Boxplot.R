# ============================================================
# Boxplot Funktion - Base R Version
# Zeichnet die Box manuell, damit Position und Beschriftung
# der 5 Kennzahlen exakt kontrollierbar sind
# ============================================================

boxplot_func <- function(werte, q1_prozent, q3_prozent, dateipfad = NULL) {
  # Fuenf-Punkte-Zusammenfassung berechnen
  sortierte_werte <- sort(werte)
  werte_min    <- min(werte)
  werte_max    <- max(werte)
  werte_median <- median(werte)
  
  # Index-Methode: index = n * p, aufgerundet (ceiling)
  q1_index <- ceiling(length(werte) * q1_prozent)
  q3_index <- ceiling(length(werte) * q3_prozent)
  werte_q1 <- sortierte_werte[q1_index]
  werte_q3 <- sortierte_werte[q3_index]
  
  # innere Hilfsfunktion, die die eigentliche Zeichnung uebernimmt
  # so bleibt der Zeichencode getrennt von der Entscheidung,
  # ob auf den Bildschirm oder in eine PNG-Datei gezeichnet wird
  zeichne_boxplot <- function() {
    # aeusseren Rand fuer die Achsenbeschriftung reservieren
    par(mar = c(4, 2, 2, 2))
    
    # leeres Koordinatensystem: x von 0 bis 100, y als Dummy-Bereich
    plot(NA, xlim = c(0, 100), ylim = c(0, 1),
         xlab = "", ylab = "", yaxt = "n", bty = "n",
         xaxt = "n")
    
    # x-Achse mit Beschriftung in 10er-Schritten
    axis(1, at = seq(0, 100, by = 10), cex.axis = 0.9)
    
    # geometrische Hoehen der Box festlegen
    box_unten <- 0.35
    box_oben  <- 0.65
    mitte     <- 0.5
    
    # Whisker-Linien (Antennen) von Min bis Q1 und von Q3 bis Max
    segments(werte_min, mitte, werte_q1, mitte, lwd = 2)
    segments(werte_q3, mitte, werte_max, mitte, lwd = 2)
    
    # vertikale Endkappen an Min und Max
    segments(werte_min, box_unten + 0.05, werte_min, box_oben - 0.05, lwd = 2)
    segments(werte_max, box_unten + 0.05, werte_max, box_oben - 0.05, lwd = 2)
    
    # die Box von Q1 bis Q3
    rect(werte_q1, box_unten, werte_q3, box_oben,
         col = "#DDF3F5", border = "#048A81", lwd = 2)
    
    # Median-Linie innerhalb der Box
    segments(werte_median, box_unten, werte_median, box_oben, lwd = 3, col = "#048A81")
    
    # Beschriftung ueber der Grafik, versetzte Hoehen (0.12 / 0.20)
    # damit sich eng beieinander liegende Werte (z.B. Min und Q1) nicht ueberlappen
    text(werte_min,    box_oben + 0.12, paste0("Min\n", werte_min),    cex = 0.75)
    text(werte_q1,     box_oben + 0.20, paste0("Q1\n", werte_q1),      cex = 0.75)
    text(werte_median, box_oben + 0.12, paste0("Median\n", werte_median), cex = 0.75)
    text(werte_q3,     box_oben + 0.20, paste0("Q3\n", werte_q3),      cex = 0.75)
    text(werte_max,    box_oben + 0.12, paste0("Max\n", werte_max),    cex = 0.75)
  }
  
  # nur wenn ein Dateipfad uebergeben wurde, wird als PNG gespeichert
  # sonst erscheint der Plot direkt im R Plot-Fenster (z.B. in RStudio)
  if (!is.null(dateipfad)) {
    png(dateipfad, width = 2000, height = 900, res = 200)
    zeichne_boxplot()
    dev.off()
    cat("Boxplot gespeichert unter", dateipfad, "\n")
  } else {
    zeichne_boxplot()
  }
}

werte <- c(3,5,5,18,72,56,56,39,99,22,6,2,6,45)

# ohne dateipfad: Plot erscheint direkt im Plot-Fenster
boxplot_func(werte, 0.25, 0.75)

# mit dateipfad: wird zusaetzlich als PNG gespeichert
# boxplot_func(werte, 0.25, 0.75, "img/boxplot.png")
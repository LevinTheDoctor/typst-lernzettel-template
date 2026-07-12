#!/usr/bin/env Rscript
# Scatterplot.R — erzeugt assets/images/scatterplot.png
# Streudiagramm: Zusammenhang zweier metrischer Merkmale
# (hier: Lernzeit vs. erreichte Klausurpunkte). Farben passend zum Boxplot.
#
# Ausfuehren im Repo-Root:  Rscript r/Scatterplot.R   (oder: make r)
# Benoetigt nur base R.

# ── Farben (identisch zu config/colormeta.typ) ────────────────────────────────
primary <- "#2E4057"   # Dunkelblau  — Achsen, Beschriftung
accent  <- "#048A81"   # Petrol/Teal — Punktrand
fuell   <- "#DDF3F5"   # helles Tuerkis — Punktfuellung (= infocolor)
amber   <- "#E07B39"   # Amber — Ausgleichsgerade

dir.create("assets/images", recursive = TRUE, showWarnings = FALSE)

# ── Beispieldaten: Lernzeit (Std.) vs. Klausurpunkte ──────────────────────────
set.seed(42)
lernzeit <- c(1, 2, 2, 3, 4, 4, 5, 6, 6, 7, 8, 8, 9, 10, 11)
punkte   <- 8 + 4.2 * lernzeit + rnorm(length(lernzeit), 0, 6)
punkte   <- pmin(pmax(round(punkte), 0), 100)   # auf 0..100 begrenzen

png("assets/images/scatterplot.png", width = 1700, height = 1300, res = 250)
par(mar = c(4.4, 4.6, 1.4, 1.2), family = "Helvetica")

plot(lernzeit, punkte,
     xlim = c(0, 12), ylim = c(0, 100),
     xlab = "Lernzeit (Stunden)", ylab = "Klausurpunkte",
     las = 1, bty = "l",
     col.axis = primary, col.lab = primary, fg = primary,
     pch = 21, bg = fuell, col = accent, cex = 1.6, lwd = 2)

grid(col = "#DDE3EB", lty = 1, lwd = 0.6)

# Ausgleichsgerade (lineare Regression) zur Verdeutlichung des Trends
modell <- lm(punkte ~ lernzeit)
abline(modell, col = amber, lwd = 2.5)

# Punkte erneut ueber Gitter und Gerade zeichnen, damit sie oben liegen
points(lernzeit, punkte, pch = 21, bg = fuell, col = accent, cex = 1.6, lwd = 2)

dev.off()
cat("Streudiagramm gespeichert unter assets/images/scatterplot.png\n")

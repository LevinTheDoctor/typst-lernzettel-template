#!/usr/bin/env Rscript
# Saeulendiagramm.R — erzeugt assets/images/saeulendiagramm.png
# Saeulendiagramm: Haeufigkeit von Merkmalsauspraegungen (hier: Klausurnoten).
# Farben identisch zu config/colormeta.typ, passend zum Boxplot.
#
# Ausfuehren im Repo-Root:  Rscript r/Saeulendiagramm.R   (oder: make r)
# Benoetigt nur base R.

# ── Farben (identisch zu config/colormeta.typ) ────────────────────────────────
primary <- "#2E4057"   # Dunkelblau  — Achsen, Beschriftung
accent  <- "#048A81"   # Petrol/Teal — Rahmen, Akzent
fuell   <- "#DDF3F5"   # helles Tuerkis — Saeulenfuellung (= infocolor)

dir.create("assets/images", recursive = TRUE, showWarnings = FALSE)

# ── Beispieldaten: Haeufigkeit der Klausurnoten ───────────────────────────────
noten       <- c("1", "2", "3", "4", "5", "6")
haeufigkeit <- c(3, 7, 9, 5, 2, 1)

png("assets/images/saeulendiagramm.png", width = 2000, height = 1250, res = 250)
par(mar = c(4.2, 4.4, 1.4, 1.2), family = "Helvetica")

# Balkenmittelpunkte werden zurueckgegeben, um die Werte zu beschriften
mp <- barplot(haeufigkeit,
              names.arg = noten,
              col       = fuell,
              border    = accent,
              lwd       = 2,
              ylim      = c(0, max(haeufigkeit) + 2),
              xlab      = "Note",
              ylab      = "Häufigkeit",
              las       = 1,
              col.axis  = primary,
              col.lab   = primary,
              cex.names = 1.0)

# Haeufigkeit ueber jeder Saeule beschriften
text(mp, haeufigkeit + 0.5, labels = haeufigkeit, col = primary, cex = 0.9)

dev.off()
cat("Saeulendiagramm gespeichert unter assets/images/saeulendiagramm.png\n")

#!/usr/bin/env Rscript
# komplexitaet.R — Beispiel für die R-Anbindung des Templates.
# Erzeugt zwei Assets, die in content/example.typ eingebunden werden:
#   1. assets/images/komplexitaet.png    — Plot: Wachstum der O-Klassen
#   2. assets/data/sortier_benchmark.csv — echter Benchmark: Bubble Sort vs. sort()
#
# Ausführen im Repo-Root:  Rscript r/komplexitaet.R   (oder: make r)
# Benötigt nur base R — keine zusätzlichen Pakete.

# ── Farben (identisch zu config/colormeta.typ) ────────────────────────────────
primary  <- "#2E4057"
accent   <- "#048A81"
gruen    <- "#1E8A3F"
indigo   <- "#5C4EC2"
amber    <- "#E07B39"
rot      <- "#C0392B"

dir.create("assets/images", recursive = TRUE, showWarnings = FALSE)
dir.create("assets/data",   recursive = TRUE, showWarnings = FALSE)

# ── 1. Plot: Wachstum der O-Klassen ──────────────────────────────────────────
n <- seq(1, 20, by = 0.05)
klassen <- list(
  "O(1)"       = rep(1, length(n)),
  "O(log n)"   = log2(n),
  "O(n)"       = n,
  "O(n log n)" = n * log2(pmax(n, 1.0001)),
  "O(n²)" = n^2,
  "O(2ⁿ)" = 2^n
)
farben <- c(primary, accent, gruen, indigo, amber, rot)

png("assets/images/komplexitaet.png", width = 2000, height = 1250, res = 250)
par(mar = c(4.2, 4.4, 1.2, 1.2), family = "Helvetica")
plot(NULL, xlim = c(1, 20), ylim = c(0, 120),
     xlab = "Eingabegröße n", ylab = "Anzahl Operationen",
     las = 1, bty = "l", col.axis = primary, col.lab = primary, fg = primary)
grid(col = "#DDE3EB", lty = 1, lwd = 0.6)
for (i in seq_along(klassen)) {
  lines(n, klassen[[i]], col = farben[i], lwd = 2.5)
}
legend("topleft", legend = names(klassen), col = farben,
       lwd = 2.5, bty = "n", text.col = primary)
dev.off()

# ── 2. Benchmark: Bubble Sort (R) vs. eingebautes sort() ─────────────────────
bubble_sort <- function(x) {
  m <- length(x)
  for (i in seq_len(m - 1)) {
    for (j in seq_len(m - i)) {
      if (x[j] > x[j + 1]) {
        tmp <- x[j]; x[j] <- x[j + 1]; x[j + 1] <- tmp
      }
    }
  }
  x
}

set.seed(42)
groessen <- c(250, 500, 1000, 2000)
ergebnis <- data.frame(
  n = integer(0),
  bubble = numeric(0),
  builtin = numeric(0)
)

for (g in groessen) {
  daten <- runif(g)
  t_bubble <- system.time(bubble_sort(daten))[["elapsed"]] * 1000
  # sort() ist so schnell, dass wir über 200 Läufe mitteln müssen
  t_builtin <- system.time(for (k in 1:200) sort(daten))[["elapsed"]] / 200 * 1000
  ergebnis <- rbind(ergebnis, data.frame(n = g, bubble = t_bubble, builtin = t_builtin))
}

tabelle <- data.frame(
  "n"                 = as.character(ergebnis$n),
  "Bubble Sort (ms)"  = sprintf("%.1f", ergebnis$bubble),
  "sort() in R (ms)"  = sprintf("%.3f", ergebnis$builtin),
  check.names = FALSE
)
write.csv(tabelle, "assets/data/sortier_benchmark.csv", row.names = FALSE)

cat("Fertig: assets/images/komplexitaet.png und assets/data/sortier_benchmark.csv\n")

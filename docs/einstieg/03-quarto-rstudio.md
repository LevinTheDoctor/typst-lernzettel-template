# 3 · R, Quarto und RStudio

> Teil des [Einstiegs-Guides](README.md) —
> zurück zu [2 · Styling mit set und show](02-styling-set-show.md)

Es gibt zwei Wege, R und Typst zu verbinden. Dieses Template nutzt
standardmäßig Weg A; Weg B ist die Alternative, wenn du R-Code direkt im
Dokument schreiben willst.

## Weg A: R-Skripte + pures Typst (der Weg dieses Templates)

R erzeugt Dateien, Typst bindet sie ein. Sauber getrennt, und die
Kompilierung bleibt ein einziger schneller Befehl:

```
r/komplexitaet.R  ──Rscript──►  assets/images/komplexitaet.png
                                assets/data/sortier_benchmark.csv
                                        │
main.typ  ──typst compile──►  main.pdf ◄┘  (image() / csv())
```

**R-Seite** (`r/komplexitaet.R`, läuft mit `make r`):

```r
png("assets/images/komplexitaet.png", width = 2000, height = 1250, res = 250)
plot(n, n * log2(n), type = "l", col = "#048A81", lwd = 2.5)
dev.off()

write.csv(ergebnis, "assets/data/sortier_benchmark.csv", row.names = FALSE)
```

**Typst-Seite** (`content/example.typ`):

```typst
#figure(
  image("../assets/images/komplexitaet.png", width: 72%),
  caption: [Wachstum der O-Klassen],
)

#let daten = csv("../assets/data/sortier_benchmark.csv")
#stdtable(
  columns: (auto, 1fr, 1fr),
  header: daten.first(),
  ..daten.slice(1).flatten(),
)
```

`csv()` liest die Datei **zur Kompilierzeit** — ändert R die Daten, ändert
sich beim nächsten `typst compile` automatisch die Tabelle. Neben `csv()`
gibt es auch `json()`, `yaml()` und `toml()`.

**Workflow in RStudio mit diesem Weg:** Du kannst die Skripte in `r/` ganz
normal in RStudio entwickeln (Projekt im Repo-Root öffnen, damit die
relativen Pfade stimmen). Wenn der Plot sitzt: `make all` — fertig.

## Weg B: Quarto — R-Code direkt im Dokument

[Quarto](https://quarto.org) ist der Nachfolger von R Markdown und kann
seit Version 1.4 **Typst als PDF-Engine** verwenden. Du schreibst eine
`.qmd`-Datei mit R-Code-Chunks; Quarto führt den Code aus und rendert das
Ergebnis über Typst zum PDF — deutlich schneller als der klassische Weg
über LaTeX.

### Setup

RStudio bringt Quarto **bereits mit** — nichts zu installieren. Für die
Kommandozeile (optional):

```bash
brew install quarto
# oder das von RStudio gebündelte Binary in den PATH legen:
export PATH="$PATH:/Applications/RStudio.app/Contents/Resources/app/quarto/bin"
```

### Eine .qmd-Datei mit Typst-Ausgabe

````markdown
---
title: "Sortieralgorithmen"
author: "Levin Rüßmann"
lang: de
format:
  typst:
    papersize: a4
    margin:
      x: 2.5cm
      y: 2.5cm
    mainfont: "Helvetica Neue"
    fontsize: 11pt
---

## Benchmark

```{r}
#| echo: false
#| fig-cap: "Laufzeitvergleich"
n <- c(250, 500, 1000, 2000)
zeit <- c(11, 19, 78, 311)
plot(n, zeit, type = "b", col = "#048A81", lwd = 2)
```

Der Plot oben wurde beim Rendern von R erzeugt.
````

### Rendern

- **In RStudio:** Datei öffnen → Knopf **Render** (oder `Cmd+Shift+K`).
  RStudio zeigt das PDF direkt an.
- **Terminal:** `quarto render dokument.qmd`

### Chunk-Optionen (die wichtigsten)

| Option | Wirkung |
|---|---|
| `#| echo: false` | Code ausblenden, nur Ergebnis zeigen |
| `#| eval: false` | Code zeigen, aber nicht ausführen |
| `#| fig-cap: "…"` | Bildunterschrift |
| `#| warning: false` | R-Warnungen unterdrücken |

### Eigenes Typst-Styling in Quarto

Quarto erlaubt rohe Typst-Blöcke und eigene Template-Dateien:

````markdown
```{=typst}
#set text(fill: rgb("#2E4057"))
```
````

Wer das komplette Look-and-feel dieses Templates in Quarto will, kann
`format: typst` mit `template-partials` erweitern — siehe
[Quarto-Doku: Typst Custom Formats](https://quarto.org/docs/output-formats/typst-custom.html).
Das ist allerdings spürbar mehr Aufwand als Weg A.

## Welchen Weg nehmen?

| | Weg A: R-Skripte (dieses Template) | Weg B: Quarto |
|---|---|---|
| R-Code lebt … | in `r/*.R` | im Dokument (Chunks) |
| Styling | volle Kontrolle (dieses Template) | Quarto-Defaults, Anpassung aufwendiger |
| Kompilieren | `typst compile` (< 1 s) | `quarto render` (R läuft mit) |
| Reproduzierbarkeit | Skripte explizit ausführen | automatisch bei jedem Render |
| Gut für | Lernzettel mit gelegentlichen Plots | Analyse-Berichte, bei denen Text und Code verwoben sind |

**Faustregel:** Für Lernzettel Weg A. Wenn die Auswertung selbst der Inhalt
ist (Statistik-Hausarbeit, Datenanalyse-Bericht), Weg B.

## Weiter

→ [4 · Grundbefehle & Referenz](04-grundbefehle.md)

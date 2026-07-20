# Makefile — Typst-Lernzettel-Template
# Voraussetzung: typst (brew install typst); optional: R für `make r`
# ─────────────────────────────────────────────────────────────────────────────

MAIN  := main
TYPST := typst

.PHONY: all build watch r clean help

## Standardziel: R-Assets erzeugen + kompilieren
all: r build

## Einmaliger Build (main.pdf)
build:
	$(TYPST) compile $(MAIN).typ

## Kontinuierlicher Rebuild bei Dateiänderungen (Ctrl+C zum Stoppen)
watch:
	$(TYPST) watch $(MAIN).typ

## Alle R-Skripte ausführen (erzeugen Plots/Daten in assets/)
r:
	@for skript in r/*.R; do \
		echo "→ Rscript $$skript"; \
		Rscript "$$skript"; \
	done

## Kompiliertes PDF löschen
clean:
	rm -f $(MAIN).pdf

## Hilfe
help:
	@echo ""
	@echo "  make build   Einmaliger Kompilierlauf (main.pdf)"
	@echo "  make watch   Automatischer Rebuild bei Dateiänderungen"
	@echo "  make r       R-Skripte ausführen (Plots/Daten nach assets/)"
	@echo "  make all     make r + make build"
	@echo "  make clean   main.pdf löschen"
	@echo ""

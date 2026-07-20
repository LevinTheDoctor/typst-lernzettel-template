# Makefile — Typst-Lernzettel-Template
# Voraussetzung: typst (brew install typst); optional: R für `make r`
# ─────────────────────────────────────────────────────────────────────────────

MAIN  := main
TYPST := typst

.PHONY: all build watch r formelsammlung clean help

## Standardziel: R-Assets erzeugen + kompilieren
all: r build

## Einmaliger Build (main.pdf)
build:
	$(TYPST) compile $(MAIN).typ

## Eigenständige Formelsammlung als separates PDF (formelsammlung.pdf)
formelsammlung:
	$(TYPST) compile formelsammlung.typ

## Kontinuierlicher Rebuild bei Dateiänderungen (Ctrl+C zum Stoppen)
watch:
	$(TYPST) watch $(MAIN).typ

## Alle R-Skripte ausführen (erzeugen Plots/Daten in assets/)
r:
	@for skript in r/*.R; do \
		echo "→ Rscript $$skript"; \
		Rscript "$$skript"; \
	done

## Kompilierte PDFs löschen
clean:
	rm -f $(MAIN).pdf formelsammlung.pdf

## Hilfe
help:
	@echo ""
	@echo "  make build           Einmaliger Kompilierlauf (main.pdf)"
	@echo "  make watch           Automatischer Rebuild bei Dateiänderungen"
	@echo "  make formelsammlung  Eigenständige Formelsammlung (formelsammlung.pdf)"
	@echo "  make r               R-Skripte ausführen (Plots/Daten nach assets/)"
	@echo "  make all             make r + make build"
	@echo "  make clean           PDFs löschen"
	@echo ""

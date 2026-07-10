---
name: lektorat
description: Generelles Lektorat für deutsche Texte jeder Fachrichtung (Typst, Markdown, Klartext) — Rechtschreibung, Grammatik, Stil und fachliche Plausibilität. Verwenden, wenn der Nutzer einen Text korrigieren, verbessern oder "lektorieren" lassen möchte und kein spezifischerer Lektorat-Skill passt.
---

# Lektorat (allgemein)

Du agierst als **professioneller Lektor** für deutsche Sach- und Lerntexte —
unabhängig vom Fachgebiet (Informatik, Mathematik, BWL, Medizin, …) und vom
Dateiformat (`.typ`, `.md`, `.txt`, …).
Ziel: Der Text wird sprachlich sauber und konsistent formatiert, **ohne** dass
die Stimme und der Inhalt des Autors verfälscht werden.

## Grundregeln (in dieser Reihenfolge)

1. **Rechtschreibung & Grammatik**: immer korrigieren. Deutsche Rechtschreibung,
   korrekte Kommasetzung, Groß-/Kleinschreibung, einheitliche Schreibweisen
   (z. B. „E-Mail" vs. „Email" — eine Variante konsequent).
2. **Formulierungen**: zurückhaltend glätten. Umschreiben nur, wenn ein Satz
   missverständlich, grammatisch falsch oder erkennbar abgebrochen ist.
   Den Ton des Autors bewahren — ein Lernzettel darf locker klingen.
3. **Fachliche Plausibilität**: offensichtliche Fehler (falsche Jahreszahlen,
   vertauschte Begriffe, falsch aufgelöste Abkürzungen) korrigieren und dem
   Nutzer **explizit auflisten** (was war falsch, was ist jetzt richtig).
   Bei Unsicherheit: nicht raten, sondern als Rückfrage an den Nutzer markieren.
4. **Formatierung**: konsistent mit dem restlichen Dokument. Vorhandene
   Auszeichnungskonventionen des Projekts übernehmen, keine neuen erfinden.

## Vorgehen

1. Den zu lektorierenden Text vollständig lesen.
2. **Konventionen abgleichen**: einen bereits fertigen Abschnitt desselben
   Projekts lesen, um Tonfall, Fachvokabular und Formatierungsmuster zu treffen.
   Gibt es projektspezifische Komponenten/Makros (z. B. in einer `lib/` oder
   Präambel), diese verwenden statt rohem Markup.
3. Datei mit der korrigierten Fassung schreiben.
4. Falls das Projekt kompilierbar ist (Typst, LaTeX, …): Kompilierung prüfen.
5. Dem Nutzer eine knappe Zusammenfassung geben, getrennt nach:
   **fachliche Korrekturen**, **Rechtschreibung/Grammatik**, **Formatierung**,
   **offene Rückfragen**.

## Typografische Konventionen (Deutsch)

- Anführungszeichen: „…" (deutsche Guillemets »…« nur, wenn das Dokument sie
  bereits verwendet).
- Gedankenstrich: Halbgeviertstrich mit Leerzeichen („Text — Text").
- Abkürzungen mit schmalem Abstand denken: „z. B.", „d. h.", „u. a." —
  im Quelltext als „z. B." schreiben.
- Zahlen und Einheiten: „10 MB", „3 %", „§ 5" — mit Leerzeichen.
- Bindestrich-Komposita konsistent durchkoppeln („Open-Source-Projekt",
  nicht „Open Source Projekt").

## Nicht tun

- Inhalte nicht ergänzen, die der Autor nicht geschrieben hat (außer ein Satz
  ist erkennbar abgebrochen und muss vervollständigt werden).
- Fachliche Aussagen nicht „verbessern", wenn sie nur ungewohnt, aber korrekt sind.
- Konfigurations- und Strukturdateien des Projekts nicht ungefragt umbauen.
- Den Stil nicht „glattbügeln", bis die Autorenstimme verschwindet.

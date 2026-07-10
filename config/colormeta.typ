// colormeta.typ — Alle Design-Tokens: Farben, Schriften, Abstände
// ═══════════════════════════════════════════════════════════════════════════
// NUR DIESE DATEI bearbeiten, um das gesamte Dokument umzugestalten.
// Keine Farben oder Schriften sind anderswo hart kodiert.
// ═══════════════════════════════════════════════════════════════════════════

// ── Schriften ────────────────────────────────────────────────────────────────
// Typst probiert die Liste von links nach rechts durch (Fallback-Kette).
// Verfügbare Schriften anzeigen: `typst fonts`
#let mainfont = ("Helvetica Neue", "Helvetica", "Arial")
#let monofont = ("JetBrains Mono", "Menlo", "DejaVu Sans Mono", "Courier New")

// Optionale Premium-Schriften (Homebrew/manuell installieren):
// #let mainfont = ("Source Serif 4", "Helvetica Neue")
// #let monofont = ("JetBrains Mono", "Menlo")

// ── Abstände ─────────────────────────────────────────────────────────────────
#let contentmargin = 2.5cm   // Seitenrand ringsum
#let parskipval    = 6pt     // Abstand zwischen Absätzen
#let boxinnersep   = 10pt    // Innenabstand von Info-/Warnboxen

// ── Farben ───────────────────────────────────────────────────────────────────

// Brand / Thema
#let primary = rgb("#2E4057")         // Dunkelblau  — Überschriften, Tabellenköpfe
#let accent  = rgb("#048A81")         // Petrol/Teal — Links, Akzente

// Infobox (blau-türkis)
#let infocolor = rgb("#DDF3F5")       // Hintergrund
#let infoframe = rgb("#048A81")       // Rahmen (= accent)

// Warnbox (amber)
#let warncolor = rgb("#FFF4E0")       // Hintergrund
#let warnframe = rgb("#E07B39")       // Rahmen

// Pro / Contra
#let procolor = rgb("#D6EDDA")        // Grün-Hintergrund
#let proframe = rgb("#1E8A3F")        // Grün-Rahmen
#let concolor = rgb("#FADDE1")        // Rot-Hintergrund
#let conframe = rgb("#C0392B")        // Rot-Rahmen

// Codeblock
#let codeblock = rgb("#F5F5F5")       // Hintergrund
#let codeframe = rgb("#CCCCCC")       // Rahmen

// Tabellen
#let tableheader     = rgb("#2E4057") // Kopfzeilenhintergrund (= primary)
#let tableheadertext = rgb("#FFFFFF") // Kopfzeilentext
#let tablerowalt     = rgb("#EEF2F7") // Alternierend eingefärbte Zeilen

// Prozess-Schritte
#let stepcolor = rgb("#048A81")       // Schrittnummer-Badge (= accent)

// Merksatz (Indigo/Lila)
#let merksatzcolor = rgb("#F0EEFF")   // Hintergrund
#let merksatzframe = rgb("#5C4EC2")   // Rahmen

// Beispiel (Smaragdgrün)
#let beispielcolor = rgb("#E8F5E9")   // Hintergrund
#let beispielframe = rgb("#2E9E68")   // Rahmen

// Aufgabe (Goldgelb)
#let aufgabecolor = rgb("#FFF8E1")    // Hintergrund
#let aufgabeframe = rgb("#E6A817")    // Rahmen

// Konzeptkarte
#let konzeptcolor = rgb("#F7F9FC")    // Hintergrund (blau-grau)

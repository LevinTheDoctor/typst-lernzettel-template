// main.typ — Einstiegspunkt
// Kompilieren:  typst compile main.typ   (oder: make build)
// Live-Vorschau: typst watch main.typ    (oder: make watch)
// ─────────────────────────────────────────────────────────────────────────────

// ── Konfiguration ────────────────────────────────────────────────────────────
#import "config/usermeta.typ": *    // Autor, Kurs, Matrikelnummer, Semester
#import "config/topicmeta.typ": *   // Titel, Untertitel, Fach, Beschreibung
#import "lib/template.typ": lernzettel

// ── Template anwenden ────────────────────────────────────────────────────────
#show: lernzettel.with(
  title: doctitle,
  subtitle: docsubtitle,
  subject: docsubject,
  description: docdescription,
  author: docauthor,
  studentid: docstudentid,
  course: doccourse,
  semester: docsemester,
  date: docdate,
)

// ── Inhalt ───────────────────────────────────────────────────────────────────
// Neues Kapitel hinzufügen: Datei in content/ anlegen und hier einbinden.
#include "content/Grundbegriffe.typ"
#include "content/DeskriptiveStatstik.typ"
#include "content/ZufallsVaraiblen.typ"
#include "content/Normalverteilung.typ"
#include "content/Inferenzstatistik.typ"
#include "content/r.typ"
#include "content/Taschenrechner.typ"
#include "content/Formelsammlung.typ"

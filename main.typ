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
// Reiner Formelsammlungs-Branch: main rendert ausschließlich die Formelsammlung.
#include "content/Formelsammlung.typ"

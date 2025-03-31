# Projekt: Lebensarchiv (iOS-App)

## Vision
"Lebensarchiv" ist eine minimalistische iOS-App, die es Nutzer:innen ermöglicht, ihre wichtigsten Lebensdokumente (z. B. Verträge, Ausweise, medizinische Unterlagen) digital, strukturiert und sicher zu speichern. Ziel ist eine intuitive, elegante Lösung für den digitalen Papierkram – für private Nutzung im Alltag oder im erweiterten Freundeskreis.

Die App soll:
- ein tab-basiertes Interface haben
- klar strukturiert sein (MVVM, SwiftUI)
- lokal starten, aber später Supabase integrieren
- modular erweiterbar sein (Sharing, Erinnerungen, OCR, DSGVO etc.)

## Tech Stack
- **Sprache:** Swift
- **Framework:** SwiftUI
- **Architektur:** MVVM
- **UI:** iOS-native (kein UIKit)
- **Cloud (später):** Supabase (Projekt-ID: pxvejhwktubefrybbbfv)
- **Build-Tool:** Xcode + Cursor

## Strukturvorgabe
Die App besteht aus:
- `MainTabView`: TabView mit drei Bereichen (Overview, Search, Profile)
- `CategoryModel`: Datentyp für Dokumentenkategorien
- `DocumentModel`: Datentyp für einzelne Dokumente
- Wiederverwendbaren Komponenten (`CategoryCard`, `DocumentCell`, etc.)
- Übersicht-Grid mit Kategorien
- Dokumentenlisten für jede Kategorie
- (Später) Upload-Funktion, Scan-Feature, Login/Account

## Wichtige Anforderungen
- Verwende NUR moderne SwiftUI (kein UIKit, kein Combine)
- Nutze Swift 5.9 oder aktueller
- Schreibe **modularen, preview-fähigen Code**
- Erstelle zu jeder neuen Funktion **eine eigene View, ein ViewModel (wenn nötig), und ggf. ein Model**
- Erkläre die Verbindungen kurz in Kommentaren
- Halte Code klar, wartbar und logisch benannt

## Projektverzeichnis
Das Projekt ist nach Clean Code Prinzipien strukturiert:

```
📁 AppArchiveLive
├── 📁 Models
├── 📁 Views
├── 📁 ViewModels
├── 📁 Components
├── 📁 Utilities
├── 📄 MainTabView.swift
├── 📄 .cursorrules
├── 📄 project_overview.md (diese Datei)
```


## Bitte befolge immer:
- **Aktualisiere diese Datei bei jedem Meilenstein**, z. B. neue Views, Models, Architekturentscheidungen
- **Füge kurze Zusammenfassungen hinzu**, welche Features wann erstellt wurden
- **Stelle sicher**, dass Cursor bei jedem Prompt Zugriff auf diese Datei hat (`@Docs(project_overview.md)` oder als Kontext anhängen)

---

## Projektstatus (zuletzt aktualisiert: 31.03.2025)
- ✅ `.cursorrules` eingerichtet
- ⬜ `MainTabView.swift` mit drei Tabs (Overview, Search, Profile)
- ⬜ Kategorie-Modell
- ⬜ Dokumentenmodell
- ⬜ Dummy-Daten
- ⬜ Dokumentenliste
- ⬜ Supabase Login

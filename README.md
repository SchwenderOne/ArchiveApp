# Lebensarchiv

Eine iOS-App zur sicheren und strukturierten Verwaltung wichtiger persönlicher Dokumente im Alltag.

![Swift](https://img.shields.io/badge/Swift-5.9-orange)
![SwiftUI](https://img.shields.io/badge/Framework-SwiftUI-blue)
![Platform](https://img.shields.io/badge/Platform-iOS-lightgrey)
![Version](https://img.shields.io/badge/Version-0.1.0-green)

## 📑 Projektbeschreibung

Lebensarchiv ist eine iOS-App, die Nutzer:innen ermöglicht, alle wichtigen Dokumente ihres Erwachsenenlebens digital, sicher und strukturiert zu verwalten. Die App hilft dabei, Ordnung im digitalen Alltag zu schaffen – etwa für Steuerunterlagen, Versicherungsdokumente, Arbeitsverträge oder Gesundheitsnachweise.

Als digitaler Begleiter bietet Lebensarchiv jederzeit Zugriff auf relevante Informationen und erfüllt dabei einen hohen Anspruch an Nutzerfreundlichkeit, Datenschutz und Klarheit.

## 🏗️ Architektur

- **Framework:** SwiftUI
- **Architekturmuster:** MVVM (Model-View-ViewModel)
- **Backend:** Geplante Integration mit Supabase (Storage, Auth, DB)

## 🧩 Hauptfunktionen

### Aktuelle Version (v0.1.0):

- **Kategorisierung von Dokumenten:**
  - Vordefinierte Kategorien wie Gesundheit, Finanzen, Versicherungen, etc.
  - Übersichtliche Darstellung durch Kategorie-Grid

- **Dokumentenverwaltung:**
  - Dokumenten-Detailansicht
  - Möglichkeit zum Hinzufügen neuer Dokumente
  - Tag-System zur besseren Organisation

- **Erweiterte Suchfunktion:**
  - Filterung nach Kategorie, Datum und Tags
  - Volltext-Suche in Dokumenten

- **Benutzeroberfläche:**
  - Intuitive Tab-Navigation (Übersicht, Suche, Profil)
  - Moderne iOS-typische UI-Elemente
  - Anpassbare Farbschemata

### Geplante Funktionen:

- Kamera-Scan für Dokumente
- Dokumentenverschlüsselung
- Supabase-Integration für Cloud-Speicher
- Dokumentenfreigabe für Angehörige
- Erinnerungsfunktionen für wichtige Fristen

## 📋 Versionierungssystem

Wir verwenden Semantic Versioning (MAJOR.MINOR.PATCH):

- **MAJOR**: Größere Änderungen, die mit früheren Versionen nicht kompatibel sind
- **MINOR**: Neue Funktionen, die abwärtskompatibel sind
- **PATCH**: Bug-Fixes und kleine Änderungen, die abwärtskompatibel sind

### Versionshistorie:

- **v0.1.0** (31.03.2025): Initiale Version mit grundlegender Struktur und Funktionalität
  - MVVM-Architektur implementiert
  - Grundlegende UI mit TabView
  - Kategorie- und Dokumentenmodell
  - Suchfunktion mit Filtern

## 🚀 Installationsanleitung

1. Klone das Repository
2. Öffne `ArchiveApp.xcodeproj` in Xcode
3. Baue und starte die App auf einem iOS-Simulator oder einem verbundenen Gerät

## 📱 Zielplattform

- iOS 16.0+
- Zukünftig möglicherweise auch iPadOS

## 👥 Entwickelt von

- Lucas Schwender Jain 
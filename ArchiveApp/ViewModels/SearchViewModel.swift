import Foundation
import SwiftUI
import Combine

class SearchViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var searchResults: [Document] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    // Filter-Optionen
    @Published var selectedCategories: Set<UUID> = []
    @Published var dateRange: DateRange = .allTime
    @Published var sortOrder: SortOrder = .newestFirst
    @Published var tagFilter: String?
    
    private var allDocuments: [Document] = []
    private var allCategories: [Category] = []
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        // Initialisieren mit Beispieldaten
        self.allCategories = Category.sampleCategories
        
        // Erstelle Beispieldokumente für jede Kategorie
        for category in allCategories {
            let docs = (0..<Int.random(in: 1...3)).map { i in
                Document(
                    title: "Dokument \(i+1) (\(category.name))",
                    categoryId: category.id,
                    dateAdded: Date().addingTimeInterval(-Double.random(in: 0...365*24*3600)),
                    tags: ["beispiel", category.name.lowercased()]
                )
            }
            allDocuments.append(contentsOf: docs)
        }
        
        // Füge Beispieldokumente aus Document.sampleDocuments hinzu
        allDocuments.append(contentsOf: Document.sampleDocuments)
        
        // Einfachere Implementierung: Jede Änderung löst die Suche aus
        setupSearchObservers()
    }
    
    private func setupSearchObservers() {
        // Beobachte jede Filteroption einzeln
        $searchText.debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .sink { [weak self] _ in self?.performSearch() }
            .store(in: &cancellables)
        
        $selectedCategories.sink { [weak self] _ in self?.performSearch() }
            .store(in: &cancellables)
        
        $dateRange.sink { [weak self] _ in self?.performSearch() }
            .store(in: &cancellables)
        
        $sortOrder.sink { [weak self] _ in self?.performSearch() }
            .store(in: &cancellables)
        
        $tagFilter.sink { [weak self] _ in self?.performSearch() }
            .store(in: &cancellables)
    }
    
    func performSearch() {
        isLoading = true
        
        // Simuliere eine Netzwerkverzögerung
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            guard let self = self else { return }
            
            // Filtere die Dokumente
            var results = self.allDocuments
            
            // Text-Filter
            if !self.searchText.isEmpty {
                let searchTerms = self.searchText.lowercased().split(separator: " ").map(String.init)
                results = results.filter { document in
                    searchTerms.allSatisfy { term in
                        document.title.lowercased().contains(term) ||
                        document.tags.contains { $0.lowercased().contains(term) } ||
                        document.notes?.lowercased().contains(term) == true
                    }
                }
            }
            
            // Kategorie-Filter
            if !self.selectedCategories.isEmpty {
                results = results.filter { self.selectedCategories.contains($0.categoryId) }
            }
            
            // Datum-Filter
            let calendar = Calendar.current
            let now = Date()
            switch self.dateRange {
            case .last7Days:
                let lastWeek = calendar.date(byAdding: .day, value: -7, to: now)!
                results = results.filter { $0.dateAdded >= lastWeek }
            case .last30Days:
                let lastMonth = calendar.date(byAdding: .day, value: -30, to: now)!
                results = results.filter { $0.dateAdded >= lastMonth }
            case .last90Days:
                let lastQuarter = calendar.date(byAdding: .day, value: -90, to: now)!
                results = results.filter { $0.dateAdded >= lastQuarter }
            case .lastYear:
                let lastYear = calendar.date(byAdding: .year, value: -1, to: now)!
                results = results.filter { $0.dateAdded >= lastYear }
            case .allTime:
                // Keine Filterung nötig
                break
            case .custom(let start, let end):
                results = results.filter { $0.dateAdded >= start && $0.dateAdded <= end }
            }
            
            // Tag-Filter
            if let tagFilter = self.tagFilter, !tagFilter.isEmpty {
                results = results.filter { document in
                    document.tags.contains { $0.lowercased().contains(tagFilter.lowercased()) }
                }
            }
            
            // Sortierung
            switch self.sortOrder {
            case .newestFirst:
                results.sort { $0.dateAdded > $1.dateAdded }
            case .oldestFirst:
                results.sort { $0.dateAdded < $1.dateAdded }
            case .alphabetical:
                results.sort { $0.title < $1.title }
            }
            
            self.searchResults = results
            self.isLoading = false
        }
    }
    
    func getCategoryName(for id: UUID) -> String {
        allCategories.first { $0.id == id }?.name ?? "Unbekannte Kategorie"
    }
    
    func getCategoryColor(for id: UUID) -> Color {
        allCategories.first { $0.id == id }?.color ?? .gray
    }
    
    func resetFilters() {
        selectedCategories = []
        dateRange = .allTime
        sortOrder = .newestFirst
        tagFilter = nil
    }
}

// Unterstützende Enums für die Filter-Optionen
enum DateRange: Equatable {
    case last7Days
    case last30Days
    case last90Days
    case lastYear
    case allTime
    case custom(start: Date, end: Date)
    
    var displayName: String {
        switch self {
        case .last7Days: return "Letzte 7 Tage"
        case .last30Days: return "Letzte 30 Tage"
        case .last90Days: return "Letzte 90 Tage"
        case .lastYear: return "Letztes Jahr"
        case .allTime: return "Alle"
        case .custom(_, _): return "Benutzerdefiniert"
        }
    }
}

enum SortOrder: String, CaseIterable, Identifiable {
    case newestFirst = "Neuste zuerst"
    case oldestFirst = "Älteste zuerst"
    case alphabetical = "Alphabetisch"
    
    var id: String { self.rawValue }
} 
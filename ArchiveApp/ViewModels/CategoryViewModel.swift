import Foundation
import SwiftUI
import Combine

class CategoryViewModel: ObservableObject {
    @Published var categories: [Category] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    init() {
        loadCategories()
    }
    
    func loadCategories() {
        // Simuliere Netzwerkverzögerung (später wird dies durch echte API-Aufrufe ersetzt)
        isLoading = true
        
        // In einer echten App würden wir hier die Daten von Supabase laden
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.categories = Category.sampleCategories
            self.isLoading = false
        }
    }
    
    func getCategoryById(_ id: UUID) -> Category? {
        return categories.first { $0.id == id }
    }
} 
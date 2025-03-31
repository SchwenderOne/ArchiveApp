import Foundation
import SwiftUI
import Combine

class DocumentViewModel: ObservableObject {
    @Published var documents: [Document] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var selectedCategoryId: UUID?
    
    init() {
        // Dokumente werden erst geladen, wenn eine Kategorie ausgewählt wird
    }
    
    func loadDocuments(for categoryId: UUID) {
        selectedCategoryId = categoryId
        isLoading = true
        
        // In einer echten App würden wir hier die Daten von Supabase laden
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.documents = Document.getDocuments(for: categoryId)
            self.isLoading = false
        }
    }
    
    func getDocumentById(_ id: UUID) -> Document? {
        return documents.first { $0.id == id }
    }
    
    // In einem späteren Schritt werden wir hier Methoden zum Hinzufügen, Bearbeiten und Löschen von Dokumenten implementieren
} 
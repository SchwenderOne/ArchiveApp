import Foundation
import SwiftUI

struct Document: Identifiable {
    let id: UUID
    let title: String
    let categoryId: UUID
    let fileURL: URL?
    let dateAdded: Date
    let dateModified: Date
    let tags: [String]
    let notes: String?
    let thumbnail: UIImage?
    
    init(
        id: UUID = UUID(),
        title: String,
        categoryId: UUID,
        fileURL: URL? = nil,
        dateAdded: Date = Date(),
        dateModified: Date = Date(),
        tags: [String] = [],
        notes: String? = nil,
        thumbnail: UIImage? = nil
    ) {
        self.id = id
        self.title = title
        self.categoryId = categoryId
        self.fileURL = fileURL
        self.dateAdded = dateAdded
        self.dateModified = dateModified
        self.tags = tags
        self.notes = notes
        self.thumbnail = thumbnail
    }
}

// Beispieldokumente
extension Document {
    static let sampleDocuments: [Document] = {
        // Wir nutzen die erste Kategorie für die Beispiele
        let categoryId = Category.sampleCategories[0].id
        
        return [
            Document(
                title: "Hausarztbericht 2024",
                categoryId: categoryId,
                dateAdded: Date().addingTimeInterval(-7 * 24 * 3600),
                tags: ["Hausarzt", "Checkup"],
                notes: "Jährlicher Gesundheitscheck"
            ),
            Document(
                title: "Impfnachweis COVID-19",
                categoryId: categoryId,
                dateAdded: Date().addingTimeInterval(-30 * 24 * 3600),
                tags: ["Impfung", "COVID"]
            ),
            Document(
                title: "Zahnärztlicher Befund",
                categoryId: categoryId,
                dateAdded: Date().addingTimeInterval(-14 * 24 * 3600),
                tags: ["Zahnarzt", "Befund"]
            )
        ]
    }()
    
    static func getDocuments(for categoryId: UUID) -> [Document] {
        // In einem realen Projekt würden wir hier aus einer Datenbank oder einem Service laden
        return sampleDocuments.filter { $0.categoryId == categoryId }
    }
} 
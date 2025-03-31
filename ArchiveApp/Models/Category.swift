import Foundation
import SwiftUI

struct Category: Identifiable {
    let id: UUID
    let name: String
    let icon: String // SF Symbol name
    let description: String?
    let color: Color
    
    init(id: UUID = UUID(), name: String, icon: String, description: String? = nil, color: Color) {
        self.id = id
        self.name = name
        self.icon = icon
        self.description = description
        self.color = color
    }
}

// Beispielkategorien
extension Category {
    static let sampleCategories: [Category] = [
        Category(name: "Gesundheit", icon: "heart.fill", description: "Arztberichte, Befunde und Rezepte", color: .red),
        Category(name: "Finanzen", icon: "banknote.fill", description: "Kontoauszüge, Steuerunterlagen", color: .green),
        Category(name: "Versicherungen", icon: "umbrella.fill", description: "Versicherungspolicen und Unterlagen", color: .blue),
        Category(name: "Beruf & Verträge", icon: "briefcase.fill", description: "Arbeitsverträge und berufliche Dokumente", color: .orange),
        Category(name: "Bildung & Zeugnisse", icon: "graduationcap.fill", description: "Zeugnisse und Bildungsnachweise", color: .purple),
        Category(name: "Wohnen & Mietverträge", icon: "house.fill", description: "Mietverträge und Wohnungsdokumente", color: .brown),
        Category(name: "Identität & Ausweise", icon: "person.fill", description: "Personalausweis, Reisepass und offizielle Dokumente", color: .gray),
        Category(name: "Sonstiges", icon: "folder.fill", description: "Sonstige wichtige Dokumente", color: .black)
    ]
} 
import SwiftUI

struct DocumentRow: View {
    let document: Document
    
    var body: some View {
        HStack(spacing: 16) {
            // Thumbnail oder Platzhaltericon
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.gray.opacity(0.1))
                
                if let thumbnail = document.thumbnail {
                    Image(uiImage: thumbnail)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 60, height: 60)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                } else {
                    Image(systemName: "doc.text")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.secondary)
                        .frame(width: 32, height: 32)
                }
            }
            .frame(width: 60, height: 60)
            
            // Dokumentinformationen
            VStack(alignment: .leading, spacing: 4) {
                Text(document.title)
                    .font(.headline)
                    .lineLimit(1)
                
                // Datum
                Text(dateFormatter.string(from: document.dateAdded))
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                // Tags
                if !document.tags.isEmpty {
                    HStack {
                        ForEach(document.tags.prefix(3), id: \.self) { tag in
                            Text(tag)
                                .font(.caption2)
                                .padding(.horizontal, 6)
                                .padding(.vertical, 2)
                                .background(Color.blue.opacity(0.2))
                                .cornerRadius(4)
                        }
                        
                        if document.tags.count > 3 {
                            Text("+\(document.tags.count - 3)")
                                .font(.caption2)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
            
            Spacer()
            
            // Chevron oder Menüpunkte (später für Kontextmenü)
            Image(systemName: "chevron.right")
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 8)
    }
    
    // Formatiere das Datum für die Anzeige
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }
}

#Preview {
    if let document = Document.sampleDocuments.first {
        DocumentRow(document: document)
            .padding()
            .previewDisplayName("Dokument Zeile")
    } else {
        Text("Keine Beispieldokumente verfügbar")
    }
} 
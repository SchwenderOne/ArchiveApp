import SwiftUI

struct DocumentDetailView: View {
    let document: Document
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Dokumenten-Header
                HStack(alignment: .top) {
                    // Thumbnail oder Icon
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.gray.opacity(0.1))
                            .frame(width: 80, height: 80)
                        
                        if let thumbnail = document.thumbnail {
                            Image(uiImage: thumbnail)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 80, height: 80)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        } else {
                            Image(systemName: "doc.text")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.secondary)
                                .frame(width: 45, height: 45)
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 6) {
                        Text(document.title)
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Text("Hinzugefügt am \(formattedDate(document.dateAdded))")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        
                        if document.dateAdded != document.dateModified {
                            Text("Zuletzt bearbeitet: \(formattedDate(document.dateModified))")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding(.leading, 8)
                }
                .padding(.bottom, 4)
                
                Divider()
                
                // Tags
                if !document.tags.isEmpty {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Tags")
                            .font(.headline)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(document.tags, id: \.self) { tag in
                                    Text(tag)
                                        .font(.caption)
                                        .padding(.horizontal, 10)
                                        .padding(.vertical, 5)
                                        .background(Color.blue.opacity(0.2))
                                        .cornerRadius(8)
                                }
                            }
                        }
                    }
                    .padding(.bottom)
                }
                
                // Notizen
                if let notes = document.notes {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Notizen")
                            .font(.headline)
                        
                        Text(notes)
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(8)
                    }
                    .padding(.bottom)
                }
                
                // Dokumentenvorschau (Platzhalter für zukünftige PDF-Vorschau)
                VStack(alignment: .leading, spacing: 8) {
                    Text("Vorschau")
                        .font(.headline)
                    
                    if document.fileURL != nil {
                        // Hier würde später die tatsächliche PDF-Vorschau angezeigt werden
                        ZStack {
                            Rectangle()
                                .fill(Color.gray.opacity(0.1))
                                .frame(height: 300)
                                .cornerRadius(8)
                            
                            VStack(spacing: 12) {
                                Image(systemName: "doc.text")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                                    .foregroundColor(.secondary)
                                
                                Text("Dokument anzeigen")
                                    .font(.headline)
                                    .foregroundColor(.blue)
                            }
                        }
                        .onTapGesture {
                            // Hier würde später die Dokumentöffnung implementiert werden
                        }
                    } else {
                        ZStack {
                            Rectangle()
                                .fill(Color.gray.opacity(0.1))
                                .frame(height: 150)
                                .cornerRadius(8)
                            
                            Text("Keine Dokumentvorschau verfügbar")
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Dokument")
        .navigationBarItems(trailing: Menu {
            Button(action: {
                // Teilen-Funktion (später zu implementieren)
            }) {
                Label("Teilen", systemImage: "square.and.arrow.up")
            }
            
            Button(action: {
                // Bearbeiten-Funktion (später zu implementieren)
            }) {
                Label("Bearbeiten", systemImage: "pencil")
            }
            
            Button(action: {
                // Löschen-Funktion (später zu implementieren)
            }) {
                Label("Löschen", systemImage: "trash")
                    .foregroundColor(.red)
            }
        } label: {
            Image(systemName: "ellipsis.circle")
        })
    }
    
    // Formatiere das Datum für die Anzeige
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }
}

#Preview {
    if let document = Document.sampleDocuments.first {
        NavigationView {
            DocumentDetailView(document: document)
        }
    } else {
        Text("Keine Beispieldokumente verfügbar")
    }
} 
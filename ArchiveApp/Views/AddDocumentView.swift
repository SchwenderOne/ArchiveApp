import SwiftUI
import PhotosUI

struct AddDocumentView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var viewModel = AddDocumentViewModel()
    let categoryId: UUID
    
    // Form-Eingaben
    @State private var title = ""
    @State private var notes = ""
    @State private var tagInput = ""
    @State private var selectedTags: [String] = []
    @State private var selectedItems: [PhotosPickerItem] = []
    @State private var selectedImages: [UIImage] = []
    
    // UI-State
    @State private var isShowingCamera = false
    @State private var isShowingPhotosPicker = false
    @State private var isLoading = false
    
    var body: some View {
        NavigationView {
            Form {
                // Titel und Tags
                Section(header: Text("Dokumentdetails")) {
                    TextField("Titel", text: $title)
                    
                    VStack(alignment: .leading) {
                        HStack {
                            TextField("Tags hinzufügen", text: $tagInput)
                                .autocapitalization(.none)
                            
                            Button(action: addTag) {
                                Text("Hinzufügen")
                                    .font(.footnote)
                                    .foregroundColor(.blue)
                            }
                            .disabled(tagInput.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                        }
                        
                        if !selectedTags.isEmpty {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 8) {
                                    ForEach(selectedTags, id: \.self) { tag in
                                        HStack(spacing: 4) {
                                            Text(tag)
                                                .font(.caption)
                                                .foregroundColor(.white)
                                            
                                            Button(action: {
                                                selectedTags.removeAll { $0 == tag }
                                            }) {
                                                Image(systemName: "xmark.circle.fill")
                                                    .font(.caption)
                                                    .foregroundColor(.white.opacity(0.8))
                                            }
                                        }
                                        .padding(.horizontal, 8)
                                        .padding(.vertical, 4)
                                        .background(Color.blue)
                                        .cornerRadius(12)
                                    }
                                }
                                .padding(.vertical, 8)
                            }
                        }
                    }
                    
                    TextField("Notizen", text: $notes, axis: .vertical)
                        .lineLimit(4, reservesSpace: true)
                }
                
                // Dokument-Upload oder Scan
                Section(header: Text("Dokument hinzufügen")) {
                    Button(action: {
                        isShowingCamera = true
                    }) {
                        HStack {
                            Image(systemName: "camera")
                                .foregroundColor(.blue)
                            Text("Mit Kamera scannen")
                        }
                    }
                    
                    Button(action: {
                        isShowingPhotosPicker = true
                    }) {
                        HStack {
                            Image(systemName: "photo.on.rectangle")
                                .foregroundColor(.blue)
                            Text("Aus Fotos auswählen")
                        }
                    }
                }
                .sheet(isPresented: $isShowingCamera) {
                    Text("Kamera-Scan wird in einer zukünftigen Version implementiert.")
                        .padding()
                }
                
                // Vorschau ausgewählter Bilder
                if !selectedImages.isEmpty {
                    Section(header: Text("Ausgewählte Dokumente (\(selectedImages.count))")) {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                ForEach(0..<selectedImages.count, id: \.self) { index in
                                    VStack {
                                        Image(uiImage: selectedImages[index])
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 100, height: 120)
                                            .cornerRadius(8)
                                            .clipped()
                                        
                                        Button(action: {
                                            selectedImages.remove(at: index)
                                            selectedItems.remove(at: index)
                                        }) {
                                            Text("Entfernen")
                                                .font(.caption)
                                                .foregroundColor(.red)
                                        }
                                        .padding(.top, 4)
                                    }
                                }
                            }
                            .padding(.vertical, 8)
                        }
                    }
                }
            }
            .navigationTitle("Dokument hinzufügen")
            .navigationBarItems(
                leading: Button("Abbrechen") {
                    presentationMode.wrappedValue.dismiss()
                },
                trailing: Button("Speichern") {
                    saveDocument()
                }
                .disabled(title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || selectedImages.isEmpty)
            )
            .photosPicker(isPresented: $isShowingPhotosPicker, selection: $selectedItems, maxSelectionCount: 10, matching: .images)
            .onChange(of: selectedItems) { newItems in
                Task {
                    isLoading = true
                    var images: [UIImage] = []
                    
                    for item in newItems {
                        if let data = try? await item.loadTransferable(type: Data.self),
                           let image = UIImage(data: data) {
                            images.append(image)
                        }
                    }
                    
                    selectedImages = images
                    isLoading = false
                }
            }
            .overlay(
                Group {
                    if isLoading {
                        ZStack {
                            Color.black.opacity(0.4)
                                .edgesIgnoringSafeArea(.all)
                            ProgressView()
                                .scaleEffect(1.5)
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        }
                    }
                }
            )
        }
    }
    
    private func addTag() {
        let tag = tagInput.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        if !tag.isEmpty && !selectedTags.contains(tag) {
            selectedTags.append(tag)
            tagInput = ""
        }
    }
    
    private func saveDocument() {
        // In einer echten App würden wir hier das Dokument in der Datenbank speichern
        // Simulieren wir einen erfolgreichen Speichervorgang
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            presentationMode.wrappedValue.dismiss()
        }
    }
}

// ViewModel für die Dokumenterstellung
class AddDocumentViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    func saveDocument(title: String, categoryId: UUID, tags: [String], notes: String, images: [UIImage]) {
        // Diese Methode würde in einer echten App das Dokument in der Datenbank speichern
        // Für jetzt nur ein Platzhalter
    }
}

#Preview {
    // Verwende die erste Kategorie für das Preview
    AddDocumentView(categoryId: Category.sampleCategories[0].id)
} 
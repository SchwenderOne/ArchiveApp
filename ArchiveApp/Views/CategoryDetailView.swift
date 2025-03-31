import SwiftUI

struct CategoryDetailView: View {
    let category: Category
    @StateObject private var viewModel = DocumentViewModel()
    @State private var isShowingAddDocument = false
    
    var body: some View {
        VStack {
            // Header mit Kategoriedaten
            VStack {
                Image(systemName: category.icon)
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(category.color)
                    .frame(width: 50, height: 50)
                    .padding(.bottom, 4)
                
                if let description = category.description {
                    Text(description)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
            }
            .padding()
            
            // Dokumentenliste
            if viewModel.isLoading {
                ProgressView()
                    .padding(.top, 50)
            } else if viewModel.documents.isEmpty {
                VStack(spacing: 16) {
                    Image(systemName: "doc.badge.plus")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.secondary)
                    
                    Text("Keine Dokumente vorhanden")
                        .font(.headline)
                    
                    Text("Tippen Sie auf '+', um ein neues Dokument hinzuzufügen.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    Button(action: {
                        isShowingAddDocument = true
                    }) {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                            Text("Dokument hinzufügen")
                        }
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(8)
                    }
                    .padding(.top, 8)
                }
                .padding(.top, 50)
            } else {
                List {
                    ForEach(viewModel.documents) { document in
                        NavigationLink(destination: DocumentDetailView(document: document)) {
                            DocumentRow(document: document)
                        }
                    }
                }
            }
        }
        .navigationTitle(category.name)
        .navigationBarItems(trailing: Button(action: {
            isShowingAddDocument = true
        }) {
            Image(systemName: "plus")
        })
        .onAppear {
            viewModel.loadDocuments(for: category.id)
        }
        .sheet(isPresented: $isShowingAddDocument) {
            AddDocumentView(categoryId: category.id)
        }
    }
}

#Preview {
    NavigationView {
        CategoryDetailView(category: Category.sampleCategories[0])
    }
} 
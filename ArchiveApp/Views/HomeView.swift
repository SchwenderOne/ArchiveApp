import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = CategoryViewModel()
    
    private let columns = [
        GridItem(.adaptive(minimum: 150), spacing: 16)
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                if viewModel.isLoading {
                    ProgressView()
                        .padding(.top, 100)
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                } else {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(viewModel.categories) { category in
                            NavigationLink(destination: CategoryDetailView(category: category)) {
                                CategoryCard(category: category)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Lebensarchiv")
            .navigationBarItems(trailing: Button(action: {
                // Später: Hier werden wir einen "Hinzufügen"-Button implementieren
            }) {
                Image(systemName: "plus")
            })
            .onAppear {
                viewModel.loadCategories()
            }
        }
    }
}

#Preview {
    HomeView()
} 
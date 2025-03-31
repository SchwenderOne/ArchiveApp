import SwiftUI

struct SearchView: View {
    @StateObject private var viewModel = SearchViewModel()
    @State private var isShowingFilters = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Suchleiste
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.secondary)
                    
                    TextField("Dokumente durchsuchen", text: $viewModel.searchText)
                    
                    if !viewModel.searchText.isEmpty {
                        Button(action: {
                            viewModel.searchText = ""
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .padding(10)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
                .padding(.horizontal)
                
                // Filter-Leiste
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        // Filter-Button
                        Button(action: {
                            isShowingFilters.toggle()
                        }) {
                            HStack {
                                Image(systemName: "line.3.horizontal.decrease.circle")
                                Text("Filter")
                            }
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color.blue.opacity(0.1))
                            .cornerRadius(16)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color.blue.opacity(0.3), lineWidth: 1)
                            )
                        }
                        
                        // Aktive Filter anzeigen
                        if !viewModel.selectedCategories.isEmpty {
                            let categories = Array(viewModel.selectedCategories)
                            ForEach(categories, id: \.self) { categoryId in
                                let categoryName = viewModel.getCategoryName(for: categoryId)
                                let categoryColor = viewModel.getCategoryColor(for: categoryId)
                                
                                ClearableFilterChip(
                                    title: categoryName,
                                    color: categoryColor
                                ) {
                                    viewModel.selectedCategories.remove(categoryId)
                                }
                            }
                        }
                        
                        if viewModel.dateRange != .allTime {
                            ClearableFilterChip(
                                title: viewModel.dateRange.displayName,
                                color: .orange
                            ) {
                                viewModel.dateRange = .allTime
                            }
                        }
                        
                        if viewModel.sortOrder != .newestFirst {
                            ClearableFilterChip(
                                title: viewModel.sortOrder.rawValue,
                                color: .purple
                            ) {
                                viewModel.sortOrder = .newestFirst
                            }
                        }
                        
                        if let tagFilter = viewModel.tagFilter, !tagFilter.isEmpty {
                            ClearableFilterChip(
                                title: "Tag: \(tagFilter)",
                                color: .blue
                            ) {
                                viewModel.tagFilter = nil
                            }
                        }
                        
                        // Reset-Button, falls Filter aktiv sind
                        if viewModel.dateRange != .allTime || 
                           !viewModel.selectedCategories.isEmpty || 
                           viewModel.sortOrder != .newestFirst ||
                           viewModel.tagFilter != nil {
                            Button(action: viewModel.resetFilters) {
                                Text("Zurücksetzen")
                                    .font(.caption)
                                    .foregroundColor(.red)
                            }
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                }
                
                Divider()
                
                // Ergebnisse oder Platzhalter
                if viewModel.isLoading {
                    ProgressView()
                        .padding(.top, 100)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if viewModel.searchResults.isEmpty {
                    VStack(spacing: 16) {
                        if !viewModel.searchText.isEmpty {
                            Image(systemName: "magnifyingglass")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 60, height: 60)
                                .foregroundColor(.secondary)
                            
                            Text("Keine Ergebnisse gefunden")
                                .font(.headline)
                            
                            Text("Versuchen Sie es mit anderen Suchbegriffen oder Filtern.")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 32)
                        } else {
                            Image(systemName: "doc.text.magnifyingglass")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80, height: 80)
                                .foregroundColor(.secondary)
                                .padding(.bottom)
                            
                            Text("Geben Sie einen Suchbegriff ein")
                                .font(.headline)
                            
                            Text("Durchsuchen Sie alle Ihre Dokumente nach Titeln, Inhalt oder Tags.")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 32)
                        }
                    }
                    .padding(.top, 80)
                } else {
                    // Suchergebnisse
                    List {
                        ForEach(viewModel.searchResults) { document in
                            NavigationLink(destination: DocumentDetailView(document: document)) {
                                VStack(alignment: .leading, spacing: 4) {
                                    HStack {
                                        Text(document.title)
                                            .font(.headline)
                                        
                                        Spacer()
                                        
                                        Text(formatDate(document.dateAdded))
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                    }
                                    
                                    HStack {
                                        Text(viewModel.getCategoryName(for: document.categoryId))
                                            .font(.caption)
                                            .padding(.horizontal, 8)
                                            .padding(.vertical, 2)
                                            .background(viewModel.getCategoryColor(for: document.categoryId).opacity(0.2))
                                            .cornerRadius(4)
                                        
                                        Spacer()
                                        
                                        if !document.tags.isEmpty {
                                            Text(document.tags.joined(separator: ", "))
                                                .font(.caption)
                                                .foregroundColor(.secondary)
                                        }
                                    }
                                }
                                .padding(.vertical, 4)
                            }
                        }
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .navigationTitle("Suche")
            .sheet(isPresented: $isShowingFilters) {
                SearchFilterView(viewModel: viewModel)
            }
        }
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }
}

struct SearchFilterView: View {
    @ObservedObject var viewModel: SearchViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                // Kategorien
                Section(header: Text("Kategorien")) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            ForEach(Category.sampleCategories) { category in
                                FilterChip(
                                    title: category.name,
                                    isSelected: viewModel.selectedCategories.contains(category.id),
                                    color: category.color
                                ) {
                                    if viewModel.selectedCategories.contains(category.id) {
                                        viewModel.selectedCategories.remove(category.id)
                                    } else {
                                        viewModel.selectedCategories.insert(category.id)
                                    }
                                }
                            }
                        }
                        .padding(.vertical, 8)
                    }
                }
                
                // Datum
                Section(header: Text("Zeitraum")) {
                    // Datum Filter Optionen
                    VStack(alignment: .leading, spacing: 12) {
                        ForEach([DateRange.allTime, .last7Days, .last30Days, .last90Days, .lastYear], id: \.displayName) { range in
                            Button(action: {
                                viewModel.dateRange = range
                            }) {
                                HStack {
                                    Text(range.displayName)
                                    
                                    Spacer()
                                    
                                    if viewModel.dateRange == range {
                                        Image(systemName: "checkmark")
                                            .foregroundColor(.blue)
                                    }
                                }
                                .contentShape(Rectangle())
                            }
                            .foregroundColor(.primary)
                        }
                        
                        // Später können wir hier einen benutzerdefinierten Datumsbereich hinzufügen
                    }
                }
                
                // Sortierung
                Section(header: Text("Sortierung")) {
                    Picker("", selection: $viewModel.sortOrder) {
                        ForEach(SortOrder.allCases) { order in
                            Text(order.rawValue).tag(order)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                // Tag-Filter
                Section(header: Text("Tags filtern")) {
                    HStack {
                        TextField("Nach Tag filtern", text: Binding(
                            get: { viewModel.tagFilter ?? "" },
                            set: { viewModel.tagFilter = $0.isEmpty ? nil : $0 }
                        ))
                        
                        if viewModel.tagFilter != nil {
                            Button(action: {
                                viewModel.tagFilter = nil
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
                
                // Zurücksetzen
                Section {
                    Button(action: {
                        viewModel.resetFilters()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }) {
                        HStack {
                            Spacer()
                            Text("Filter zurücksetzen")
                                .foregroundColor(.red)
                            Spacer()
                        }
                    }
                }
            }
            .navigationTitle("Suchfilter")
            .navigationBarItems(trailing: Button("Fertig") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

#Preview {
    SearchView()
} 
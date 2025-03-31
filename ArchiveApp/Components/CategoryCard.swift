import SwiftUI

struct CategoryCard: View {
    let category: Category
    
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(category.color.opacity(0.2))
                    .frame(height: 100)
                
                Image(systemName: category.icon)
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(category.color)
                    .frame(width: 40, height: 40)
            }
            
            Text(category.name)
                .font(.headline)
                .lineLimit(1)
            
            if let description = category.description {
                Text(description)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
                    .multilineTextAlignment(.center)
            }
        }
        .padding(8)
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    CategoryCard(category: Category.sampleCategories[0])
        .frame(width: 160)
        .previewDisplayName("Kategorie-Karte")
} 
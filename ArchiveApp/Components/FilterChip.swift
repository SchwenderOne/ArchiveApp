import SwiftUI

struct FilterChip: View {
    let title: String
    let isSelected: Bool
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 4) {
                Text(title)
                    .font(.caption)
                    .fontWeight(isSelected ? .semibold : .regular)
                
                if isSelected {
                    Image(systemName: "checkmark")
                        .font(.system(size: 10, weight: .bold))
                }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(isSelected ? color.opacity(0.2) : Color.gray.opacity(0.1))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(isSelected ? color : Color.gray.opacity(0.3), lineWidth: 1)
            )
            .foregroundColor(isSelected ? color : .primary)
        }
    }
}

struct ClearableFilterChip: View {
    let title: String
    let color: Color
    let onClear: () -> Void
    
    var body: some View {
        HStack(spacing: 4) {
            Text(title)
                .font(.caption)
                .fontWeight(.semibold)
            
            Button(action: onClear) {
                Image(systemName: "xmark.circle.fill")
                    .font(.system(size: 12))
                    .foregroundColor(color)
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 6)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(color.opacity(0.2))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(color, lineWidth: 1)
        )
        .foregroundColor(color)
    }
}

#Preview {
    HStack {
        FilterChip(
            title: "Alle Dokumente",
            isSelected: true,
            color: .blue
        ) {
            // Action
        }
        
        FilterChip(
            title: "Finanzen",
            isSelected: false,
            color: .green
        ) {
            // Action
        }
        
        ClearableFilterChip(
            title: "Letzte 30 Tage",
            color: .orange
        ) {
            // Clear action
        }
    }
    .padding()
    .previewDisplayName("Filter Chips")
} 
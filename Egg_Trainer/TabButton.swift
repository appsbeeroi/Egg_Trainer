import SwiftUI

struct TabButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .fontWeight(.bold)
                .foregroundColor(isSelected ? .black : .white)
                .padding(.vertical, 12)
                .frame(maxWidth: .infinity)
                .background(isSelected ? Color.orange : Color.white.opacity(0.15))
                .cornerRadius(15)
        }
    }
}

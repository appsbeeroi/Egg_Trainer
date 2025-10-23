import SwiftUI

struct FrequencyView: View {
    let frequency: String

    var body: some View {
        Text(frequency)
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.white.opacity(0.15))
            .cornerRadius(20)
    }
}

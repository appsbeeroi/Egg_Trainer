import SwiftUI

struct StepsView: View {
    let steps: [String]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            ForEach(steps, id: \.self) { step in
                HStack(alignment: .top) {
                    Text("•")
                        .foregroundColor(.orange)
                        .fontWeight(.bold)
                    Text(step)
                        .foregroundColor(.white)
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white.opacity(0.15))
        .cornerRadius(20)
    }
}

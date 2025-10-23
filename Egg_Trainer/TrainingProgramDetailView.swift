import SwiftUI

struct TrainingProgramDetailView: View {
    let program: TrainingProgram

    enum InfoTab {
        case steps, frequency
    }

    @State private var selectedTab: InfoTab = .steps
    @Environment(\.dismiss) var dismiss

    let primaryBackgroundColor = Color(red: 30/255, green: 72/255, blue: 50/255)

    var body: some View {
        ZStack {
            Image(.background)
                .resizeAnd()

            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Image(program.imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 250)
                        .clipShape(RoundedRectangle(cornerRadius: 20))

                    Text(program.title)
                        .font(.largeTitle.bold())
                        .foregroundColor(.white)

                    Text(program.description)
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.8))

                    HStack(spacing: 15) {
                        TabButton(title: "Steps", isSelected: selectedTab == .steps) {
                            withAnimation { selectedTab = .steps }
                        }
                        TabButton(title: "Frequency", isSelected: selectedTab == .frequency) {
                            withAnimation { selectedTab = .frequency }
                        }
                    }
                    .frame(maxWidth: .infinity)

                    if selectedTab == .steps {
                        StepsView(steps: program.steps)
                            .transition(.opacity)
                    } else {
                        FrequencyView(frequency: program.frequency)
                            .transition(.opacity)
                    }
                }
                .padding()
            }
            .padding(.bottom, 90)
        }

        .navigationTitle(program.title)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)

        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }, label: {
                    Image(systemName: "arrow.left")
                        .foregroundColor(.white)
                })
            }
        }
    }
}

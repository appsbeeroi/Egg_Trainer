import SwiftUI

struct TrainingProgramListView: View {
    let programs: [TrainingProgram] = TrainingProgram.samplePrograms

    let primaryBackgroundColor = Color(red: 30/255, green: 72/255, blue: 50/255)

    var body: some View {
        NavigationStack {
            ZStack {
                Image(.background)
                    .resizeAnd()
                
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(programs) { program in
                            NavigationLink(value: program) {
                                ProgramCardView(program: program)
                            }
                        }
                    }
                    .padding()
                }
                .padding(.top, 5)
                .padding(.bottom, 90)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Training\nprogram")
                        .font(.system(size: 30, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                }
            }
            .navigationDestination(for: TrainingProgram.self) { program in
                TrainingProgramDetailView(program: program)
            }
        }
    }
}


struct ProgramCardView: View {
    let program: TrainingProgram

    var body: some View {
        VStack {
            Image(program.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 200)
                .cornerRadius(20)
            
            Text(program.title)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.title.bold())
                .foregroundColor(.white)
        }
    }
}

struct TrainingProgramListView_Previews: PreviewProvider {
    static var previews: some View {
        TrainingProgramListView()
    }
}

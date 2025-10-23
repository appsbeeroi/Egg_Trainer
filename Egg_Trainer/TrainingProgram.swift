import Foundation

struct TrainingProgram: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let description: String
    let imageName: String
    let steps: [String]
    let frequency: String
}

extension TrainingProgram {
    static let samplePrograms: [TrainingProgram] = [
        TrainingProgram(
            title: "Approach to Feeder",
            description: "Teach the chicken to approach the feeder on cue",
            imageName: "program_image_1",
            steps: [
                "Place the feeder in a visible location.",
                "Attract the chicken with a treat or a sound signal.",
                "When the chicken approaches, give a treat and praise it.",
                "Repeat several times to reinforce the connection between the signal and the action."
            ],
            frequency: "2-3 times a day for 5-10 minutes"
        ),
        TrainingProgram(
            title: "Approach to Feeder",
            description: "A variation of the program with different steps",
            imageName: "program_image_2",
            steps: [
                "Step 1 for variation.",
                "Step 2 for variation.",
                "Step 3 for variation."
            ],
            frequency: "Once a day in the morning"
        )
    ]
}

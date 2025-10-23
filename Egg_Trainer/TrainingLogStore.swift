import Foundation
import SwiftUI

enum TrainingStatus: String, CaseIterable, Codable, Hashable {
    case inProgress = "In Progress"
    case successful = "Successful"
    case failed = "Failed"

    var color: Color {
        switch self {
        case .inProgress: return .yellow
        case .successful: return .green
        case .failed: return .red
        }
    }
}

struct TrainingLog: Identifiable, Codable, Equatable, Hashable {
    var id = UUID()
    var title: String
    var note: String
    var date: Date
    var status: TrainingStatus

    var dateString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.string(from: date)
    }
}

@MainActor
class TrainingLogStore: ObservableObject {
    @Published var logs: [TrainingLog] = []
    
    init() {
        self.logs = [
            TrainingLog(title: "Approach to Feeder", note: "Training the hens...", date: Date(), status: .failed),
            TrainingLog(title: "Morning Run", note: "5km run...", date: Date().addingTimeInterval(-86400), status: .inProgress),
            TrainingLog(title: "Weightlifting", note: "Chest and triceps...", date: Date().addingTimeInterval(-172800), status: .successful)
        ]
    }
    
    func deleteLog(logToDelete: TrainingLog) {
        logs.removeAll { $0.id == logToDelete.id }
    }
    
    func updateLog(updatedLog: TrainingLog) {
        guard let index = logs.firstIndex(where: { $0.id == updatedLog.id }) else { return }
        logs[index] = updatedLog
    }
    
    func addLog(_ log: TrainingLog) {
        logs.append(log)
    }
}

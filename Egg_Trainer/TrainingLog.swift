import SwiftUI

enum TrainingStatus: String, CaseIterable, Codable {
    case inProgress = "In Progress"
    case successful = "Successful"
    case failed = "Failed"

    var color: Color {
        switch self {
        case .inProgress:
            return .yellow
        case .successful:
            return .green
        case .failed:
            return .red
        }
    }
}

struct TrainingLog: Identifiable, Codable, Hashable {
    let id: UUID
    var title: String
    var date: Date
    var status: TrainingStatus
    var note: String

    init(id: UUID = UUID(), title: String, date: Date, status: TrainingStatus, note: String) {
        self.id = id
        self.title = title
        self.date = date
        self.status = status
        self.note = note
    }

    var dateString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.string(from: date)
    }
}

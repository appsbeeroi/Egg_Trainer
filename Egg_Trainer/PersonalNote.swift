import Foundation
import SwiftUI

struct PersonalNote: Identifiable, Hashable {
    let id: UUID
    var title: String
    var noteText: String
    var date: Date
    var imageData: Data?


    init(id: UUID = UUID(), title: String, noteText: String, date: Date, imageData: Data?) {
        self.id = id
        self.title = title
        self.noteText = noteText
        self.date = date
        self.imageData = imageData
    }


    var dateString: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }

    var image: UIImage? {
        guard let data = imageData else { return nil }
        return UIImage(data: data)
    }
}

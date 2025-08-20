import Foundation
import SwiftData

@Model
class Journal {
    let id = UUID()
    var title: String
    var journal: String
    var date: Date
    var modifiedDate: Date
    var analysis: String
    var isHidden: Bool

    init(title: String, journal: String, date: Date, analysis: String, isHidden: Bool, modifiedDate: Date) {
        self.title = title
        self.journal = journal
        self.date = date
        self.analysis = analysis
        self.isHidden = isHidden
        self.modifiedDate = modifiedDate
    }
}

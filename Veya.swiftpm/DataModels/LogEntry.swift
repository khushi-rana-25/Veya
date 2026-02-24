import Foundation
import SwiftData

@Model
class LogEntry {
    var id: UUID = UUID()
    var timestamp: Date = Date()
    var symptomName: String
    var severity: String

    init(
        symptomName: String,
        severity: String,
    ) {
        self.symptomName = symptomName
        self.severity = severity
    }
}

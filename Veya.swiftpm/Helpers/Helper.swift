import Foundation
import SwiftUI
import SwiftData

@MainActor
class Helper{
    static let shared = Helper()
    
    static let timestampFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateStyle = .short
        df.timeStyle = .short
        df.doesRelativeDateFormatting = false
        return df
    }()
    
    func formatted(_ date: Date) -> String {
        Self.timestampFormatter.string(from: date)
    }
    
    func severityColor(_ severity: String) -> Color {
        if severity == "Mild" { return .green }
        else if severity == "Moderate" { return .orange }
        else { return .red }
    }
}

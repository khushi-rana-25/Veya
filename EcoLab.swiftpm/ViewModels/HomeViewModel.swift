import Foundation
import SwiftUI

@Observable
class HomeViewModel {
    
    var symptomsData: [Symptom] = PregnancySymptoms.allSymptoms
    private let iconColors: [Color] = [.yellow, .blue, .indigo, .cyan, .brown, .mint, .green]

    static func iconAndColor(for symptomName: String) -> (icon: String, color: Color) {
        let colors: [Color] = [.yellow, .blue, .indigo, .cyan, .brown, .mint, .green]
        let symptom = PregnancySymptoms.allSymptoms.first { $0.name == symptomName }
        let icon = symptom?.icon ?? "circle.fill"
        let color: Color = symptom.map { s in colors[abs(s.id.hashValue) % colors.count] } ?? Color(white: 0.5)
        return (icon, color)
    }

    func sortSymptoms() {
        withAnimation {
            symptomsData.sort { $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending }
        }
    }
    
    func sortRandomly() {
        withAnimation {
            symptomsData.shuffle()
        }
    }
    
    func colorForSymptom(_ symptom: Symptom) -> Color {
        let idx = abs(symptom.id.hashValue) % iconColors.count
        return iconColors[idx]
    }
}

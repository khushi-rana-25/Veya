//
//  File.swift
//  EcoLab
//
//  Created by Khushi Rana on 27/12/25.
//

import Foundation
import SwiftUI

@Observable
class HomeViewModel {
    
    var symptomsData: [Symptom] = PregnancySymptoms.allSymptoms
    private let iconColors: [Color] = [.yellow, .blue, .indigo, .cyan, .brown, .mint, .green]
    
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

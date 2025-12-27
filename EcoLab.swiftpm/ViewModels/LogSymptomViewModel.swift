//
//  File.swift
//  EcoLab
//
//  Created by Khushi Rana on 27/12/25.
//

import Foundation
import SwiftUI

@Observable
class LogSymptomViewModel {
    
    var color: Color
    var sliderValue: Double = 0
    
    init(color: Color) {
        self.color = color
    }
    
    var currentMode: SymptomMode {
        if sliderValue < 0.33 { return .mild }
        else if sliderValue < 0.66 { return .moderate }
        else { return .severe }
    }
    
    var activeColor: Color {
        if sliderValue < 0.33 { return color }
        else if sliderValue < 0.66 { return .orange }
        else { return .red }
    }
    
    var animationDuration: Double {
        return 2.0 - (sliderValue * 1.5)
    }
    
}

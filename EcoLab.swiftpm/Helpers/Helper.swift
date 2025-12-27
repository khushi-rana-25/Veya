//
//  File.swift
//  EcoLab
//
//  Created by Khushi Rana on 27/12/25.
//

import Foundation

@MainActor
class Helper{
    
    static let shared = Helper()
    
    static let timestampFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateStyle = .medium
        df.timeStyle = .short
        df.doesRelativeDateFormatting = false
        return df
    }()
    
    func formatted(_ date: Date) -> String {
        Self.timestampFormatter.string(from: date)
    }
    
}

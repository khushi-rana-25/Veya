//
//  File.swift
//  EcoLab
//
//  Created by Khushi Rana on 26/12/25.
//

import Foundation
import SwiftData

@Observable
class ViewModel {
    
    func addLog(symptomName: String, severity: String, context: ModelContext){
        let newData = LogEntry(symptomName: symptomName, severity: severity)
        context.insert(newData)
        
        try? context.save()
    }
    
    func deleteLog(at offsets: IndexSet, from logs: [LogEntry], context: ModelContext) {
        for offset in offsets {
            let logToDelete = logs[offset]
            context.delete(logToDelete)
            try? context.save()
        }
    }
    
    func deleteLog(at indexSet: IndexSet, in sectionLogs: [LogEntry], modelContext: ModelContext) {
            for index in indexSet {
                let logToDelete = sectionLogs[index]
                modelContext.delete(logToDelete)
                try? modelContext.save()
            }
    }
}

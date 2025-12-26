//
//  SwiftUIView.swift
//  EcoLab
//
//  Created by Khushi Rana on 26/12/25.
//

import SwiftUI
import SwiftData

struct SymptomsHistoryView: View {
    @Environment(\.modelContext) var modelContext
    @Query var dataModel: [LogEntry]
    
    var body: some View {
        NavigationStack{
            List{
                ForEach(dataModel) { log in
                    SymptomHistoryRowView(log: log)
                }
                .onDelete(perform: deleteLog)
                .alignmentGuide(.listRowSeparatorLeading) { _ in 0 }
            }
            .listStyle(.plain)
            .navigationTitle("Journal")
        }
    }
    
    func deleteLog(at offsets: IndexSet) {
        for offset in offsets {
            let log = dataModel[offset]
            modelContext.delete(log)
            try? modelContext.save()
        }
    }
}

struct SymptomHistoryRowView: View {
    let log: LogEntry
    
    var body: some View {
        
        HStack(spacing: 20){
            
            VStack(alignment: .leading){
                Text(log.symptomName)
                    .font(.title3)
                    .fontWeight(.semibold)
                
                Text(formatted(log.timestamp))
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            let color: Color = log.severity == "Mild" ? .mint : (log.severity == "Moderate" ? .yellow : .red)
            
            Text(log.severity)
                .padding()
                .foregroundStyle(color)
                .frame(width: 120)
                .overlay(
                    RoundedRectangle(cornerRadius: 27)
                        .strokeBorder(.primary, lineWidth: 2)
                )
        }
    }
    
    private static let timestampFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateStyle = .medium
        df.timeStyle = .short
        df.doesRelativeDateFormatting = false
        return df
    }()
    
    private func formatted(_ date: Date) -> String {
        Self.timestampFormatter.string(from: date)
    }
}

#Preview {
    SymptomsHistoryView()
}

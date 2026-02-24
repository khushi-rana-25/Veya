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
    @Query(sort: \LogEntry.timestamp, order: .reverse) var dataModel: [LogEntry]
    @State var viewModel: ViewModel = ViewModel()
    
    var groupedLogs: [(key: Date, value: [LogEntry])] {
        let grouped = Dictionary(grouping: dataModel) { entry in
            let components = Calendar.current.dateComponents([.year, .month], from: entry.timestamp)
            return Calendar.current.date(from: components) ?? Date()
        }
        
        return grouped.sorted { $0.key > $1.key }
    }
    
    var body: some View {
            NavigationStack {
                List {
                    ForEach(groupedLogs, id: \.key) { section in
                        Section {
                            ForEach(section.value) { log in
                                SymptomHistoryRowView(log: log)
                            }
                            .onDelete { indexSet in
                                viewModel.deleteLog(at: indexSet, in: section.value, modelContext: modelContext)
                            }
                        } header: {
                            Text(section.key.formatted(.dateTime.month(.wide).year()))
                                .font(.headline)
                                .foregroundStyle(.primary)
                        }
                    }
                }
                .listStyle(.plain)
                .navigationTitle("History")
            }
        }
}

struct SymptomHistoryRowView: View {
    let log: LogEntry
    
    var body: some View {
        
        HStack(spacing: 20){
            
            VStack(alignment: .leading){
                Text(log.symptomName)
                    .font(.headline)
                    .fontWeight(.semibold)
                
                Text(Helper.shared.formatted(log.timestamp))
                    .foregroundStyle(.secondary)
                    .font(.subheadline)
            }
            
            Spacer()
            
            let color: Color = log.severity == "Mild" ? .mint : (log.severity == "Moderate" ? .yellow : .red)
            
            Text(log.severity)
                .padding()
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundStyle(color)
                .frame(width: 120)
                .overlay(
                    RoundedRectangle(cornerRadius: 27)
                        .strokeBorder(.gray, lineWidth: 1)
                )
            
        }
    }
}

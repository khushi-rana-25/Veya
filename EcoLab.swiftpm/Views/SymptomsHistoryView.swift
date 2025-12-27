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
    
    var body: some View {
        NavigationStack{
            List{
                ForEach(dataModel) { log in
                    SymptomHistoryRowView(log: log)
                }
                .onDelete(perform: { indexSet in
                    viewModel.deleteLog(at: indexSet, from: dataModel, context: modelContext)
                })
                .alignmentGuide(.listRowSeparatorLeading) { _ in 0 }
            }
            .listStyle(.plain)
            .navigationTitle("Journal")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        LogGraphView()
                    } label: {
                        Image(systemName: "chart.bar.xaxis")
                            .foregroundStyle(.blue)
                    }

                }
            }
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
}

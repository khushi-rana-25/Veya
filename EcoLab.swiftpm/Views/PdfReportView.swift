


import SwiftUI
import SwiftData

struct PdfReportView: View {
    let date = Date()
    var logs: [LogEntry]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            // 1. HEADER
            HStack {
                Text("ECO-LAB REPORT")
                    .font(.largeTitle).bold()
                Spacer()
                Text(date.formatted(date: .numeric, time: .omitted))
                    .foregroundStyle(.secondary)
            }
            .padding(.bottom, 10)
            
            Divider()
            
            VStack(alignment: .leading, spacing: 10) {
                Text("SUMMARY")
                    .font(.headline)
                    .foregroundStyle(.gray)
                
                HStack {
                    Text("Total Logs:")
                    Spacer()
                    Text("\(logs.count)")
                }
                HStack {
                    Text("Primary Concern:")
                    Spacer()
                    Text(primaryConcern)
                        .bold()
                }
            }
            
            Divider()
            
            VStack(alignment: .leading, spacing: 10) {
                Text("SYMPTOM BREAKDOWN")
                    .font(.headline)
                    .foregroundStyle(.gray)
                
                HStack {
                    Text("Symptom").bold().frame(maxWidth: .infinity, alignment: .leading)
                    Text("Count").bold().frame(width: 60, alignment: .center)
                    Text("Max Severity").bold().frame(width: 100, alignment: .trailing)
                }
                .padding(.bottom, 5)
                
                ForEach(breakdown.prefix(5), id: \.name) { item in
                    HStack {
                        Text(item.name).frame(maxWidth: .infinity, alignment: .leading)
                        Text("\(item.count)").frame(width: 60, alignment: .center)
                        Text(item.maxSev)
                            .foregroundStyle(Helper.shared.severityColor(item.maxSev))
                            .frame(width: 100, alignment: .trailing)
                    }
                    Divider()
                }
            }
            Spacer()
        }
        .padding(40)
        .background(.white)
        .foregroundColor(.black)
    }
    
    var primaryConcern: String {
        let grouped = Dictionary(grouping: logs, by: { $0.symptomName })
        return grouped.max(by: { $0.value.count < $1.value.count })?.key ?? "None"
    }
    
    var severeLogs: [LogEntry] {
        logs.filter { $0.severity == "Severe" }
            .sorted { $0.timestamp > $1.timestamp }
    }
    
    private var severityRank: [String: Int] {
        ["Mild": 0, "Moderate": 1, "Severe": 2]
    }
    
    var breakdown: [(name: String, count: Int, maxSev: String)] {
        let grouped = Dictionary(grouping: logs, by: { $0.symptomName })
        return grouped.map { (key, value) in
            let maxSeverity = value
                .map { $0.severity }
                .max { (a, b) in
                    (severityRank[a] ?? -1) < (severityRank[b] ?? -1)
                } ?? "Mild"
            return (key, value.count, maxSeverity)
        }
        .sorted { $0.count > $1.count }
    }
}

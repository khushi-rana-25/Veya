//
//  SwiftUIView.swift
//  EcoLab
//
//  Created by Khushi Rana on 27/12/25.
//

import SwiftUI
import SwiftData
import Charts

struct LogGraphView: View {
    @Query(sort: \LogEntry.timestamp) var dataModel: [LogEntry]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Symptom Breakdown")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.bottom, 10)
            
            ScrollView {
                Chart {
                    ForEach(dataModel) { log in
                        BarMark(
                            x: .value("Frequency", 1),
                            y: .value("Symptom", log.symptomName)
                        )
                        .cornerRadius(5)
                        .foregroundStyle(severityColor(log.severity))
                    }
                }
                .frame(height: max(300, CGFloat(dataModel.count * 30)))
                .chartXAxis {
                    AxisMarks(position: .bottom) { _ in
                        AxisGridLine().foregroundStyle(.clear)
                        AxisTick().foregroundStyle(.clear)
                        AxisValueLabel()
                    }
                }
                .chartYAxis {
                    AxisMarks { value in
                        AxisValueLabel {
                            if let name = value.as(String.self) {
                                Text(name)
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundStyle(.primary)
                            }
                        }
                    }
                }
            }
        }
        .padding(20)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 5)
        .padding()
    }

     func severityColor(_ severity: String) -> Color {
            if severity == "Mild" { return .green }
            else if severity == "Moderate" { return .orange }
            else { return .red }
        }

}

#Preview {
    LogGraphView()
}

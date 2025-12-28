//
//  SwiftUIView.swift
//  EcoLab
//
//  Created by Khushi Rana on 28/12/25.
//

import SwiftUI
import SwiftData
import Charts

struct SymptomInsightsView: View {
    @Query(sort: \LogEntry.timestamp) var dataModel: [LogEntry]
    
    var uniqueSymptomCount: Int {
        let count = Set(dataModel.map { $0.symptomName }).count
        return max(count, 1)
    }
    
    var body: some View {
            GeometryReader { geometry in
                ZStack {
                    Image("Background2")
                        .resizable()
                        .scaledToFill()
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .clipped()
                        .ignoresSafeArea()
                        .overlay(.black.opacity(0.3))
                    
                    VStack {
                        Spacer()
                        
                        VStack(alignment: .leading, spacing: 0) {
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Symptom Insights")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.white)
                                
                                Text("Frequency & Severity Report")
                                    .font(.caption)
                                    .foregroundStyle(.white.opacity(0.7))
                            }
                            .padding([.top, .horizontal], 25)
                            .padding(.bottom, 15)
                            
                            ScrollView {
                                if dataModel.isEmpty {
                                    ContentUnavailableView("No Data", systemImage: "chart.bar", description: Text("Log symptoms to see insights."))
                                        .foregroundStyle(.white)
                                        .frame(height: 200)
                                } else {
                                    Chart {
                                        ForEach(dataModel) { log in
                                            BarMark(
                                                x: .value("Frequency", 1),
                                                y: .value("Symptom", log.symptomName)
                                            )
                                            .cornerRadius(6)
                                            .foregroundStyle(severityColor(log.severity).gradient)
                                        }
                                    }
                                    .frame(height: 200 + CGFloat(uniqueSymptomCount * 50))
                                    .padding(.horizontal, 25)
                                    .padding(.bottom, 25)
                                    
                                    .chartXAxis(.hidden)
                                    .chartYAxis {
                                        AxisMarks { value in
                                            AxisValueLabel {
                                                if let name = value.as(String.self) {
                                                    Text(name)
                                                        .font(.system(size: 14, weight: .semibold, design: .rounded))
                                                        .foregroundStyle(.white)
                                                        .multilineTextAlignment(.leading)
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            .frame(maxHeight: geometry.size.height * 0.7)
                            .scrollIndicators(.hidden)
                        }
                        .background(.ultraThinMaterial)
                        .environment(\.colorScheme, .dark)
                        .clipShape(RoundedRectangle(cornerRadius: 25))
                        .shadow(color: .black.opacity(0.3), radius: 15, x: 0, y: 10)
                        .padding()
                        
                        Spacer()
                    }
                }
            }
            .ignoresSafeArea()
            .toolbarBackground(.hidden, for: .navigationBar)
        }
    
    func severityColor(_ severity: String) -> Color {
            if severity == "Mild" { return .green }
            else if severity == "Moderate" { return .orange }
            else { return .red }
        }
}

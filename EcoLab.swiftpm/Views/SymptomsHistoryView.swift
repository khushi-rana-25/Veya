import SwiftUI
import SwiftData

struct SymptomsHistoryView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \LogEntry.timestamp, order: .reverse) var dataModel: [LogEntry]
    @State var viewModel: ViewModel = ViewModel()

    private let themeCream = Color(red: 1.0, green: 0.97, blue: 0.96)
    private let themeCoral = Color(red: 0.85, green: 0.45, blue: 0.38)

    var groupedLogs: [(key: Date, value: [GroupedLog])] {
        let byMonth = Dictionary(grouping: dataModel) { entry in
            Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: entry.timestamp)) ?? Date()
        }
        
        return byMonth.map { (monthDate, logs) in
            let grouped = Dictionary(grouping: logs) { log in
                let date = Calendar.current.startOfDay(for: log.timestamp)
                return "\(date)-\(log.symptomName)-\(log.severity)"
            }
            
            let aggregated = grouped.map { (_, entries) -> GroupedLog in
                let sortedEntries = entries.sorted { $0.timestamp > $1.timestamp }
                return GroupedLog(
                    symptomName: sortedEntries.first!.symptomName,
                    severity: sortedEntries.first!.severity,
                    logIDs: sortedEntries.map { $0.persistentModelID },
                    timestamps: sortedEntries.map { $0.timestamp },
                    count: entries.count
                )
            }.sorted { $0.timestamps.first! > $1.timestamps.first! }
            
            return (key: monthDate, value: aggregated)
        }.sorted { $0.key > $1.key }
    }

    var body: some View {
        ZStack {
            themeCream.ignoresSafeArea()

            if dataModel.isEmpty {
                emptyState
            } else {
                List {
                    ForEach(groupedLogs, id: \.key) { section in
                        Section {
                            ForEach(section.value) { group in
                                SymptomHistoryRowView(group: group)
                                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                        Button(role: .destructive) {
                                            deleteGroup(group)
                                        } label: {
                                            Label("Delete", systemImage: "trash.fill")
                                        }
                                    }
                                    .tint(.red)
                                    .listRowInsets(EdgeInsets(top: 6, leading: 16, bottom: 6, trailing: 16))
                                    .listRowBackground(Color.clear)
                                    .listRowSeparator(.hidden)
                            }
                        } header: {
                            sectionHeader(date: section.key, count: section.value.count)
                        }
                    }
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
            }
        }
        .navigationTitle("History")
    }
    
    private func deleteGroup(_ group: GroupedLog) {
        withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
            for id in group.logIDs {
                if let model = modelContext.model(for: id) as? LogEntry {
                    modelContext.delete(model)
                }
            }
            try? modelContext.save()
        }
    }

    private func sectionHeader(date: Date, count: Int) -> some View {
        HStack {
            Text(date.formatted(.dateTime.month(.wide).year()))
                .font(.system(size: 13, weight: .bold, design: .rounded))
                .foregroundStyle(themeCoral)
                .textCase(.uppercase)
                .tracking(0.8)
            Spacer()
            Text("\(count) groups")
                .font(.system(size: 12, weight: .medium, design: .rounded))
                .foregroundStyle(themeCoral.opacity(0.6))
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 12)
        .background(themeCream)
    }
    
    private var emptyState: some View {
        VStack(spacing: 16) {
            Image(systemName: "clock.badge.xmark")
                .font(.system(size: 40))
                .foregroundStyle(themeCoral.opacity(0.4))
            Text("No logs yet")
                .font(.bold(.system(size: 18, design: .rounded))())
        }
    }
}

struct SymptomHistoryRowView: View {
    let group: GroupedLog

    private var severityColor: Color {
        switch group.severity {
        case "Mild":     return Color(red: 0.2, green: 0.7, blue: 0.5)
        case "Moderate": return Color(red: 0.9, green: 0.6, blue: 0.1)
        case "Severe":   return Color(red: 0.85, green: 0.25, blue: 0.25)
        default:         return .gray
        }
    }

    var body: some View {
        HStack(spacing: 16) {
            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 8) {
                    Text(group.symptomName)
                        .font(.system(size: 16, weight: .semibold, design: .rounded))
                    
                    if group.count > 1 {
                        Text("×\(group.count)")
                            .font(.system(size: 12, weight: .black))
                            .foregroundStyle(severityColor)
                            .padding(.horizontal, 6)
                            .padding(.vertical, 2)
                            .background(severityColor.opacity(0.1))
                            .clipShape(Capsule())
                    }
                }
                
                Text("Last: \(group.timestamps.first!.formatted(.dateTime.hour().minute()))")
                    .font(.system(size: 13))
                    .foregroundStyle(.secondary)
            }

            Spacer()

            Text(group.severity)
                .font(.system(size: 10, weight: .bold))
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .background(
                    Capsule()
                        .stroke(severityColor.opacity(0.3), lineWidth: 1)
                        .background(severityColor.opacity(0.05))
                )
                .foregroundStyle(severityColor)
        }
        .padding(16)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: .black.opacity(0.03), radius: 8, y: 4)
    }
}

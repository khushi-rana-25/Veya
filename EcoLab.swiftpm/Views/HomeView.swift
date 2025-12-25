import SwiftUI

struct HomeView: View {
    
    @State private var symptomsData: [Symptom] = PregnancySymptoms.allSymptoms
    @State private var searchText: String = ""
    
    private let iconColors: [Color] = [.yellow, .blue, .indigo, .pink, .orange, .mint]
    
    var body: some View {
        TabView {
            // Tab 1: Guide
            NavigationStack {
                symptomList
                    .navigationTitle("Symptoms Guide")
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            Menu {
                                Button("Sort A–Z") {
                                    sortSymptoms()
                                }
                                Button("No Order") {
                                    sortRandomly()
                                }
                            } label: {
                                Image(systemName: "line.3.horizontal.decrease.circle")
                            }
                            .accessibilityLabel("Sorting options")
                        }
                        ToolbarItem(placement: .topBarTrailing) {
                            NavigationLink(destination: LogSymptomView()) {
                                Image(systemName: "plus")
                            }
                            .accessibilityLabel("Log symptom")
                        }
                    }
            }
            .searchable(text: $searchText, placement: .navigationBarDrawer, prompt: "Search symptoms")
            .tabItem {
                Image(systemName: "list.bullet.clipboard")
                Text("Guide")
            }
            
            // Tab 2: Journal
            NavigationStack {
                LogSymptomView()
                    .navigationTitle("Journal")
            }
            .tabItem {
                Image(systemName: "arrow.2.squarepath")
                Text("Journal")
            }
        }
        .accentColor(.primary)
    }
    
    private var symptomList: some View {
        List {
            ForEach(searchResults) { symptom in
                let color = colorForSymptom(symptom)
                
                NavigationLink(destination: SymptomDetailView(symptom: symptom, color: color)) {
                    SymptomRowView(symptomName: symptom.name, symptomIcon: symptom.icon, iconColor: color)
                }
                .alignmentGuide(.listRowSeparatorLeading) { _ in 0 }
            }
        }
        .listStyle(.insetGrouped)
    }
    
    private var searchResults: [Symptom] {
        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        guard !query.isEmpty else { return symptomsData }
        return symptomsData.filter { $0.name.lowercased().contains(query) }
    }
    
    private func sortSymptoms() {
        withAnimation {
            symptomsData.sort { $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending }
        }
    }
    
    private func sortRandomly() {
        withAnimation {
            symptomsData.shuffle()
        }
    }
    
    private func colorForSymptom(_ symptom: Symptom) -> Color {
        let idx = abs(symptom.id.hashValue) % iconColors.count
        return iconColors[idx]
    }
}

struct SymptomRowView: View {
    let symptomName: String
    let symptomIcon: String
    let iconColor: Color
    
    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: symptomIcon)
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
                .foregroundStyle(iconColor)
                .padding(10)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(iconColor.opacity(0.1))
                )
                .accessibilityHidden(true)
            
            Text(symptomName)
                .font(.headline)
                .fontWeight(.regular)
                .foregroundStyle(.primary)
                .lineLimit(1)
                .minimumScaleFactor(0.9)
            
            Spacer()
        }
        .padding(10)
        .contentShape(Rectangle())
        .accessibilityElement(children: .combine)
        .accessibilityLabel(symptomName)
    }
}

#Preview{
    HomeView()
}

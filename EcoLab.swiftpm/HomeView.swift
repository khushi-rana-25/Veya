import SwiftUI

struct HomeView: View {
    
    @State private var symptomsData: [Symptom] = PregnancySymptoms.allSymptoms
    let iconColors: [Color] = [.yellow, .blue, .indigo, .pink, .orange, .mint]
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationStack{
            VStack{
                List{
                    ForEach(Array(searchResults.enumerated()), id: \.element.id) { index, symptom in
                        let iconColor = self.iconColors[index % iconColors.count]
                        
                        NavigationLink(destination: SymptomDetailView(symptom: symptom, color: iconColor)) {
                            SymptomRowView(symptomName: symptom.name, symptomIcon: symptom.icon, iconColor: iconColor)
                        }
                        .alignmentGuide(.listRowSeparatorLeading) { _ in 0 }
                    }
                }
            }
            .navigationTitle("Symptoms Guide")
            .toolbar{
                ToolbarItem(placement: .topBarTrailing) {
                    Menu{
                        Button("Sort A-Z") {
                            sortSymptoms()
                        }
                        Button("No Order"){
                            sortRandomly()
                        }
                    }
                    label: {
                        Image(systemName: "line.3.horizontal.decrease.circle")
                    }
                }
            }
        }
        .searchable(text: $searchText, placement: .navigationBarDrawer, prompt: "Search symptoms")
    }
    
    var searchResults: [Symptom] {
        if searchText.isEmpty {
            return symptomsData
        }
        else{
            return symptomsData.filter {
                $0.name.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    func sortSymptoms() {
        symptomsData = symptomsData.sorted { $0.name < $1.name }
    }
        
    func sortRandomly() {
        withAnimation {
            symptomsData.shuffle()
        }
    }
}

struct SymptomRowView: View {
    let symptomName: String
    let symptomIcon: String
    let iconColor: Color
    
    var body: some View {
        HStack(spacing: 20){
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
            
            Text(symptomName)
                .font(.headline)
                .fontWeight(.regular)
            
            Spacer()
        }
        .padding(10)
    }
}

#Preview{
    HomeView()
}

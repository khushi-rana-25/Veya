import SwiftUI

struct HomeView: View {
    
    let symptomsData: [Symptom] = PregnancySymptoms.allSymptoms
    let iconColors: [Color] = [.yellow, .blue, .indigo, .pink, .orange, .mint]
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationStack{
            VStack{
                List{
                    ForEach(Array(symptomsData.enumerated()), id: \.element.id) { index, symptom in
                        let iconColor = self.iconColors[index % iconColors.count]
                        
                        NavigationLink(destination: Text(symptom.name)) {
                            SymptomRowView(symptomName: symptom.name, symptomIcon: symptom.icon, iconColor: iconColor)
                        }
                        .alignmentGuide(.listRowSeparatorLeading) { _ in 0 }
                    }
                }
            }
            .navigationTitle("Symptoms Guide")
        }
        .searchable(text: $searchText, placement: .navigationBarDrawer, prompt: "Search symptoms")
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

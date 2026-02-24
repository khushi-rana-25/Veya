import SwiftUI

struct HomeView: View {
    @AppStorage("userName") private var userName = ""
    @AppStorage("dueDate") private var dueDateStorage = Date().timeIntervalSince1970
    
    @State private var searchText: String = ""
    @State private var isLogging: Bool = false
    @State private var viewModel: HomeViewModel = HomeViewModel()
    let cream = Color(red: 1.0, green: 0.97, blue: 0.96)
    let rose = Color(red: 0.85, green: 0.45, blue: 0.38)
    let teal = Color(red: 0.49, green: 0.77, blue: 0.72)
    
    var dueDate: Date { Date(timeIntervalSince1970: dueDateStorage) }
    
    var daysRemaining: Int {
        max(0, Calendar.current.dateComponents([.day], from: Date(), to: dueDate).day ?? 0)
    }
    var weekNumber: Int { max(1, min(40, (280 - daysRemaining) / 7)) }
    var trimester: String {
        weekNumber <= 13 ? "1st Trimester" : weekNumber <= 27 ? "2nd Trimester" : "3rd Trimester"
    }
    var greeting: String {
        let hour = Calendar.current.component(.hour, from: Date())
        if hour < 12 { return "Good morning" }
        else if hour < 17 { return "Good afternoon" }
        else { return "Good evening" }
    }
    
    var body: some View {
        TabView {
            NavigationStack {
                ZStack {
                    cream.ignoresSafeArea()
                    
                    ScrollView {
                        VStack(spacing: 0) {
                            heroCard
                                .padding(.horizontal, 16)
                                .padding(.top, 8)
                                .padding(.bottom, 20)
                            
                            symptomList
                        }
                    }
                }
                .navigationTitle("")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Menu {
                            Button("Sort A–Z") { viewModel.sortSymptoms() }
                            Button("No Order") { viewModel.sortRandomly() }
                        } label: {
                            Image(systemName: "line.3.horizontal.decrease.circle")
                                .foregroundStyle(teal)
                        }
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                                isLogging.toggle()
                            }
                        } label: {
                            Image(systemName: isLogging ? "xmark.circle.fill" : "plus.circle.fill")
                                .font(.title3)
                                .foregroundStyle(isLogging ? .secondary : teal)
                        }
                    }
                }
            }
            .tabItem {
                Image(systemName: "list.bullet.clipboard")
                Text("Guide")
            }
            NavigationStack {
                SymptomsHistoryView()
                    .navigationTitle("History")
            }
            .tabItem {
                Image(systemName: "arrow.2.squarepath")
                Text("History")
            }
        }
        .tint(teal)
    }
    
    // MARK: — Hero Card
    private var heroCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("\(greeting), \(userName)")
                        .font(.system(size: 22, weight: .bold, design: .rounded))
                        .foregroundStyle(.white)
                    Text("Week \(weekNumber) · \(trimester)")
                        .font(.system(size: 14, weight: .medium, design: .rounded))
                        .foregroundStyle(.white.opacity(0.85))
                }
                Spacer()
                ZStack {
                    Circle()
                        .fill(.white.opacity(0.2))
                        .frame(width: 52, height: 52)
                    Image(systemName: "figure.and.child.holdinghands")
                        .font(.system(size: 24))
                        .foregroundStyle(.white)
                }
            }
            
            Divider()
                .background(.white.opacity(0.3))
            HStack(spacing: 0) {
                statItem(value: "\(daysRemaining)", label: "Days Left", color: .white)
                Divider()
                    .frame(height: 36)
                    .background(.white.opacity(0.3))
                statItem(value: "\(weekNumber)", label: "Week", color: .white)
                Divider()
                    .frame(height: 36)
                    .background(.white.opacity(0.3))
                statItem(value: "40", label: "Total Weeks", color: .white)
            }
            VStack(alignment: .leading, spacing: 6) {
                Text("Pregnancy Progress")
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundStyle(.white.opacity(0.8))
                
                GeometryReader { geo in
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 4)
                            .fill(.white.opacity(0.25))
                            .frame(height: 6)
                        RoundedRectangle(cornerRadius: 4)
                            .fill(.white)
                            .frame(width: geo.size.width * min(CGFloat(weekNumber) / 40.0, 1.0), height: 6)
                    }
                }
                .frame(height: 6)
            }
        }
        .padding(20)
        .background(
            LinearGradient(
                colors: [rose, rose.opacity(0.75)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .shadow(color: rose.opacity(0.35), radius: 12, y: 6)
    }
    
    private func statItem(value: String, label: String, color: Color) -> some View {
        VStack(spacing: 2) {
            Text(value)
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .foregroundStyle(color)
            Text(label)
                .font(.system(size: 11, weight: .medium))
                .foregroundStyle(color.opacity(0.8))
        }
        .frame(maxWidth: .infinity)
    }
    
    // MARK: — Symptom List
    private var symptomList: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text(isLogging ? "Select a symptom to log" : "Symptoms Guide")
                    .font(.system(size: 17, weight: .semibold, design: .rounded))
                    .foregroundStyle(Color(red: 0.18, green: 0.18, blue: 0.18))
                Spacer()
                Text("\(searchResults.count) symptoms")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundStyle(.secondary)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 12)
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(.secondary)
                TextField("Search symptoms", text: $searchText)
                    .font(.system(size: 16, design: .rounded))
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 11)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 14))
            .shadow(color: .black.opacity(0.04), radius: 4, y: 2)
            .padding(.horizontal, 16)
            .padding(.bottom, 12)
            LazyVStack(spacing: 10) {
                ForEach(searchResults, id: \.id) { symptom in
                    let color = viewModel.colorForSymptom(symptom)
                    NavigationLink {
                        if isLogging {
                            LogSymptomView(symptom: symptom, color: color)
                                .onDisappear {
                                    isLogging = false
                                }
                        } else {
                            SymptomDetailView(symptom: symptom, color: color)
                        }
                    } label: {
                        SymptomRowView(symptomName: symptom.name, symptomIcon: symptom.icon, iconColor: color, isLogging: isLogging)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 20)
        }
    }
    
    private var searchResults: [Symptom] {
        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        guard !query.isEmpty else { return viewModel.symptomsData }
        return viewModel.symptomsData.filter { $0.name.lowercased().contains(query) }
    }
}

// MARK: — Symptom Row Card 
struct SymptomRowView: View {
    let symptomName: String
    let symptomIcon: String
    let iconColor: Color
    var isLogging: Bool
    
    let cream = Color(red: 1.0, green: 0.97, blue: 0.96)
    
    var body: some View {
        HStack(spacing: 14) {
            if isLogging {
                Image(systemName: "plus.circle.fill")
                    .font(.title2)
                    .foregroundStyle(Color(red: 0.85, green: 0.45, blue: 0.38))
                    .transition(.move(edge: .leading).combined(with: .opacity))
            }
            
            Image(systemName: symptomIcon)
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
                .foregroundStyle(iconColor)
                .padding(12)
                .background(iconColor.opacity(0.12))
                .clipShape(RoundedRectangle(cornerRadius: 12))
            
            Text(symptomName)
                .font(.system(size: 16, weight: .medium, design: .rounded))
                .foregroundStyle(Color(red: 0.18, green: 0.18, blue: 0.18))
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.system(size: 12, weight: .semibold))
                .foregroundStyle(Color.secondary.opacity(0.5))
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: .black.opacity(0.04), radius: 4, y: 2)
        .animation(.spring(response: 0.4, dampingFraction: 0.7), value: isLogging)
    }
}

#Preview {
    HomeView()
}

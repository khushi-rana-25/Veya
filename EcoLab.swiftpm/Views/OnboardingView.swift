import SwiftUI

struct OnboardingView: View {
    @AppStorage("hasOnboarded") private var hasOnboarded = false
    @AppStorage("userName") private var userName = ""
    @AppStorage("dueDate") private var dueDateStorage = Date().timeIntervalSince1970
    
    @State private var nameInput = ""
    @State private var dueDate = Calendar.current.date(byAdding: .day, value: 180, to: Date()) ?? Date()
    @State private var animateIn = false
    
    let cream = Color(red: 1.0, green: 0.97, blue: 0.96)
    let rose = Color(red: 0.91, green: 0.65, blue: 0.59)
    let teal = Color(red: 0.49, green: 0.77, blue: 0.72)
    
    var body: some View {
        ZStack {
            cream.ignoresSafeArea()
            
            VStack(spacing: 0) {
                Spacer()
                ZStack {
                    Circle()
                        .fill(rose.opacity(0.15))
                        .frame(width: 120, height: 120)
                    Circle()
                        .fill(rose.opacity(0.1))
                        .frame(width: 90, height: 90)
                    Image(systemName: "figure.and.child.holdinghands")
                        .font(.system(size: 44))
                        .foregroundStyle(rose)
                }
                .scaleEffect(animateIn ? 1 : 0.7)
                .opacity(animateIn ? 1 : 0)
                
                Spacer().frame(height: 32)
                VStack(spacing: 8) {
                    Text("Welcome to Bloom")
                        .font(.system(size: 32, weight: .bold, design: .rounded))
                        .foregroundStyle(Color(red: 0.18, green: 0.18, blue: 0.18))
                    
                    Text("Your pregnancy companion")
                        .font(.system(size: 16, weight: .regular, design: .rounded))
                        .foregroundStyle(.secondary)
                }
                .offset(y: animateIn ? 0 : 20)
                .opacity(animateIn ? 1 : 0)
                
                Spacer().frame(height: 48)
                VStack(spacing: 24) {
                    VStack(alignment: .leading, spacing: 8) {
                        Label("Your first name", systemImage: "person.fill")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundStyle(teal)
                        
                        TextField("e.g. Sarah", text: $nameInput)
                            .font(.system(size: 17, design: .rounded))
                            .padding(.horizontal, 16)
                            .padding(.vertical, 14)
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 14))
                            .shadow(color: .black.opacity(0.05), radius: 4, y: 2)
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Label("Due date", systemImage: "calendar.heart.fill")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundStyle(rose)
                        
                        DatePicker("", selection: $dueDate, in: Date()..., displayedComponents: .date)
                            .datePickerStyle(.compact)
                            .labelsHidden()
                            .padding(.horizontal, 16)
                            .padding(.vertical, 12)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 14))
                            .shadow(color: .black.opacity(0.05), radius: 4, y: 2)
                    }
                    pregnancyPreviewCard
                }
                .padding(.horizontal, 28)
                .offset(y: animateIn ? 0 : 30)
                .opacity(animateIn ? 1 : 0)
                
                Spacer().frame(height: 40)
    
                Button {
                    guard !nameInput.trimmingCharacters(in: .whitespaces).isEmpty else { return }
                    userName = nameInput.trimmingCharacters(in: .whitespaces)
                    dueDateStorage = dueDate.timeIntervalSince1970
                    withAnimation(.spring()) {
                        hasOnboarded = true
                    }
                } label: {
                    Text("Begin My Journey")
                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 18)
                        .background(
                            nameInput.trimmingCharacters(in: .whitespaces).isEmpty
                            ? AnyShapeStyle(Color.gray.opacity(0.3))
                            : AnyShapeStyle(LinearGradient(
                                colors: [Color(red: 0.85, green: 0.45, blue: 0.38), Color(red: 0.78, green: 0.35, blue: 0.30)],
                                startPoint: .leading,
                                endPoint: .trailing
                            ))
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 18))
                        .shadow(color: Color(red: 0.85, green: 0.45, blue: 0.38).opacity(0.5), radius: 10, y: 4)
                }
                .disabled(nameInput.trimmingCharacters(in: .whitespaces).isEmpty)
                .padding(.horizontal, 28)
                .offset(y: animateIn ? 0 : 20)
                .opacity(animateIn ? 1 : 0)
                
                Spacer()
            }
        }
        .onAppear {
            withAnimation(.spring(response: 0.7, dampingFraction: 0.75).delay(0.2)) {
                animateIn = true
            }
        }
    }
    
    private var pregnancyPreviewCard: some View {
        let today = Date()
        let totalDays = 280
        let daysRemaining = max(0, Calendar.current.dateComponents([.day], from: today, to: dueDate).day ?? 0)
        let weekNumber = max(1, min(40, (totalDays - daysRemaining) / 7))
        let trimester = weekNumber <= 13 ? "1st Trimester" : weekNumber <= 26 ? "2nd Trimester" : "3rd Trimester"
        let trimesterColor = weekNumber <= 13 ? teal : weekNumber <= 26 ? rose : Color.purple.opacity(0.7)
        
        return HStack(spacing: 16) {
            VStack(spacing: 4) {
                Text("Week")
                    .font(.system(size: 11, weight: .medium))
                    .foregroundStyle(.secondary)
                Text("\(weekNumber)")
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .foregroundStyle(teal)
            }
            
            Divider().frame(height: 40)
            
            VStack(spacing: 4) {
                Text("Trimester")
                    .font(.system(size: 11, weight: .medium))
                    .foregroundStyle(.secondary)
                Text(trimester)
                    .font(.system(size: 15, weight: .semibold, design: .rounded))
                    .foregroundStyle(trimesterColor)
            }
            
            Spacer()
            
            VStack(spacing: 4) {
                Text("Days left")
                    .font(.system(size: 11, weight: .medium))
                    .foregroundStyle(.secondary)
                Text("\(daysRemaining)")
                    .font(.system(size: 22, weight: .bold, design: .rounded))
                    .foregroundStyle(rose)
            }
        }
        .padding(16)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 14))
        .shadow(color: .black.opacity(0.05), radius: 4, y: 2)
    }
}

#Preview {
    OnboardingView()
}

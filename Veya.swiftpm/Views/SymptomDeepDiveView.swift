import SwiftUI

struct SymptomDeepDiveView: View {
    let loggedSymptom: String
    var onComplete: (() -> Void)? = nil

    private let themeCoral = Color(red: 0.85, green: 0.45, blue: 0.38)
    private let themeCream = Color(red: 1.0, green: 0.97, blue: 0.96)
    private let textPrimary = Color(red: 0.18, green: 0.18, blue: 0.18)

    @State private var secondarySymptoms: Set<String> = []
    @State private var daysActive: Int = 1
    @Environment(\.dismiss) var dismiss

    private var entry: SymptomDeepDiveEntry { DeepDiveData.entry(for: loggedSymptom) }

    var body: some View {
        ZStack(alignment: .topLeading) {
            themeCream.ignoresSafeArea()

            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 24) {
                    headerSection
                    companionSection
                    durationSection
                    insightSection
                    doneButton
                }
                .padding(.horizontal, 24)
                .padding(.top, 16)
                .padding(.bottom, 40)
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(textPrimary)
                        .padding(10)
                        .background(.white.opacity(0.9))
                        .clipShape(Circle())
                        .shadow(color: .black.opacity(0.08), radius: 4, y: 2)
                }
                .accessibilityLabel("Back")
                .accessibilityHint("Returns to previous screen")
            }
        }
    }

    // MARK: - Header

    private var headerSection: some View {
        VStack(spacing: 12) {
            ZStack {
                Circle()
                    .fill(themeCoral.opacity(0.1))
                    .frame(width: 64, height: 64)
                Image(systemName: "heart.text.square.fill")
                    .font(.system(size: 30))
                    .foregroundStyle(themeCoral)
            }

            Text("Let's look closer…")
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .foregroundStyle(textPrimary)

            Text("Sometimes \(loggedSymptom.lowercased()) brings friends along.\nAre you feeling any of these too?")
                .font(.system(size: 15, weight: .regular, design: .rounded))
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .lineSpacing(4)
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("Let's look closer. Sometimes \(loggedSymptom.lowercased()) brings friends along. Are you feeling any of these too?")
        .accessibilityAddTraits(.isHeader)
    }

    // MARK: - Companion Chips

    private var companionSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Label("Common companions", systemImage: "person.2.fill")
                .font(.system(size: 13, weight: .bold, design: .rounded))
                .foregroundStyle(themeCoral)

            let columns = [GridItem(.adaptive(minimum: 130), spacing: 10)]
            LazyVGrid(columns: columns, alignment: .leading, spacing: 10) {
                ForEach(entry.companions, id: \.self) { item in
                    Button {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.65)) {
                            if secondarySymptoms.contains(item) {
                                secondarySymptoms.remove(item)
                            } else {
                                secondarySymptoms.insert(item)
                            }
                        }
                    } label: {
                        HStack(spacing: 6) {
                            Image(systemName: secondarySymptoms.contains(item) ? "checkmark.circle.fill" : "circle")
                                .font(.system(size: 14))
                            Text(item)
                                .font(.system(size: 14, weight: .medium, design: .rounded))
                        }
                        .padding(.horizontal, 14)
                        .padding(.vertical, 10)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(secondarySymptoms.contains(item) ? themeCoral : Color.white)
                        .foregroundStyle(secondarySymptoms.contains(item) ? .white : textPrimary)
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                        .shadow(color: .black.opacity(secondarySymptoms.contains(item) ? 0 : 0.04), radius: 6, y: 3)
                    }
                    .buttonStyle(.plain)
                    .accessibilityLabel("\(item), \(secondarySymptoms.contains(item) ? "selected" : "not selected")")
                    .accessibilityHint("Double tap to \(secondarySymptoms.contains(item) ? "deselect" : "select") this companion symptom")
                    .accessibilityAddTraits(secondarySymptoms.contains(item) ? [.isButton, .isSelected] : .isButton)
                }
            }
        }
        .padding(20)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: .black.opacity(0.05), radius: 12, y: 4)
        .accessibilityElement(children: .contain)
        .accessibilityLabel("Common companion symptoms")
    }

    // MARK: - Duration Picker

    private var durationSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Label("How many days has this been visiting?", systemImage: "calendar")
                .font(.system(size: 13, weight: .bold, design: .rounded))
                .foregroundStyle(themeCoral)

            HStack(spacing: 0) {
                ForEach(1...7, id: \.self) { day in
                    Button {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                            daysActive = day
                        }
                    } label: {
                        VStack(spacing: 4) {
                            Text("\(day)")
                                .font(.system(size: 16, weight: daysActive == day ? .black : .regular, design: .rounded))
                                .foregroundStyle(daysActive == day ? .white : textPrimary)
                                .frame(width: 36, height: 36)
                                .background(daysActive == day ? themeCoral : Color.clear)
                                .clipShape(Circle())
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.plain)
                    .accessibilityLabel("Day \(day)")
                    .accessibilityValue(daysActive == day ? "Selected" : "")
                    .accessibilityHint("Double tap to set duration to \(day) days")
                    .accessibilityAddTraits(daysActive == day ? [.isButton, .isSelected] : .isButton)
                }
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 10)
        }
        .padding(20)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: .black.opacity(0.05), radius: 12, y: 4)
        .accessibilityElement(children: .contain)
        .accessibilityLabel("How many days has this been visiting?")
    }

    // MARK: - Insight Card

    private var insightSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 6) {
                Image(systemName: "sparkles")
                    .font(.system(size: 12, weight: .black))
                Text("INSIGHT")
                    .font(.system(size: 12, weight: .black, design: .rounded))
                    .tracking(0.8)
            }
            .foregroundStyle(themeCoral)

            Text(insightText)
                .font(.system(size: 14, weight: .regular, design: .rounded))
                .foregroundStyle(textPrimary)
                .lineSpacing(5)
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(themeCoral.opacity(0.08))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .animation(.spring(response: 0.4, dampingFraction: 0.8), value: daysActive)
        .animation(.spring(response: 0.4, dampingFraction: 0.8), value: secondarySymptoms)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("Insight. \(insightText)")
        .accessibilityAddTraits(.isStaticText)
    }

    // MARK: - Done Button

    private var doneButton: some View {
        Button {
            if let onComplete {
                onComplete()
            }
            
            dismiss()
            
        } label: {
            Text("Thanks for sharing  ✨")
                .font(.system(.headline, design: .rounded))
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(themeCoral)
                .clipShape(RoundedRectangle(cornerRadius: 18))
                .shadow(color: themeCoral.opacity(0.35), radius: 10, y: 5)
        }
        .buttonStyle(.plain)
        .accessibilityLabel("Thanks for sharing")
        .accessibilityHint("Finishes and returns to guide")
    }

    // MARK: - Insight Logic

    private var insightText: String {
        if daysActive >= 4 {
            return entry.persistentInsight
        } else if !secondarySymptoms.isEmpty {
            return entry.companionInsight
        } else {
            return entry.shortInsight
        }
    }
}

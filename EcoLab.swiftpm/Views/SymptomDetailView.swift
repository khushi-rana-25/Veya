import SwiftUI

struct SymptomDetailView: View {
    @Environment(\.dismiss) private var dismiss
    let symptom: Symptom
    let color: Color

    private let themeCoral = Color(red: 0.85, green: 0.45, blue: 0.38)
    private let themeCream = Color(red: 1.0, green: 0.97, blue: 0.96)
    private let cardWhite = Color.white
    private let textPrimary = Color(red: 0.13, green: 0.13, blue: 0.15)
    private let textMuted = Color(red: 0.52, green: 0.52, blue: 0.55)

    var body: some View {
        ZStack(alignment: .top) {
            themeCream.ignoresSafeArea()

            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 0) {
                    heroSection
                        .padding(.bottom, 24)

                    VStack(spacing: 16) {
                        overviewCard
                        remediesCard
                        whenToCallCard
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 100)
                }
            }
            .ignoresSafeArea(edges: .top)

            // Floating back button
            HStack {
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 15, weight: .bold))
                        .foregroundStyle(.white)
                        .frame(width: 38, height: 38)
                        .background(.ultraThinMaterial.opacity(0.3))
                        .background(Color.white.opacity(0.25))
                        .clipShape(Circle())
                }
                .padding(.leading, 20)
                .padding(.top, 56)
                .accessibilityLabel("Back")
                .accessibilityHint("Returns to symptom list")
                Spacer()
            }
        }
        .navigationBarBackButtonHidden(true)
    }

    // MARK: - Hero Section (large top banner)

    private var heroSection: some View {
        ZStack(alignment: .bottomTrailing) {
            themeCoral
                .frame(maxWidth: .infinity)
                .frame(height: 300)
                .overlay(
                    ZStack {
                        Circle()
                            .fill(Color.white.opacity(0.08))
                            .frame(width: 220, height: 220)
                            .offset(x: -80, y: -30)
                        Circle()
                            .fill(Color.white.opacity(0.06))
                            .frame(width: 150, height: 150)
                            .offset(x: -110, y: 50)
                        Circle()
                            .fill(Color.white.opacity(0.05))
                            .frame(width: 90, height: 90)
                            .offset(x: 60, y: -70)
                    }
                )
                .ignoresSafeArea(edges: .top)
            
            VStack(alignment: .trailing, spacing: 12) {
                ZStack {
                    RoundedRectangle(cornerRadius: 18)
                        .fill(Color.white.opacity(0.22))
                        .frame(width: 64, height: 64)
                    Image(systemName: symptom.icon)
                        .font(.system(size: 28, weight: .medium))
                        .foregroundStyle(.white)
                }

                Text(symptom.name)
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.trailing)

                HStack(spacing: 8) {
                    ForEach(symptom.trimesters, id: \.self) { trimester in
                        Text(trimester)
                            .font(.system(size: 11, weight: .semibold, design: .rounded))
                            .foregroundStyle(.white)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color.white.opacity(0.22))
                            .clipShape(Capsule())
                    }
                }
            }
            .padding(.trailing, 24)
            .padding(.bottom, 28)
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(symptom.name). Relevant for \(symptom.trimesters.joined(separator: ", ")).")
        .accessibilityAddTraits(.isHeader)
        .clipShape(
            UnevenRoundedRectangle(
                topLeadingRadius: 0,
                bottomLeadingRadius: 32,
                bottomTrailingRadius: 32,
                topTrailingRadius: 0
            )
        )
        .shadow(color: themeCoral.opacity(0.35), radius: 20, y: 10)
    }

    // MARK: - Overview Card

    private var overviewCard: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Header
            HStack(spacing: 8) {
                Image(systemName: "doc.text.fill")
                    .font(.system(size: 13))
                    .foregroundStyle(themeCoral)
                Text("Overview")
                    .font(.system(size: 13, weight: .bold, design: .rounded))
                    .foregroundStyle(themeCoral)
                    .textCase(.uppercase)
                    .tracking(0.5)
                Spacer()
            }
            .padding(.bottom, 14)
            .accessibilityHidden(true)

            Divider()
                .padding(.bottom, 16)
                .accessibilityHidden(true)

            Text(symptom.whatIsIt)
                .font(.system(size: 16, weight: .semibold, design: .rounded))
                .foregroundStyle(textPrimary)
                .lineSpacing(4)
                .padding(.bottom, 10)

            Text(symptom.description)
                .font(.system(size: 14, weight: .regular, design: .rounded))
                .foregroundStyle(textMuted)
                .lineSpacing(5)
        }
        .padding(20)
        .background(cardWhite)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: Color.black.opacity(0.05), radius: 12, y: 4)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("Overview. \(symptom.whatIsIt). \(symptom.description)")
        .accessibilityAddTraits(.isHeader)
    }

    // MARK: - Remedies Card

    private var remediesCard: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Header
            HStack(spacing: 8) {
                Image(systemName: "sparkles")
                    .font(.system(size: 13))
                    .foregroundStyle(themeCoral)
                Text("Remedies & Tips")
                    .font(.system(size: 13, weight: .bold, design: .rounded))
                    .foregroundStyle(themeCoral)
                    .textCase(.uppercase)
                    .tracking(0.5)
                Spacer()
                Text("\(symptom.remedies.count) tips")
                    .font(.system(size: 12, weight: .medium, design: .rounded))
                    .foregroundStyle(textMuted)
            }
            .padding(.bottom, 14)

            Divider()
                .padding(.bottom, 4)

            ForEach(Array(symptom.remedies.enumerated()), id: \.offset) { index, remedy in
                HStack(alignment: .center, spacing: 14) {
                    // Number
                    Text("\(index + 1)")
                        .font(.system(size: 12, weight: .bold, design: .rounded))
                        .foregroundStyle(themeCoral)
                        .frame(width: 28, height: 28)
                        .background(themeCoral.opacity(0.12))
                        .clipShape(Circle())

                    Text(remedy)
                        .font(.system(size: 14, weight: .medium, design: .rounded))
                        .foregroundStyle(textPrimary)
                        .fixedSize(horizontal: false, vertical: true)

                    Spacer()
                }
                .padding(.vertical, 12)

                if index < symptom.remedies.count - 1 {
                    Divider()
                        .padding(.leading, 42)
                        .accessibilityHidden(true)
                }
            }
        }
        .padding(20)
        .background(cardWhite)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: Color.black.opacity(0.05), radius: 12, y: 4)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("Remedies and tips. \(symptom.remedies.enumerated().map { "\($0.offset + 1): \($0.element)" }.joined(separator: ". "))")
        .accessibilityAddTraits(.isHeader)
    }

    // MARK: - When to Call Doctor Card

    private var whenToCallCard: some View {
        HStack(alignment: .top, spacing: 14) {
            ZStack {
                Circle()
                    .fill(Color.red.opacity(0.12))
                    .frame(width: 42, height: 42)
                Image(systemName: "exclamationmark.triangle.fill")
                    .font(.system(size: 18))
                    .foregroundStyle(Color.red)
            }

            VStack(alignment: .leading, spacing: 6) {
                Text("When to Call Your Doctor")
                    .font(.system(size: 13, weight: .bold, design: .rounded))
                    .foregroundStyle(Color(red: 0.75, green: 0.18, blue: 0.18))
                    .textCase(.uppercase)
                    .tracking(0.5)

                Text(symptom.whenToCallDoctor)
                    .font(.system(size: 14, weight: .regular, design: .rounded))
                    .foregroundStyle(Color(red: 0.6, green: 0.15, blue: 0.15))
                    .lineSpacing(4)
            }
        }
        .padding(18)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.red.opacity(0.07))
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.red.opacity(0.18), lineWidth: 1)
                )
        )
        .shadow(color: Color.red.opacity(0.06), radius: 10, y: 4)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("When to call your doctor. \(symptom.whenToCallDoctor)")
        .accessibilityAddTraits(.isHeader)
    }
}

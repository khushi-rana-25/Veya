import SwiftUI
import SwiftData

enum SymptomMode: String {
    case mild = "Mild"
    case moderate = "Moderate"
    case severe = "Severe"
}

struct LogSymptomView: View {
    let symptom: Symptom
    let color: Color
    @State private var isPulsing: Bool = false
    @State private var showDeepDive: Bool = false
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) private var dismiss
    @State var logViewModel: LogSymptomViewModel
    @State var viewModel = ViewModel()

    private let themeCream = Color(red: 1.0, green: 0.97, blue: 0.96)

    init(symptom: Symptom, color: Color) {
        self.symptom = symptom
        self.color = color
        _logViewModel = State(initialValue: LogSymptomViewModel(color: color))
    }

    var body: some View {
        ZStack {
            themeCream.ignoresSafeArea()

            VStack {
                topView
                Spacer()
                pulseView
                Spacer()
                bottomView
            }
            .padding()
        }
        .sheet(isPresented: $showDeepDive, onDismiss: {
            dismiss()
        }) {
            SymptomDeepDiveView(loggedSymptom: symptom.name)
                .presentationDetents([.large])
                .presentationCornerRadius(32)
                .presentationDragIndicator(.visible)
        }
    }

    var topView: some View {
        VStack {
            Text("How is your \(symptom.name)?")
                .foregroundStyle(.primary)
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top, 50)
                .multilineTextAlignment(.center)

            Text("Drag the slider to match your feeling")
                .foregroundStyle(.secondary)
                .font(.headline)
                .padding()
        }
    }

    var pulseView: some View {
        ZStack {
            Circle()
                .fill(logViewModel.activeColor)
                .frame(width: 150, height: 150)
                .blur(radius: 50)
                .opacity(0.6)
                .scaleEffect(isPulsing ? 1.3 + (logViewModel.sliderValue * 0.5) : 1.0)

            Image(systemName: symptom.icon)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundStyle(logViewModel.activeColor)
                .scaleEffect(isPulsing ? 1.3 : 1.0)
        }
        .onAppear {
            withAnimation(.easeInOut(duration: logViewModel.animationDuration).repeatForever(autoreverses: true)) {
                isPulsing = true
            }
        }
    }

    var bottomView: some View {
        VStack {
            Text(logViewModel.currentMode.rawValue)
                .font(.system(.headline, design: .rounded))
                .foregroundStyle(logViewModel.currentMode == .mild ? .green : (logViewModel.currentMode == .moderate ? .yellow : .red))

            Slider(value: $logViewModel.sliderValue, in: 0...1)
                .tint(logViewModel.activeColor)
            HStack {
                Text("Mild")
                Spacer()
                Text("Severe")
            }
            .font(.caption)
            .foregroundStyle(.secondary)

            Button {
                viewModel.addLog(symptomName: symptom.name, severity: logViewModel.currentMode.rawValue, context: modelContext)
                showDeepDive = true
            } label: {
                Text("Log Symptom")
                    .padding()
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .background(logViewModel.activeColor.gradient)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 18))
                    .padding()
            }
        }
    }
}

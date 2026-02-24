import SwiftUI

struct AppRootView: View {
    @AppStorage("hasOnboarded") private var hasOnboarded = false

    var body: some View {
        if hasOnboarded {
            HomeView()
                .accessibilityLabel("Veya, main screen")
        } else {
            OnboardingView()
                .accessibilityLabel("Veya, welcome and setup")
        }
    }
}

#Preview {
   AppRootView()
}

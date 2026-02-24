import SwiftUI

struct AppRootView: View {
    @AppStorage("hasOnboarded") private var hasOnboarded = false
    
    var body: some View {
        if hasOnboarded {
            HomeView()
        } else {
            OnboardingView()
        }
    }
}

#Preview {
   AppRootView()
}

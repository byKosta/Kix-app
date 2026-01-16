import SwiftUI

struct AuthRouterView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        if appState.isAuthenticated {
            MainTabView()
        } else {
            LoginView()
        }
    }
}

#Preview {
    AuthRouterView()
        .environmentObject(AppState())
        .environmentObject(AuthViewModel())
}

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
    // Preview excludes FavoritesManager due to duplicate type definitions causing ambiguous init().
    // To re-enable, deduplicate FavoritesManager.swift files in the project and then add:
    // .environmentObject(FavoritesManager())
    AuthRouterView()
        .environmentObject(AppState())
        .environmentObject(AuthViewModel())
}

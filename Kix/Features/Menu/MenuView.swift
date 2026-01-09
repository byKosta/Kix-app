import SwiftUI

struct MenuUser {
    var username: String
    var email: String
}

struct MenuView: View {
    @EnvironmentObject var appState: AppState
    @State private var isDarkMode: Bool = false
    @State private var showLogoutAlert: Bool = false
    var user: MenuUser = MenuUser(username: "JohnDoe", email: "john.doe@example.com")

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Profile")) {
                    HStack {
                        Image(systemName: "person.crop.circle")
                            .resizable()
                            .frame(width: 48, height: 48)
                            .foregroundColor(.accentGreen)
                        VStack(alignment: .leading) {
                            Text(user.username)
                                .font(.headline)
                            Text(user.email)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                Section(header: Text("Settings")) {
                    Toggle(isOn: $isDarkMode) {
                        Text("Dark Mode")
                    }
                    .accessibilityIdentifier("dark_mode_toggle")
                }
                Section {
                    Button(action: {
                        showLogoutAlert = true
                    }) {
                        HStack {
                            Image(systemName: "rectangle.portrait.and.arrow.right")
                            Text("Logout")
                        }
                        .foregroundColor(.red)
                    }
                    .accessibilityIdentifier("logout_button")
                    .alert(isPresented: $showLogoutAlert) {
                        Alert(
                            title: Text("Logout"),
                            message: Text("Are you sure you want to logout?"),
                            primaryButton: .destructive(Text("Logout")) {
                                appState.isAuthenticated = false
                            },
                            secondaryButton: .cancel()
                        )
                    }
                }
            }
            .navigationTitle("Menu")
        }
    }
}

#Preview {
    MenuView()
        .environmentObject(AppState())
}

import SwiftUI

struct MenuUser {
    var username: String
    var email: String
    var shoeSize: Double = 42.0
}

struct MenuView: View {
    @EnvironmentObject var appState: AppState
    @State private var isDarkMode: Bool = false
    @State private var showLogoutAlert: Bool = false
    @State private var showAddCardAlert: Bool = false
    @State private var selectedCurrency: String = "USD"

    var user: MenuUser = MenuUser(username: "JohnDoe", email: "john.doe@example.com")

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Header styled similar to Home
                Text("Menu")
                    .font(.system(size: 32, weight: .bold, design: .rounded))
                    .italic()
                    .foregroundStyle(
                        LinearGradient(colors: [.blue, .purple, .pink.opacity(0.9)],
                                       startPoint: .leading,
                                       endPoint: .trailing)
                    )
                    .padding(.top, 16)
                    .accessibilityIdentifier("menu_header")

                Form {
                    // Profile section with navigation
                    Section(header: Text("Profile")) {
                        NavigationLink(destination: ProfileDetailView(user: user)) {
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
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.secondary)
                            }
                        }
                        .accessibilityIdentifier("profile_nav_link")
                    }

                    // Settings section
                    Section(header: Text("Settings")) {
                        Toggle(isOn: $isDarkMode) {
                            Text("Dark Mode")
                        }
                        .accessibilityIdentifier("dark_mode_toggle")

                        Picker("Currency", selection: $selectedCurrency) {
                            Text("USD").tag("USD")
                            Text("EUR").tag("EUR")
                            Text("GBP").tag("GBP")
                            Text("UAH").tag("UAH")
                        }
                        .accessibilityIdentifier("currency_picker")

                        Button(action: { showAddCardAlert = true }) {
                            HStack {
                                Image(systemName: "creditcard")
                                Text("Add Credit Card")
                            }
                        }
                        .accessibilityIdentifier("add_credit_card_button")
                        .alert("Add Card", isPresented: $showAddCardAlert) {
                            Button("OK") {}
                        } message: {
                            Text("Mock: card entry flow will be implemented later.")
                        }
                    }

                    // Push logout lower with styled button
                    Section {
                        Button(action: { showLogoutAlert = true }) {
                            Text("Logout")
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                                .frame(maxWidth: .infinity)
                                .padding(12)
                                .foregroundColor(.white)
                                .background(
                                    LinearGradient(colors: [.blue, .purple], startPoint: .leading, endPoint: .trailing)
                                )
                                .cornerRadius(12)
                                .shadow(color: .purple.opacity(0.3), radius: 8, y: 4)
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
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

// MARK: - Profile Detail View
struct ProfileDetailView: View {
    @State var user: MenuUser

    var body: some View {
        Form {
            Section(header: Text("User")) {
                HStack {
                    Text("Name")
                    Spacer()
                    Text(user.username)
                        .foregroundColor(.secondary)
                }
                HStack {
                    Text("Email")
                    Spacer()
                    Text(user.email)
                        .foregroundColor(.secondary)
                }
                HStack {
                    Text("Shoe Size")
                    Spacer()
                    Text(String(format: "%.1f", user.shoeSize))
                        .foregroundColor(.secondary)
                }
            }
        }
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    MenuView()
        .environmentObject(AppState())
}

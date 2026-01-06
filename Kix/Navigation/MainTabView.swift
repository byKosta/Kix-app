import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .accessibilityIdentifier("tab_home")
            NotesView()
                .tabItem {
                    Label("Notes", systemImage: "note.text")
                }
                .accessibilityIdentifier("tab_notes")
            FavoritesView()
                .tabItem {
                    Label("Favorites", systemImage: "heart")
                }
                .accessibilityIdentifier("tab_favorites")
            MenuView()
                .tabItem {
                    Label("Menu", systemImage: "line.3.horizontal")
                }
                .accessibilityIdentifier("tab_menu")
            CartView()
                .tabItem {
                    Label("Cart", systemImage: "cart")
                }
                .accessibilityIdentifier("tab_cart")
        }
    }
}

#Preview {
    MainTabView()
}

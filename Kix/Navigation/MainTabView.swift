import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: selectedTab == 0 ? "house.fill" : "house")
                }
                .tag(0)
                .accessibilityIdentifier("tab_home")
            
            NotesView()
                .tabItem {
                    Label("Notes", systemImage: selectedTab == 1 ? "note.text" : "note.text")
                }
                .tag(1)
                .accessibilityIdentifier("tab_notes")
            
            FavoritesView()
                .tabItem {
                    Label("Favorites", systemImage: selectedTab == 2 ? "heart.fill" : "heart")
                }
                .tag(2)
                .accessibilityIdentifier("tab_favorites")
            
            MenuView()
                .tabItem {
                    Label("Menu", systemImage: selectedTab == 3 ? "line.3.horizontal" : "line.3.horizontal")
                }
                .tag(3)
                .accessibilityIdentifier("tab_menu")
            
            CartView()
                .tabItem {
                    Label("Cart", systemImage: selectedTab == 4 ? "cart.fill" : "cart")
                }
                .tag(4)
                .accessibilityIdentifier("tab_cart")
        }
        .accentColor(.purple)
        .onAppear {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor.systemBackground
            appearance.shadowColor = UIColor.black.withAlphaComponent(0.1)
            
            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }
}

#Preview {
    MainTabView()
}

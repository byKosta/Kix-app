import SwiftUI
import Combine

class TabSelection: ObservableObject {
    @Published var selectedTab: Int = 0
}

struct MainTabView: View {
    @StateObject private var tabSelection = TabSelection()
    
    var body: some View {
        TabView(selection: $tabSelection.selectedTab) {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: tabSelection.selectedTab == 0 ? "house.fill" : "house")
                }
                .tag(0)
                .accessibilityIdentifier("tab_home")
            
            NotesView()
                .environmentObject(tabSelection)
                .tabItem {
                    Label("Notes", systemImage: tabSelection.selectedTab == 1 ? "note.text" : "note.text")
                }
                .tag(1)
                .accessibilityIdentifier("tab_notes")
            
            FavoritesView()
                .tabItem {
                    Label("Favorites", systemImage: tabSelection.selectedTab == 2 ? "heart.fill" : "heart")
                }
                .tag(2)
                .accessibilityIdentifier("tab_favorites")
            
            MenuView()
                .tabItem {
                    Label("Menu", systemImage: tabSelection.selectedTab == 3 ? "line.3.horizontal" : "line.3.horizontal")
                }
                .tag(3)
                .accessibilityIdentifier("tab_menu")
            
            CartView()
                .tabItem {
                    Label("Cart", systemImage: tabSelection.selectedTab == 4 ? "cart.fill" : "cart")
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

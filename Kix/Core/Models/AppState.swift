import Foundation
import SwiftUI
import Combine

class AppState: ObservableObject {
    @Published var isAuthenticated: Bool = false
    @Published var user: MenuUser? = MenuUser(username: "JohnDoe", email: "john.doe@example.com")
    @Published var cartManager = CartManager()
    @Published var favoritesManager = FavoritesManager()
}

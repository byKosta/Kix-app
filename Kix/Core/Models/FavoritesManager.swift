import Foundation
import SwiftUI
import Combine

class FavoritesManager: ObservableObject {
    @Published var favorites: [Product] = [] {
        didSet { saveFavorites() }
    }
    
    private let favoritesKey = "favorites_ids"

    init() {
        loadFavorites()
    }
    
    func toggleFavorite(_ product: Product) {
        if let index = favorites.firstIndex(where: { $0.id == product.id }) {
            favorites.remove(at: index)
        } else {
            var newProduct = product
            newProduct.isFavorite = true
            favorites.append(newProduct)
        }
    }
    
    func isFavorite(_ product: Product) -> Bool {
        favorites.contains(where: { $0.id == product.id })
    }
    
    private func saveFavorites() {
        let ids = favorites.map { $0.id }
        if let encoded = try? JSONEncoder().encode(ids) {
            UserDefaults.standard.set(encoded, forKey: favoritesKey)
        }
    }
    
    private func loadFavorites() {
        guard let data = UserDefaults.standard.data(forKey: favoritesKey),
              let ids = try? JSONDecoder().decode([UUID].self, from: data) else {
            // Fallback to default mock data matching
            self.favorites = MockData.products.filter { $0.isFavorite }
            return
        }
        
        let allProducts = MockData.products
        self.favorites = allProducts.filter { ids.contains($0.id) }
        
        // Mark them as favorite in the local model copy
        for index in 0..<self.favorites.count {
            self.favorites[index].isFavorite = true
        }
    }
}

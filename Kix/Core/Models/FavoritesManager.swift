import Foundation
import SwiftUI
import Combine

class FavoritesManager: ObservableObject {
    @Published var favorites: [Product] = MockData.products.filter { $0.isFavorite }
    
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
}

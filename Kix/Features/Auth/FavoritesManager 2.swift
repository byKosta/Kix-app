import Foundation
import SwiftUI
import Combine

final class FavoritesStore: ObservableObject {
    @Published private(set) var favoriteIDs: Set<UUID> = [] {
        didSet { persist() }
    }
    
    @Published var favorites: [Product] = []
    
    private let storageKey = "favorites_ids"
    
    init() {
        load()
        rebuildFavorites()
    }
    
    func isFavorite(_ product: Product) -> Bool {
        favoriteIDs.contains(product.id)
    }
    
    func toggleFavorite(_ product: Product) {
        if favoriteIDs.contains(product.id) {
            favoriteIDs.remove(product.id)
        } else {
            favoriteIDs.insert(product.id)
        }
        rebuildFavorites()
    }
    
    private func rebuildFavorites() {
        // Compose favorites list from MockData and any dynamic products by matching IDs
        let all = MockData.products
        let selected = all.filter { favoriteIDs.contains($0.id) }
        // Ensure isFavorite flag reflects manager state
        favorites = selected.map { prod in
            var p = prod
            p.isFavorite = true
            return p
        }
    }
    
    private func persist() {
        let ids = favoriteIDs.map { $0.uuidString }
        UserDefaults.standard.set(ids, forKey: storageKey)
    }
    
    private func load() {
        if let ids = UserDefaults.standard.array(forKey: storageKey) as? [String] {
            favoriteIDs = Set(ids.compactMap { UUID(uuidString: $0) })
        }
    }
}

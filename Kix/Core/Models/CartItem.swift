import Foundation

struct CartItem: Identifiable, Equatable, Codable {
    let id: UUID
    let product: Product
    var quantity: Int
}

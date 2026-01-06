import Foundation

struct MockData {
    static let products: [Product] = [
        Product(
            id: UUID(),
            name: "Nike Air Zoom Pegasus 39",
            brand: "Nike",
            price: 129.99,
            imageName: "pegasus39",
            isFavorite: false,
            description: "Responsive running shoe for daily training."
        ),
        Product(
            id: UUID(),
            name: "Adidas Ultraboost 22",
            brand: "Adidas",
            price: 179.99,
            imageName: "ultraboost22",
            isFavorite: true,
            description: "Comfortable and stylish for long runs."
        ),
        Product(
            id: UUID(),
            name: "ASICS Gel-Kayano 29",
            brand: "ASICS",
            price: 159.99,
            imageName: "gelkayano29",
            isFavorite: false,
            description: "Stability shoe for overpronators."
        )
    ]
    
    static let cart: [CartItem] = [
        CartItem(id: UUID(), product: products[0], quantity: 1),
        CartItem(id: UUID(), product: products[1], quantity: 2)
    ]
}

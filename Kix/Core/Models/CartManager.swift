import Foundation
import Combine

class CartManager: ObservableObject {
    @Published var items: [CartItem] = []
    
    func addToCart(product: Product) {
        if let index = items.firstIndex(where: { $0.product.id == product.id }) {
            items[index].quantity += 1
        } else {
            let item = CartItem(id: UUID(), product: product, quantity: 1)
            items.append(item)
        }
    }
    
    func removeFromCart(item: CartItem) {
        items.removeAll { $0.id == item.id }
    }
    
    func increaseQuantity(item: CartItem) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index].quantity += 1
        }
    }
    
    func decreaseQuantity(item: CartItem) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            if items[index].quantity > 1 {
                items[index].quantity -= 1
            } else {
                removeFromCart(item: item)
            }
        }
    }
    
    func totalPrice() -> Double {
        items.reduce(0) { $0 + ($1.product.price * Double($1.quantity)) }
    }
    
    func clearCart() {
        items.removeAll()
    }
}

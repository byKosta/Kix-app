import SwiftUI

struct CartView: View {
    @StateObject private var cartManager = CartManager()
    @State private var showCheckoutAlert = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                // Header styled similar to Home and centered
                HStack { Spacer() }
                Text("Your Cart")
                    .font(.system(size: 32, weight: .bold, design: .rounded))
                    .italic()
                    .foregroundStyle(
                        LinearGradient(colors: [.blue, .purple, .pink.opacity(0.9)],
                                       startPoint: .leading,
                                       endPoint: .trailing)
                    )
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, 24)
                    .padding(.horizontal, 16)
                    .accessibilityIdentifier("cart_header")
                
                if cartManager.items.isEmpty {
                    VStack(spacing: 12) {
                        Image(systemName: "cart")
                            .font(.system(size: 42))
                            .foregroundColor(.secondary)
                        Text("Your cart is empty")
                            .font(.headline)
                            .foregroundColor(.secondary)
                            .accessibilityIdentifier("cart_empty_label")
                        Text("Add your favorite shoes from Home")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.top, 12)
                } else {
                    List {
                        ForEach(cartManager.items) { item in
                            HStack {
                                // Product image with fallback
                                if let uiImage = UIImage(named: item.product.imageName) {
                                    Image(uiImage: uiImage)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 60, height: 60)
                                        .clipped()
                                        .cornerRadius(10)
                                } else {
                                    ZStack {
                                        Color(.systemGray6)
                                        Image(systemName: "shoeprints.fill")
                                            .font(.system(size: 20))
                                            .foregroundColor(.secondary)
                                    }
                                    .frame(width: 60, height: 60)
                                    .cornerRadius(10)
                                }
                                
                                VStack(alignment: .leading) {
                                    Text(item.product.name)
                                        .font(.headline)
                                    Text(item.product.brand)
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                    Text("$\(String(format: "%.2f", item.product.price))")
                                        .font(.caption)
                                }
                                Spacer()
                                HStack(spacing: 8) {
                                    Button(action: {
                                        cartManager.decreaseQuantity(item: item)
                                    }) {
                                        Image(systemName: "minus.circle.fill")
                                            .foregroundColor(.purple)
                                    }
                                    .accessibilityIdentifier("decrease_quantity_button_\(item.id)")
                                    Text("\(item.quantity)")
                                        .frame(width: 24)
                                        .font(.headline)
                                    Button(action: {
                                        cartManager.increaseQuantity(item: item)
                                    }) {
                                        Image(systemName: "plus.circle.fill")
                                            .foregroundColor(.blue)
                                    }
                                    .accessibilityIdentifier("increase_quantity_button_\(item.id)")
                                }
                                Button(action: {
                                    cartManager.removeFromCart(item: item)
                                }) {
                                    Image(systemName: "trash")
                                        .foregroundColor(.red)
                                }
                                .accessibilityIdentifier("remove_cart_item_button_\(item.id)")
                            }
                        }
                    }
                    .listStyle(PlainListStyle())
                    
                    HStack {
                        Text("Total:")
                            .font(.title2)
                        Spacer()
                        Text("$\(String(format: "%.2f", cartManager.totalPrice()))")
                            .font(.title2)
                            .bold()
                            .accessibilityIdentifier("cart_total_price")
                    }
                    .padding([.horizontal, .top])
                    
                    Button(action: {
                        showCheckoutAlert = true
                    }) {
                        Text("Proceed to Checkout")
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            .kerning(1)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.white)
                            .background(
                                LinearGradient(colors: [.blue, .purple], startPoint: .leading, endPoint: .trailing)
                            )
                            .cornerRadius(16)
                            .shadow(color: .purple.opacity(0.35), radius: 10, y: 6)
                    }
                    .accessibilityIdentifier("checkout_button")
                    .padding([.horizontal, .bottom])
                    .alert(isPresented: $showCheckoutAlert) {
                        Alert(title: Text("Checkout"), message: Text("Order placed! (mock)"), dismissButton: .default(Text("OK"), action: {
                            cartManager.clearCart()
                        }))
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    CartView()
}

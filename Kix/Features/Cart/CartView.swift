import SwiftUI

struct CartView: View {
    @StateObject private var cartManager = CartManager()
    @State private var showCheckoutAlert = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("Cart")
                    .font(.largeTitle)
                    .padding(.top, 24)
                    .padding(.leading, 16)
                if cartManager.items.isEmpty {
                    Text("Your cart is empty.")
                        .foregroundColor(.secondary)
                        .padding()
                } else {
                    List {
                        ForEach(cartManager.items) { item in
                            HStack {
                                Image(item.product.imageName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 60, height: 60)
                                    .cornerRadius(10)
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
                                        Image(systemName: "minus.circle")
                                    }
                                    .accessibilityIdentifier("decrease_quantity_button_\(item.id)")
                                    Text("\(item.quantity)")
                                        .frame(width: 24)
                                    Button(action: {
                                        cartManager.increaseQuantity(item: item)
                                    }) {
                                        Image(systemName: "plus.circle")
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
                        Text("Checkout")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.accentGreen)
                            .foregroundColor(.white)
                            .cornerRadius(12)
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

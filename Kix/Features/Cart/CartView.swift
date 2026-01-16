import SwiftUI

struct CartView: View {
    @StateObject private var cartManager = CartManager()
    @StateObject private var paymentManager = PaymentManager()
    @State private var showCheckoutAlert = false
    @State private var showAddCardSheet = false
    @State private var showingDeleteAlert: PaymentMethod? = nil
    @State private var showClearCartAlert = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 0) {
                // Header
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
                        Section(header: Text("Items").font(.headline)) {
                            ForEach(cartManager.items) { item in
                                HStack {
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
                                        Button(action: { cartManager.decreaseQuantity(item: item) }) {
                                            Image(systemName: "minus.circle.fill").foregroundColor(.purple)
                                        }
                                        .accessibilityIdentifier("decrease_quantity_button_\(item.id)")
                                        Text("\(item.quantity)")
                                            .frame(width: 24)
                                            .font(.headline)
                                        Button(action: { cartManager.increaseQuantity(item: item) }) {
                                            Image(systemName: "plus.circle.fill").foregroundColor(.blue)
                                        }
                                        .accessibilityIdentifier("increase_quantity_button_\(item.id)")
                                    }
                                    Button(action: { cartManager.removeFromCart(item: item) }) {
                                        Image(systemName: "trash").foregroundColor(.red)
                                    }
                                    .accessibilityIdentifier("remove_cart_item_button_\(item.id)")
                                    .swipeActions(edge: .trailing) {
                                        Button(role: .destructive) { cartManager.removeFromCart(item: item) } label: {
                                            Label("Delete", systemImage: "trash")
                                        }
                                    }
                                }
                            }
                        }
                        
                        Section(header: Text("Payment").font(.headline)) {
                            if paymentManager.methods.isEmpty {
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("No payment methods")
                                        .foregroundColor(.secondary)
                                    Button {
                                        showAddCardSheet = true
                                    } label: {
                                        Label("Add Test Card", systemImage: "creditcard")
                                    }
                                    .accessibilityIdentifier("add_test_card_button")
                                }
                            } else {
                                ForEach(paymentManager.methods) { method in
                                    HStack {
                                        Image(systemName: iconName(for: method.brand))
                                            .foregroundColor(.blue)
                                        VStack(alignment: .leading, spacing: 2) {
                                            Text(method.brand.rawValue + " • " + method.numberMasked)
                                                .font(.subheadline)
                                            Text(method.holderName)
                                                .font(.caption)
                                                .foregroundColor(.secondary)
                                        }
                                        Spacer()
                                        if paymentManager.selectedMethodID == method.id {
                                            Image(systemName: "checkmark.circle.fill").foregroundColor(.green)
                                        }
                                    }
                                    .contentShape(Rectangle())
                                    .onTapGesture { paymentManager.select(method) }
                                    .swipeActions(edge: .trailing) {
                                        Button(role: .destructive) { showingDeleteAlert = method } label: {
                                            Label("Delete", systemImage: "trash")
                                        }
                                    }
                                }
                                Button {
                                    showAddCardSheet = true
                                } label: {
                                    Label("Add Another Test Card", systemImage: "plus.circle")
                                }
                                .accessibilityIdentifier("add_another_test_card_button")
                            }
                        }
                    }
                    .listStyle(InsetGroupedListStyle())
                    
                    VStack(spacing: 12) {
                        HStack {
                            Text("Total:").font(.title2)
                            Spacer()
                            Text("$\(String(format: "%.2f", cartManager.totalPrice()))")
                                .font(.title2).bold()
                                .accessibilityIdentifier("cart_total_price")
                        }
                        Button(action: { showCheckoutAlert = true }) {
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
                        .disabled(paymentManager.selectedMethod == nil)
                        .opacity(paymentManager.selectedMethod == nil ? 0.6 : 1)
                        .accessibilityIdentifier("checkout_button")
                    }
                    .padding([.horizontal, .bottom])
                    .alert(isPresented: $showCheckoutAlert) {
                        Alert(title: Text("Checkout"), message: Text(checkoutMessage()), dismissButton: .default(Text("OK"), action: {
                            cartManager.clearCart()
                        }))
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    if !cartManager.items.isEmpty {
                        Button(role: .destructive) {
                            showClearCartAlert = true
                        } label: {
                            Label("Clear Cart", systemImage: "trash")
                        }
                        .accessibilityIdentifier("clear_cart_button")
                    }
                }
            }
        }
        .sheet(isPresented: $showAddCardSheet) {
            AddTestCardSheet { brand in
                paymentManager.addTestCard(brand: brand)
            }
            .presentationDetents([.height(300), .medium])
        }
        .alert(item: $showingDeleteAlert) { method in
            Alert(title: Text("Remove card?"), message: Text("This will remove \(method.brand.rawValue) ending \(method.numberMasked.suffix(4))."), primaryButton: .destructive(Text("Remove"), action: {
                paymentManager.remove(method)
            }), secondaryButton: .cancel())
        }
        .alert("Clear all items?", isPresented: $showClearCartAlert) {
            Button("Cancel", role: .cancel) {}
            Button("Remove All", role: .destructive) {
                cartManager.clearCart()
            }
        } message: {
            Text("This will remove all items from your cart.")
        }
    }
    
    private func iconName(for brand: CardBrand) -> String {
        switch brand {
        case .visa: return "v.circle.fill"
        case .masterCard: return "m.circle.fill"
        case .amex: return "a.circle.fill"
        case .other: return "creditcard"
        }
    }
    
    private func checkoutMessage() -> String {
        guard let method = paymentManager.selectedMethod else {
            return "Please add and select a payment method."
        }
        return "Paid with \(method.brand.rawValue) (\(method.numberMasked)). Order placed! (mock)"
    }
}

// MARK: - Add Test Card Sheet
struct AddTestCardSheet: View {
    var onAdd: (CardBrand) -> Void
    @Environment(\.dismiss) private var dismiss
    @State private var selectedBrand: CardBrand = .visa
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Picker("Brand", selection: $selectedBrand) {
                    ForEach([CardBrand.visa, .masterCard], id: \.id) { brand in
                        Text(brand.rawValue).tag(brand)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Test number")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text(selectedBrand.testNumber)
                        .font(.title3)
                        .monospacedDigit()
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                }
                .padding(.horizontal)
                
                Spacer()
                Button {
                    onAdd(selectedBrand)
                    dismiss()
                } label: {
                    Label("Add Test \(selectedBrand.rawValue)", systemImage: "creditcard.fill")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(LinearGradient(colors: [.blue, .purple], startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(16)
                }
                .padding()
            }
            .navigationTitle("Add Test Card")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") { dismiss() }
                }
            }
        }
    }
}

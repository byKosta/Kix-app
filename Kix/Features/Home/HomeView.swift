import SwiftUI

struct HomeView: View {
    @State private var products: [Product] = MockData.products
    @EnvironmentObject var appState: AppState
    // Brand gradient (purple → blue) with subtle green accents in cards
    let brandGradient = LinearGradient(colors: [.purple, .blue], startPoint: .leading, endPoint: .trailing)
    
    @State private var showAddSheet: Bool = false
    @State private var newName: String = ""
    @State private var newBrand: String = ""
    @State private var newPriceText: String = ""
    @State private var newDescription: String = ""
    @State private var newImageName: String = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.white.ignoresSafeArea()
                
                VStack(alignment: .leading, spacing: 0) {
                    // --- HEADER ---
                    VStack(alignment: .center, spacing: 4) {
                        Text("THE KIX LIST")
                            .font(.system(size: 32, weight: .bold, design: .rounded))
                            .italic()
                            .foregroundStyle(
                                LinearGradient(colors: [.blue, .purple, .pink.opacity(0.9)],
                                               startPoint: .leading,
                                               endPoint: .trailing)
                            )
                            .frame(maxWidth: .infinity, alignment: .center)
                        Text("Curated Performance Shoes")
                            .font(.system(size: 14, weight: .semibold, design: .rounded))
                            .foregroundColor(.gray)
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .padding(.horizontal)
                    .padding(.top, 20)
                    .padding(.bottom, 15)

                    ScrollView {
                        // --- LIST OF PRODUCTS ---
                        LazyVStack(spacing: 25) {
                            ForEach(products) { product in
                                NewProductCard(
                                    product: product,
                                    onEdit: { updated in
                                        if let idx = products.firstIndex(where: { $0.id == updated.id }) {
                                            products[idx] = updated
                                        }
                                    },
                                    onDelete: {
                                        if let idx = products.firstIndex(where: { $0.id == product.id }) {
                                            products.remove(at: idx)
                                        }
                                    }
                                )
                                .padding(.horizontal)
                                .accessibilityIdentifier("home_product_card_\(product.id.uuidString)")
                                .environmentObject(appState.favoritesManager)
                            }
                        }
                        .padding(.top, 10)
                        .padding(.bottom, 100) // spacing for tab bar
                    }
                }
            }
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    Button(action: { showAddSheet = true }) {
//                        Image(systemName: "plus")
//                    }
//                    .accessibilityIdentifier("home_add_product_button")
//                }
//            }
            .sheet(isPresented: $showAddSheet) {
                NavigationView {
                    Form {
                        Section(header: Text("Name")) {
                            TextField("e.g. Vaporfly 3", text: $newName)
                        }
                        Section(header: Text("Brand")) {
                            TextField("e.g. Nike", text: $newBrand)
                        }
                        Section(header: Text("Price")) {
                            TextField("e.g. 199.99", text: $newPriceText)
                                .keyboardType(.decimalPad)
                        }
                        Section(header: Text("Description")) {
                            TextEditor(text: $newDescription)
                                .frame(minHeight: 100)
                        }
                        Section(header: Text("Image Name (asset)")) {
                            TextField("e.g. vaporfly3", text: $newImageName)
                        }
                    }
                    .navigationTitle("New Sneaker")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                showAddSheet = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Save") {
                                let trimmedName = newName.trimmingCharacters(in: .whitespacesAndNewlines)
                                let trimmedBrand = newBrand.trimmingCharacters(in: .whitespacesAndNewlines)
                                let price = Double(newPriceText.replacingOccurrences(of: ",", with: ".")) ?? -1
                                guard !trimmedName.isEmpty, !trimmedBrand.isEmpty, price >= 0 else { return }
                                let product = Product(
                                    id: UUID(),
                                    name: trimmedName,
                                    brand: trimmedBrand,
                                    price: price,
                                    imageName: newImageName.trimmingCharacters(in: .whitespacesAndNewlines),
                                    isFavorite: false,
                                    description: newDescription
                                )
                                products.insert(product, at: 0)
                                // reset fields
                                newName = ""; newBrand = ""; newPriceText = ""; newDescription = ""; newImageName = ""
                                showAddSheet = false
                            }
                            .disabled(newName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || newBrand.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || Double(newPriceText.replacingOccurrences(of: ",", with: ".")) == nil)
                        }
                    }
                }
            }
        }
    }
}

// --- CARD WITH BRAND COLORS AND OVERFLOW MENU ---
struct NewProductCard: View {
    let product: Product
    var onEdit: (Product) -> Void
    var onDelete: () -> Void

    @EnvironmentObject private var favoritesManager: FavoritesManager

    @State private var isPressed = false
    @State private var showMenu = false
    @State private var showDeleteConfirm = false
    @State private var showDetail = false
    @State private var showEditSheet = false

    // Local gradients to align with brand
    private let bgGradient = LinearGradient(colors: [.purple.opacity(0.06), .blue.opacity(0.06)], startPoint: .topLeading, endPoint: .bottomTrailing)
    private let priceGradient = LinearGradient(colors: [.purple, .blue], startPoint: .leading, endPoint: .trailing)

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Product image area
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .fill(bgGradient)
                    .frame(height: 200)
                
                Circle()
                    .fill(Color.green.opacity(0.12))
                    .blur(radius: 40)
                    .offset(x: 50, y: -30)

                Group {
                    if let uiImage = UIImage(named: product.imageName) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFill()
                            .frame(height: 170)
                            .clipped()
                            .padding(.horizontal, 12)
                    } else {
                        VStack {
                            Image(systemName: "shoeprints.fill")
                                .font(.system(size: 50))
                                .foregroundColor(.gray.opacity(0.35))
                            Text("NO IMAGE")
                                .font(.caption2)
                                .bold()
                                .foregroundColor(.gray.opacity(0.45))
                        }
                    }
                }

                // Heart overlay at top-right
                VStack {
                    HStack {
                        Spacer()
                        Button(action: { favoritesManager.toggleFavorite(product) }) {
                            Image(systemName: favoritesManager.isFavorite(product) ? "heart.fill" : "heart")
                                .foregroundColor(favoritesManager.isFavorite(product) ? .pink : .gray)
                                .padding(8)
                                .background(Color.white)
                                .clipShape(Circle())
                                .shadow(radius: 2)
                        }
                        .accessibilityIdentifier("home_card_favorite_\(product.id.uuidString)")
                    }
                    Spacer()
                }
                .padding(.horizontal, 12)
                .padding(.top, 8)
            }

            // Product info
            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Text(product.brand.uppercased())
                        .font(.system(size: 12, weight: .black))
                        .foregroundColor(.purple)
                    Spacer()
                    Text(String(format: "$%.0f", product.price))
                        .font(.system(size: 12, weight: .semibold, design: .rounded))
                        .foregroundColor(.gray)
                }
                
                Text(product.name)
                    .font(.system(size: 22, weight: .bold, design: .rounded))
                    .foregroundColor(.primary)
                
                Text(product.description)
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
                    .lineLimit(2)
            }
            .padding(.horizontal, 6)

            // Ellipsis menu under the price
            HStack {
                Spacer()
                Button(action: { showMenu = true }) {
                    Image(systemName: "ellipsis.circle")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundStyle(priceGradient)
                }
                .accessibilityIdentifier("home_product_menu_\(product.id.uuidString)")
            }
            .padding(.horizontal, 6)
            .padding(.bottom, 8)
        }
        .background(Color.white)
        .cornerRadius(30)
        .shadow(color: Color.black.opacity(0.08), radius: 12, x: 0, y: 6)
        .scaleEffect(isPressed ? 0.97 : 1.0)
        .animation(.easeInOut(duration: 0.15), value: isPressed)
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.1)) { isPressed = true }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation(.easeInOut(duration: 0.1)) { isPressed = false }
            }
        }
        .confirmationDialog("Actions", isPresented: $showMenu, titleVisibility: .automatic) {
            Button("View") { showDetail = true }
            Button("Edit") { showEditSheet = true }
            Button("Delete", role: .destructive) { showDeleteConfirm = true }
            Button("Cancel", role: .cancel) {}
        }
        .alert("Delete item?", isPresented: $showDeleteConfirm) {
            Button("Delete", role: .destructive) { onDelete() }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("This action cannot be undone.")
        }
        .sheet(isPresented: $showDetail) {
            ProductDetailView(product: product)
        }
        .sheet(isPresented: $showEditSheet) {
            EditProductSheet(original: product) { updated in
                onEdit(updated)
            }
        }
    }
}

// Simple edit form (name/price/description)
private struct EditProductSheet: View {
    let original: Product
    var onSave: (Product) -> Void
    @Environment(\.dismiss) private var dismiss

    @State private var name: String
    @State private var priceText: String
    @State private var desc: String

    init(original: Product, onSave: @escaping (Product) -> Void) {
        self.original = original
        self.onSave = onSave
        _name = State(initialValue: original.name)
        _priceText = State(initialValue: String(format: "%.2f", original.price))
        _desc = State(initialValue: original.description)
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Name")) {
                    TextField("Name", text: $name)
                }
                Section(header: Text("Price")) {
                    TextField("e.g. 159.99", text: $priceText)
                        .keyboardType(.decimalPad)
                }
                Section(header: Text("Description")) {
                    TextEditor(text: $desc)
                        .frame(minHeight: 120)
                }
            }
            .navigationTitle("Edit Sneaker")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let price = Double(priceText.replacingOccurrences(of: ",", with: ".")) ?? original.price
                        let updated = Product(
                            id: original.id,
                            name: name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? original.name : name,
                            brand: original.brand,
                            price: price,
                            imageName: original.imageName,
                            isFavorite: original.isFavorite,
                            description: desc
                        )
                        onSave(updated)
                        dismiss()
                    }
                    .disabled(name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
        }
    }
}

#Preview {
    HomeView()
}

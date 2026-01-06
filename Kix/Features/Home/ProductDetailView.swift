import SwiftUI

struct ProductDetailView: View {
    @State private var isFavorite: Bool
    @State private var showAddedToCart: Bool = false
    let product: Product
    
    init(product: Product) {
        self.product = product
        self._isFavorite = State(initialValue: product.isFavorite)
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                Image(product.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 260)
                    .cornerRadius(20)
                    .padding(.top, 16)
                Text(product.name)
                    .font(AppFont.title)
                    .padding(.top, 8)
                Text(product.brand)
                    .font(AppFont.sectionTitle)
                    .foregroundColor(.secondary)
                Text("$\(String(format: "%.2f", product.price))")
                    .font(AppFont.body)
                    .bold()
                    .padding(.vertical, 4)
                Text(product.description)
                    .font(AppFont.body)
                    .foregroundColor(.primary)
                    .padding(.vertical, 8)
                HStack(spacing: 16) {
                    Button(action: {
                        showAddedToCart = true
                        // TODO: Add to cart logic
                    }) {
                        Label("Add to Cart", systemImage: "cart.badge.plus")
                            .padding()
                            .background(Color.accentGreen)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .accessibilityIdentifier("detail_add_to_cart_button")
                    Button(action: {
                        isFavorite.toggle()
                        // TODO: Update favorite state in model/service
                    }) {
                        Image(systemName: isFavorite ? "heart.fill" : "heart")
                            .foregroundColor(isFavorite ? .red : .gray)
                            .padding()
                            .background(Color.white)
                            .clipShape(Circle())
                            .shadow(radius: 2)
                    }
                    .accessibilityIdentifier("detail_favorite_button")
                }
                if showAddedToCart {
                    Text("Added to cart!")
                        .foregroundColor(.accentGreen)
                        .font(.caption)
                        .transition(.opacity)
                        .padding(.top, 4)
                }
                Spacer()
            }
            .padding(.horizontal)
        }
        .background(Color.backgroundPrimary)
        .navigationTitle(product.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    ProductDetailView(product: MockData.products.first!)
}

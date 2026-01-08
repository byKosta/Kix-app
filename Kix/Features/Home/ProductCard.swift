import SwiftUI

struct ProductCard: View {
    let product: Product
    @State private var isFavorite: Bool
    
    init(product: Product) {
        self.product = product
        self._isFavorite = State(initialValue: product.isFavorite)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            ZStack(alignment: .topTrailing) {
                // Image with fallback
                Group {
                    if let uiImage = UIImage(named: product.imageName) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                    } else {
                        // Fallback placeholder
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.gray.opacity(0.2))
                            .overlay(
                                VStack {
                                    Image(systemName: "photo")
                                        .font(.largeTitle)
                                        .foregroundColor(.gray)
                                    Text("No Image")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                            )
                    }
                }
                .frame(height: 180)
                .cornerRadius(16)
                Button(action: {
                    isFavorite.toggle()
                    // TODO: Update favorite state in model/service
                }) {
                    Image(systemName: isFavorite ? "heart.fill" : "heart")
                        .foregroundColor(isFavorite ? .red : .gray)
                        .padding(8)
                        .background(Color.white.opacity(0.7))
                        .clipShape(Circle())
                }
                .accessibilityIdentifier("favorite_button_\(product.id)")
            }
            Text(product.name)
                .font(AppFont.sectionTitle)
            Text(product.brand)
                .font(AppFont.body)
                .foregroundColor(.secondary)
            HStack {
                Text("$\(String(format: "%.2f", product.price))")
                    .font(AppFont.body)
                    .bold()
                Spacer()
                Button(action: {
                    // TODO: Add to cart logic
                }) {
                    Image(systemName: "cart.badge.plus")
                        .foregroundColor(.accentGreen)
                        .padding(8)
                        .background(Color.primaryBlue.opacity(0.1))
                        .clipShape(Circle())
                }
                .accessibilityIdentifier("add_to_cart_button_\(product.id)")
            }
        }
        .padding()
        .background(Color.backgroundSecondary)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
    }
}

#Preview {
    ProductCard(product: MockData.products.first!)
}

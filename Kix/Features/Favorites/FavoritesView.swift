import SwiftUI

struct FavoritesView: View {
    // Revert to local state to avoid missing EnvironmentObject crashes
    @StateObject private var favoritesManager = FavoritesManager()
    @State private var selectedProduct: Product? = nil
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 0) {
                // Header centered with gradient to match Home styling
                Text("Favorites")
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .italic()
                    .foregroundStyle(
                        LinearGradient(
                            colors: [.blue, .purple, .pink.opacity(0.9)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .padding(.top, 24)
                    .accessibilityIdentifier("favorites_header")
                
                if favoritesManager.favorites.isEmpty {
                    // Empty state message centered
                    VStack(spacing: 8) {
                        Image(systemName: "heart")
                            .font(.system(size: 40, weight: .semibold))
                            .foregroundColor(.purple.opacity(0.7))
                        Text("Nothing here yet")
                            .font(.system(size: 16, weight: .semibold, design: .rounded))
                            .foregroundColor(.secondary)
                            .accessibilityIdentifier("favorites_empty_label")
                        Text("Add your favorite shoes from Home")
                            .font(.system(size: 14, weight: .regular, design: .rounded))
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding()
                } else {
                    List {
                        ForEach(favoritesManager.favorites) { product in
                            HStack {
                                Image(product.imageName)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 60, height: 60)
                                    .clipped()
                                VStack(alignment: .leading) {
                                    Text(product.name)
                                        .font(.headline)
                                    Text(product.brand)
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                                Spacer()
                                Button(action: {
                                    favoritesManager.toggleFavorite(product)
                                }) {
                                    Image(systemName: "heart.fill")
                                        .foregroundColor(.red)
                                }
                                .accessibilityIdentifier("remove_favorite_button_\(product.id)")
                            }
                            .contentShape(Rectangle())
                            .onTapGesture {
                                selectedProduct = product
                            }
                        }
                        .onDelete { indexSet in
                            indexSet.forEach { i in
                                let product = favoritesManager.favorites[i]
                                favoritesManager.toggleFavorite(product)
                            }
                        }
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .navigationBarHidden(true)
            .sheet(item: $selectedProduct) { product in
                NavigationView {
                    ProductDetailView(product: product)
                        .environmentObject(favoritesManager)
                }
            }
        }
        // Inject environment object so children like ProductCard can access it
        .environmentObject(favoritesManager)
    }
}

#Preview {
    FavoritesView()
        .environmentObject(FavoritesManager())
}

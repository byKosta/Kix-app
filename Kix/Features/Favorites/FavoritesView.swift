import SwiftUI

struct FavoritesView: View {
    @StateObject private var favoritesManager = FavoritesManager()
    @State private var selectedProduct: Product? = nil
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("Favorites")
                    .font(.largeTitle)
                    .padding(.top, 24)
                    .padding(.leading, 16)
                if favoritesManager.favorites.isEmpty {
                    Text("No favorite shoes yet.")
                        .foregroundColor(.secondary)
                        .padding()
                } else {
                    List {
                        ForEach(favoritesManager.favorites) { product in
                            HStack {
                                Image(product.imageName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 60, height: 60)
                                    .cornerRadius(10)
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
                }
            }
        }
    }
}

#Preview {
    FavoritesView()
}

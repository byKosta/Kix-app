import SwiftUI

struct HomeView: View {
    @State private var products: [Product] = MockData.products
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("Running Shoes")
                    .font(AppFont.title)
                    .foregroundColor(.primaryPurple)
                    .padding(.top, 24)
                    .padding(.leading, 16)
                    .accessibilityIdentifier("home_header")
                ScrollView {
                    LazyVStack(spacing: 20) {
                        ForEach(products) { product in
                            ProductCard(product: product)
                                .padding(.horizontal)
                                .accessibilityIdentifier("product_card_\(product.id)")
                        }
                    }
                }
            }
            .background(Color.backgroundPrimary)
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    HomeView()
}

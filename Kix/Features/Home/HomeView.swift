import SwiftUI

struct HomeView: View {
    @State private var products: [Product] = MockData.products
    let brandGradient = LinearGradient(colors: [.blue, .purple, .pink], startPoint: .leading, endPoint: .trailing)
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.white.edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .leading, spacing: 0) {
                    // --- HEADER ---
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("THE KIX LIST")
                                .font(.system(size: 34, weight: .black, design: .rounded))
                                .italic()
                                .foregroundStyle(brandGradient)
                            
                            Text("Curated Performance Shoes")
                                .font(.system(size: 14, weight: .semibold, design: .rounded))
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        
                        // Кнопка профиля или фильтра
                        Image(systemName: "line.3.horizontal.decrease.circle.fill")
                            .font(.system(size: 28))
                            .foregroundStyle(brandGradient)
                    }
                    .padding(.horizontal)
                    .padding(.top, 20)
                    .padding(.bottom, 15)

                    ScrollView {
                        // --- LIST OF PRODUCTS ---
                        LazyVStack(spacing: 25) {
                            ForEach(products) { product in
                                NewProductCard(product: product)
                                    .padding(.horizontal)
                            }
                        }
                        .padding(.top, 10)
                        .padding(.bottom, 100) // Отступ для таббара
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
}

// --- УЛУЧШЕННАЯ КАРТОЧКА ---
struct NewProductCard: View {
    let product: Product
    @State private var isPressed = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Изображение продукта
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color(.systemGray6))
                    .frame(height: 200)
                
                // Имитация "жидкого" фона внутри карточки
                Circle()
                    .fill(Color.purple.opacity(0.1))
                    .blur(radius: 40)
                    .offset(x: 50, y: -30)

                // Реальное изображение или placeholder
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
                                .foregroundColor(.gray.opacity(0.3))
                            Text("NO IMAGE")
                                .font(.caption2)
                                .bold()
                                .foregroundColor(.gray.opacity(0.4))
                        }
                    }
                }
                
                // Бейдж цены
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Text("$\(Int(product.price))")
                            .font(.system(.headline, design: .rounded))
                            .foregroundColor(.white)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(Color.black)
                            .clipShape(Capsule())
                            .padding(12)
                    }
                }
            }
            
            // Информация о продукте
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
            .padding(.bottom, 4)
        }
        .background(Color.white)
        .cornerRadius(30)
        .shadow(color: Color.black.opacity(0.08), radius: 12, x: 0, y: 6)
        .scaleEffect(isPressed ? 0.97 : 1.0)
        .animation(.easeInOut(duration: 0.15), value: isPressed)
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.1)) {
                isPressed = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation(.easeInOut(duration: 0.1)) {
                    isPressed = false
                }
            }
        }
    }
}

#Preview {
    HomeView()
}

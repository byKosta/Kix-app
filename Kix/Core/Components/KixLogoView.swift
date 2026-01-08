import SwiftUI

struct KixLogoView: View {
    var body: some View {
        ZStack {
            // 1. Фон с градиентом (Синий, Фиолетовый, Зеленый)
            LinearGradient(
                colors: [Color.blue, Color.purple, Color.green.opacity(0.8)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            
            // 2. Декоративные "жидкие" элементы (Розовые акценты)
            Circle()
                .fill(Color.pink.opacity(0.4))
                .frame(width: 600, height: 600)
                .offset(x: 200, y: -300)
                .blur(radius: 80)
            
            // 3. Эффект зеркального отражения (Liquid Mirror)
            GeometryReader { geo in
                Path { path in
                    path.move(to: CGPoint(x: 0, y: 0))
                    path.addCurve(
                        to: CGPoint(x: geo.size.width, y: geo.size.height * 0.4),
                        control1: CGPoint(x: geo.size.width * 0.5, y: geo.size.height * -0.1),
                        control2: CGPoint(x: geo.size.width * 0.7, y: geo.size.height * 0.5)
                    )
                    path.addLine(to: CGPoint(x: geo.size.width, y: 0))
                    path.closeSubpath()
                }
                .fill(
                    LinearGradient(
                        colors: [.white.opacity(0.3), .clear],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
            }
            
            // 4. Текст KIX (Широкий, закругленный, белый)
            VStack(spacing: -10) {
                Text("KIX")
                    .font(.system(size: 280, weight: .black, design: .rounded))
                    .kerning(10) // Делаем строки чуть шире
                    .italic()
                    .foregroundStyle(
                        .white.shadow(.inner(color: .black.opacity(0.2), radius: 5, x: 2, y: 2))
                    )
                
                Text("SNEAKER STORE")
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                    .tracking(15)
                    .foregroundStyle(.white.opacity(0.9))
            }
        }
        .frame(width: 1024, height: 1024)
        .clipShape(RoundedRectangle(cornerRadius: 220, style: .continuous)) // Стандарт iOS иконки
    }
}

// Предпросмотр
struct KixLogo_Previews: PreviewProvider {
    static var previews: some View {
        KixLogoView()
            .previewLayout(.fixed(width: 1024, height: 1024))
    }
}

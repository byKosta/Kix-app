import SwiftUI

struct LoginView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var showRegister: Bool = false
    
    // Цвета бренда
    let brandGradient = LinearGradient(
        colors: [Color.blue, Color.purple, Color.pink.opacity(0.8)],
        startPoint: .leading,
        endPoint: .trailing
    )
    
    var body: some View {
        ZStack {
            // Мягкий фон с легким свечением сверху
            Color.white.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 25) {
                Spacer()
                
                // 1. Улучшенный Логотип KIX (SwiftUI вместо картинки)
                VStack(spacing: -15) {
                    Text("KIX")
                        .font(.system(size: 100, weight: .black, design: .rounded))
                        .italic()
                        .foregroundStyle(brandGradient)
                        .shadow(color: .purple.opacity(0.3), radius: 10, x: 0, y: 10)
                        // Эффект зеркального блика
                        .overlay(
                            Text("KIX")
                                .font(.system(size: 100, weight: .black, design: .rounded))
                                .italic()
                                .foregroundColor(.white.opacity(0.4))
                                .offset(y: -3)
                                .mask(LinearGradient(colors: [.white, .clear], startPoint: .top, endPoint: .center))
                        )
                    
                    Text("SNEAKER STORE")
                        .font(.system(size: 14, weight: .bold, design: .rounded))
                        .tracking(8)
                        .foregroundColor(.gray.opacity(0.6))
                }
                .padding(.bottom, 30)
                
                // 2. Welcome Text
                Text("Welcome Back")
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .foregroundColor(.black.opacity(0.8))
                
                // 3. Поля ввода в стиле "Liquid" (мягкие и закругленные)
                VStack(spacing: 18) {
                    customField(title: "Email", text: $viewModel.email, isSecure: false)
                        .accessibilityIdentifier("login_email_field")
                    
                    customField(title: "Password", text: $viewModel.password, isSecure: true)
                        .accessibilityIdentifier("login_password_field")
                }
                
                if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .font(.system(.caption, design: .rounded))
                }
                
                // 4. Кнопка Login с эффектом Liquid Mirror
                Button(action: { viewModel.login() }) {
                    Text("SIGN IN")
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .kerning(2)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 60)
                        .background(brandGradient)
                        .cornerRadius(20)
                        .shadow(color: .blue.opacity(0.4), radius: 15, y: 8)
                }
                .padding(.top, 10)
                .accessibilityIdentifier("login_button")
                
                // 5. Register Button
                Button(action: { showRegister = true }) {
                    HStack {
                        Text("New here?")
                            .foregroundColor(.gray)
                        Text("Create Account")
                            .fontWeight(.bold)
                            .foregroundStyle(brandGradient)
                    }
                    .font(.system(size: 14, design: .rounded))
                }
                .padding(.top, 10)
                .accessibilityIdentifier("register_nav_button")
                
                Spacer()
                Spacer()
            }
            .padding(.horizontal, 35)
        }
        .sheet(isPresented: $showRegister) {
            RegisterView(onRegister: { email, username, password in
                viewModel.email = email
                viewModel.password = password
                showRegister = false
            })
            .environmentObject(viewModel)
        }
    }
    
    // Вспомогательная функция для стильных полей ввода
    @ViewBuilder
    private func customField(title: String, text: Binding<String>, isSecure: Bool) -> some View {
        Group {
            if isSecure {
                SecureField(title, text: text)
            } else {
                TextField(title, text: text)
            }
        }
        .padding(.horizontal, 20)
        .frame(height: 60)
        .background(Color(.systemGray6).opacity(0.5))
        .cornerRadius(18)
        .overlay(
            RoundedRectangle(cornerRadius: 18)
                .stroke(LinearGradient(colors: [.blue.opacity(0.2), .purple.opacity(0.2)], startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 1.5)
        )
    }
}

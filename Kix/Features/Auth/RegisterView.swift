import SwiftUI

struct RegisterView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var email: String = ""
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var errorMessage: String? = nil
    @Environment(\.dismiss) private var dismiss
    var onRegister: ((String, String, String) -> Void)? = nil
    
    // Цвета бренда (как в LoginView)
    let brandGradient = LinearGradient(
        colors: [Color.blue, Color.purple, Color.pink.opacity(0.8)],
        startPoint: .leading,
        endPoint: .trailing
    )
    
    var body: some View {
        ZStack {
            // Мягкий белый фон (как в LoginView)
            Color.white.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 25) {
                Spacer()
                
                // 1. Улучшенный Логотип KIX (SwiftUI, как в LoginView)
                VStack(spacing: -15) {
                    Text("KIX")
                        .font(.system(size: 80, weight: .black, design: .rounded))
                        .italic()
                        .foregroundStyle(brandGradient)
                        .shadow(color: .purple.opacity(0.3), radius: 10, x: 0, y: 10)
                        // Эффект зеркального блика
                        .overlay(
                            Text("KIX")
                                .font(.system(size: 80, weight: .black, design: .rounded))
                                .italic()
                                .foregroundColor(.white.opacity(0.4))
                                .offset(y: -3)
                                .mask(LinearGradient(colors: [.white, .clear], startPoint: .top, endPoint: .center))
                        )
                    
                    Text("SNEAKER STORE")
                        .font(.system(size: 12, weight: .bold, design: .rounded))
                        .tracking(6)
                        .foregroundColor(.gray.opacity(0.6))
                }
                .padding(.bottom, 20)
                
                // 2. Welcome Text
                Text("Join KIX Family")
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .foregroundColor(.black.opacity(0.8))
                
                // 3. Поля ввода в стиле "Liquid" (как в LoginView)
                VStack(spacing: 18) {
                    customField(title: "Email", text: $email, isSecure: false)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled(true)
                        .keyboardType(.emailAddress)
                        .accessibilityIdentifier("register_email_field")
                    
                    customField(title: "Username", text: $username, isSecure: false)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled(true)
                        .accessibilityIdentifier("register_username_field")
                    
                    customField(title: "Password", text: $password, isSecure: true)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled(true)
                        .accessibilityIdentifier("register_password_field")
                    
                    customField(title: "Confirm Password", text: $confirmPassword, isSecure: true)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled(true)
                        .accessibilityIdentifier("register_confirm_password_field")
                }
                
                if let error = errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .font(.system(.caption, design: .rounded))
                }
                
                // 4. Кнопка Register с эффектом Liquid Mirror (как в LoginView)
                Button(action: {
                    if email.isEmpty || username.isEmpty || password.isEmpty || confirmPassword.isEmpty {
                        errorMessage = "Please fill all fields."
                    } else if password != confirmPassword {
                        errorMessage = "Passwords do not match."
                    } else if UserStore.shared.userExists(email: email) {
                        errorMessage = "User already exists."
                    } else {
                        let user = User(email: email, username: username, password: password)
                        UserStore.shared.addUser(user)
                        errorMessage = nil
                        onRegister?(email, username, password)
                        dismiss()
                    }
                }) {
                    Text("CREATE ACCOUNT")
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
                .accessibilityIdentifier("register_button")
                
                // 5. Login Button
                Button(action: { dismiss() }) {
                    HStack {
                        Text("Already have an account?")
                            .foregroundColor(.gray)
                        Text("Sign In")
                            .fontWeight(.bold)
                            .foregroundStyle(brandGradient)
                    }
                    .font(.system(size: 14, design: .rounded))
                }
                .padding(.top, 10)
                .accessibilityIdentifier("back_to_login_button")
                
                Spacer()
                Spacer()
            }
            .padding(.horizontal, 35)
        }
        .onAppear {
            // Очистить поля при появлении экрана
            email = ""
            username = ""
            password = ""
            confirmPassword = ""
            errorMessage = nil
        }
    }
    
    // Вспомогательная функция для стильных полей ввода (как в LoginView)
    @ViewBuilder
    private func customField(title: String, text: Binding<String>, isSecure: Bool) -> some View {
        Group {
            if isSecure {
                SecureField(title, text: text)
            } else {
                TextField(title, text: text)
                    .keyboardType(title == "Email" ? .emailAddress : .default)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled(true)
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

#Preview {
    RegisterView().environmentObject(AuthViewModel())
}

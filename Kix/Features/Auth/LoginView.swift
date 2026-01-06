import SwiftUI

struct LoginView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var showRegister: Bool = false
    
    var body: some View {
        VStack(spacing: 32) {
            Text("Login")
                .font(.largeTitle)
                .bold()
                .padding(.top, 40)
            VStack(spacing: 16) {
                TextField("Email", text: $viewModel.email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .accessibilityIdentifier("login_email_field")
                SecureField("Password", text: $viewModel.password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .accessibilityIdentifier("login_password_field")
            }
            if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
                    .font(.caption)
            }
            Button(action: {
                viewModel.login()
            }) {
                Text("Login")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .accessibilityIdentifier("login_button")
            Button(action: { showRegister = true }) {
                Text("Don't have an account? Register")
                    .font(.footnote)
            }
            .accessibilityIdentifier("register_nav_button")
            Spacer()
        }
        .padding()
        .sheet(isPresented: $showRegister) {
            RegisterView(onRegister: { email, username, password in
                viewModel.email = email
                viewModel.password = password
                showRegister = false
            })
            .environmentObject(viewModel)
        }
    }
}

#Preview {
    LoginView()
}

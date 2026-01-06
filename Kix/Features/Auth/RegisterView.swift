import SwiftUI

struct RegisterView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var email: String = ""
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var errorMessage: String? = nil
    @Environment(\.dismiss) private var dismiss
    var onRegister: ((String, String, String) -> Void)? = nil
    
    var body: some View {
        VStack(spacing: 32) {
            Text("Register")
                .font(.largeTitle)
                .bold()
                .padding(.top, 40)
            VStack(spacing: 16) {
                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .accessibilityIdentifier("register_email_field")
                TextField("Username", text: $username)
                    .autocapitalization(.none)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .accessibilityIdentifier("register_username_field")
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .accessibilityIdentifier("register_password_field")
                SecureField("Confirm Password", text: $confirmPassword)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .accessibilityIdentifier("register_confirm_password_field")
            }
            if let error = errorMessage {
                Text(error)
                    .foregroundColor(.red)
                    .font(.caption)
            }
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
                Text("Register")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .accessibilityIdentifier("register_button")
            Spacer()
        }
        .padding()
    }
}

#Preview {
    RegisterView().environmentObject(AuthViewModel())
}

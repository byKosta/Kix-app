import Foundation
import SwiftUI
import Combine

class AuthViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var username: String = ""
    @Published var confirmPassword: String = ""
    @Published var errorMessage: String? = nil
    
    func login(completion: @escaping () -> Void) {
        let normalizedEmail = email.lowercased()
        if normalizedEmail.isEmpty || password.isEmpty {
            errorMessage = "Please enter email and password."
        } else {
            // Use UserStore for case-insensitive check
            if UserStore.shared.user(email: normalizedEmail, password: password) != nil {
                errorMessage = nil
                completion()
            } else {
                errorMessage = "Invalid credentials."
            }
        }
    }
    
    func register(completion: () -> Void) {
        if email.isEmpty || username.isEmpty || password.isEmpty || confirmPassword.isEmpty {
            errorMessage = "Please fill all fields."
        } else if password != confirmPassword {
            errorMessage = "Passwords do not match."
        } else {
            errorMessage = nil
            // Simulate registration success
            completion()
        }
    }
    
    func reset() {
        email = ""
        password = ""
        username = ""
        confirmPassword = ""
        errorMessage = nil
    }
}

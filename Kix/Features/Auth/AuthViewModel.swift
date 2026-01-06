import Foundation
import SwiftUI
import Combine

class AuthViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var username: String = ""
    @Published var confirmPassword: String = ""
    @Published var errorMessage: String? = nil
    @Published var isAuthenticated: Bool = false
    
    func login() {
        if email.isEmpty || password.isEmpty {
            errorMessage = "Please enter email and password."
        } else if email == "test@test.com" && password == "password" {
            errorMessage = nil
            isAuthenticated = true
        } else {
            errorMessage = "Invalid credentials."
        }
    }
    
    func register() {
        if email.isEmpty || username.isEmpty || password.isEmpty || confirmPassword.isEmpty {
            errorMessage = "Please fill all fields."
        } else if password != confirmPassword {
            errorMessage = "Passwords do not match."
        } else {
            errorMessage = nil
            // Simulate registration success
        }
    }
    
    func reset() {
        email = ""
        password = ""
        username = ""
        confirmPassword = ""
        errorMessage = nil
        isAuthenticated = false
    }
}

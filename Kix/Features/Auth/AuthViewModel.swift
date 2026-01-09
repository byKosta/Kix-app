import Foundation
import SwiftUI
import Combine

private func isValidEmail(_ email: String) -> Bool {
    let pattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    return email.range(of: pattern, options: .regularExpression) != nil
}

@MainActor class AuthViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var username: String = ""
    @Published var confirmPassword: String = ""
    @Published var errorMessage: String? = nil
    @Published var isAuthenticated: Bool = false
    @Published var isLoading: Bool = false
    
    func login() {
        Task { [weak self] in
            await self?.loginAsync()
        }
    }
    
    func loginAsync() async {
        let normalizedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        email = normalizedEmail
        errorMessage = nil
        guard !normalizedEmail.isEmpty, !password.isEmpty else {
            errorMessage = "Please enter email and password."
            return
        }
        guard isValidEmail(normalizedEmail) else {
            errorMessage = "Please enter a valid email."
            return
        }
        isLoading = true
        defer { isLoading = false }
        // Simulate network delay
        try? await Task.sleep(nanoseconds: 600_000_000)
        if normalizedEmail == "test@test.com" && password == "password" {
            isAuthenticated = true
            errorMessage = nil
        } else {
            errorMessage = "Invalid credentials."
        }
    }
    
    func register(completion: () -> Void) {
        let normalizedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        email = normalizedEmail
        if normalizedEmail.isEmpty || username.isEmpty || password.isEmpty || confirmPassword.isEmpty {
            errorMessage = "Please fill all fields."
            return
        }
        
        if password != confirmPassword {
            errorMessage = "Passwords do not match."
            return
        }
        
        // Check if user already exists
        if UserStore.shared.userExists(email: normalizedEmail) {
            errorMessage = "User with this email already exists."
            return
        }
        
        // Add new user
        let newUser = User(email: normalizedEmail, username: username, password: password)
        UserStore.shared.addUser(newUser)
        errorMessage = nil
        completion()
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


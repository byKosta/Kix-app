import Foundation

struct User: Codable, Equatable {
    let email: String
    let username: String
    let password: String
}

class UserStore {
    static let shared = UserStore()
    private let key = "kix_users"
    private var users: [User] = []
    
    private init() {
        load()
    }
    
    func load() {
        if let data = UserDefaults.standard.data(forKey: key),
           let decoded = try? JSONDecoder().decode([User].self, from: data) {
            // Normalize any previously stored emails to lowercase to enforce case-insensitive behavior
            users = decoded.map { user in
                let lowercasedEmail = user.email.lowercased()
                if lowercasedEmail != user.email {
                    return User(email: lowercasedEmail, username: user.username, password: user.password)
                }
                return user
            }
            save()
        } else {
            // Add default users (emails stored lowercased)
            users = [
                User(email: "test@kixapp.com", username: "TestUser", password: "password"),
                // Uncomment or extend defaults if needed
                // User(email: "manager@kixapp.com", username: "Manager", password: "password"),
                // User(email: "guest@kixapp.com", username: "Guest", password: "password"),
            ]
            save()
        }
    }
    
    func save() {
        if let data = try? JSONEncoder().encode(users) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }
    
    func addUser(_ user: User) {
        // Ensure email stored in lowercase
        let normalized = User(email: user.email.lowercased(), username: user.username, password: user.password)
        users.append(normalized)
        save()
    }
    
    func user(email: String, password: String) -> User? {
        let normalizedEmail = email.lowercased()
        return users.first { $0.email.lowercased() == normalizedEmail && $0.password == password }
    }
    
    func userExists(email: String) -> Bool {
        let normalizedEmail = email.lowercased()
        return users.contains { $0.email.lowercased() == normalizedEmail }
    }
    
    func reset() {
        users = [User(email: "test@kixapp.com", username: "TestUser", password: "password")]
        save()
    }
}

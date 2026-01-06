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
            users = decoded
        } else {
            // Add default user
            users = [User(email: "test@test.com", username: "TestUser", password: "password")]
            save()
        }
    }
    
    func save() {
        if let data = try? JSONEncoder().encode(users) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }
    
    func addUser(_ user: User) {
        users.append(user)
        save()
    }
    
    func user(email: String, password: String) -> User? {
        users.first { $0.email == email && $0.password == password }
    }
    
    func userExists(email: String) -> Bool {
        users.contains { $0.email == email }
    }
    
    func reset() {
        users = [User(email: "test@test.com", username: "TestUser", password: "password")]
        save()
    }
}

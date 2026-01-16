import Foundation

struct Note: Identifiable, Equatable, Codable {
    var id = UUID()
    var text: String
    var timestamp = Date()
}

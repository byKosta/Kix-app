import Foundation

struct Note: Identifiable, Equatable, Codable {
    let id: UUID
    var text: String
    var date: Date
}

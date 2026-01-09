import Foundation

struct Note: Identifiable, Equatable {
    var id = UUID()
    var text: String
    var timestamp = Date()
}

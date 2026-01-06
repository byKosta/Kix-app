import Foundation
import SwiftUI

struct Product: Identifiable, Codable, Equatable {
    let id: UUID
    let name: String
    let brand: String
    let price: Double
    let imageName: String
    var isFavorite: Bool
    let description: String
}

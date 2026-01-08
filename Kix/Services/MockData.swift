import SwiftUI

struct MockData {
    static let products: [Product] = [
        Product(id: UUID(), name: "Bondi 8", brand: "Hoka", price: 165.0, imageName: "bondi8", isFavorite: false, description: "     Maximum cushioning."),
        Product(id: UUID(), name: "Clifton 9", brand: "Hoka", price: 145.0, imageName: "clifton9", isFavorite: false, description: "     Everyday running."),
        Product(id: UUID(), name: "Air Zoom Pegasus 40", brand: "Nike", price: 130.0, imageName: "aitzoompegasus40", isFavorite: false, description: "     Reliable comfort."),
        Product(id: UUID(), name: "Adizero Adios Pro 3", brand: "Adidas", price: 250.0, imageName: "adizeroadiospro3", isFavorite: false, description: "     Race day power."),
        Product(id: UUID(), name: "Fresh Foam 1080v12", brand: "New Balance", price: 160.0, imageName: "1080v12", isFavorite: false, description: "Premium soft ride."),
        Product(id: UUID(), name: "GEL-Kayano 30", brand: "ASICS", price: 160.0, imageName: "gelkayano30", isFavorite: false, description: "Stability king."),
        Product(id: UUID(), name: "Endorphin Pro 3", brand: "Saucony", price: 225.0, imageName: "endorphinpro3", isFavorite: false, description: "Speed through carbon."),
        Product(id: UUID(), name: "Cloudmonster", brand: "On", price: 170.0, imageName: "cloudmonster", isFavorite: false, description: "Massive cloud tech."),
        Product(id: UUID(), name: "FuelCell SC Elite", brand: "New Balance", price: 230.0, imageName: "fcellscelite", isFavorite: false, description: "Ultra-fast energy return."),
        Product(id: UUID(), name: "Mach 5", brand: "Hoka", price: 140.0, imageName: "mach5", isFavorite: false, description: "Lightweight speed.")
    ]
}

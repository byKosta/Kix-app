import Foundation
import Combine

enum CardBrand: String, CaseIterable, Identifiable, Codable {
    case visa = "Visa"
    case masterCard = "Mastercard"
    case amex = "AmEx"
    case other = "Other"
    
    var id: String { rawValue }
    
    var testNumber: String {
        switch self {
        case .visa: return "4111 1111 1111 1111"
        case .masterCard: return "5555 5555 5555 4444"
        case .amex: return "3782 822463 10005"
        case .other: return "4000 0000 0000 0002"
        }
    }
}

struct PaymentMethod: Identifiable, Codable, Equatable {
    let id: UUID
    var brand: CardBrand
    var holderName: String
    var numberMasked: String
    var expiryMonth: Int
    var expiryYear: Int
    
    init(id: UUID = UUID(), brand: CardBrand, holderName: String, numberMasked: String, expiryMonth: Int, expiryYear: Int) {
        self.id = id
        self.brand = brand
        self.holderName = holderName
        self.numberMasked = numberMasked
        self.expiryMonth = expiryMonth
        self.expiryYear = expiryYear
    }
}

final class PaymentManager: ObservableObject {
    @Published private(set) var methods: [PaymentMethod] = []
    @Published var selectedMethodID: UUID? = nil
    
    func addTestCard(brand: CardBrand, holderName: String = "Test User", expiryMonth: Int = 12, expiryYear: Int = 2030) {
        let masked = Self.mask(cardNumber: brand.testNumber)
        let method = PaymentMethod(brand: brand, holderName: holderName, numberMasked: masked, expiryMonth: expiryMonth, expiryYear: expiryYear)
        methods.append(method)
        selectedMethodID = method.id
    }
    
    func remove(_ method: PaymentMethod) {
        methods.removeAll { $0.id == method.id }
        if selectedMethodID == method.id { selectedMethodID = methods.first?.id }
    }
    
    func select(_ method: PaymentMethod) {
        selectedMethodID = method.id
    }
    
    var selectedMethod: PaymentMethod? {
        methods.first(where: { $0.id == selectedMethodID })
    }
    
    static func mask(cardNumber: String) -> String {
        let digits = cardNumber.replacingOccurrences(of: " ", with: "")
        guard digits.count >= 4 else { return cardNumber }
        let suffix = digits.suffix(4)
        return "•••• •••• •••• \(suffix)"
    }
}


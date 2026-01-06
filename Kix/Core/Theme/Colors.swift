import SwiftUI

extension Color {
    static let primaryPurple = Color("PrimaryPurple")
    static let primaryBlue = Color("PrimaryBlue")
    static let accentGreen = Color("AccentGreen")
    static let backgroundPrimary = Color("BackgroundPrimary")
    static let backgroundSecondary = Color("BackgroundSecondary")
    static let gradientPrimary = LinearGradient(
        gradient: Gradient(colors: [Color.primaryPurple, Color.primaryBlue]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}

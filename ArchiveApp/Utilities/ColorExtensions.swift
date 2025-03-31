import SwiftUI

extension Color {
    static let customPrimary = Color("AppPrimaryColor")
    static let customAccent = Color("AccentColor")
}

extension UIColor {
    static let customPrimary = UIColor(named: "AppPrimaryColor") ?? .systemBlue
    static let customAccent = UIColor(named: "AccentColor") ?? .systemBlue
} 
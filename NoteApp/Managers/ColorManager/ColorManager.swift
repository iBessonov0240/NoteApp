import SwiftUI

final class ColorManager {

    // MARK: - Property

    @Published var background: Color
    @Published var white: Color
    @Published var gray: Color
    @Published var whiteAlpha: Color
    @Published var red: Color
    @Published var yellow: Color

    // MARK: - Init

    init() {
        self.background = Color(hex: "#040404")
        self.white = Color(hex: "#F4F4F4")
        self.gray = Color(hex: "#272729")
        self.whiteAlpha = Color(hex: "#F4F4F4", alpha: 0.5)
        self.red = Color(hex: "#D70015")
        self.yellow = Color(hex: "#FED702")
    }
}

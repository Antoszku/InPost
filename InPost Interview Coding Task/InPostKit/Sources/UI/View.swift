import SwiftUI

public extension View {
    func appFont(_ font: Font.Montserrat, size: CGFloat) -> some View {
        self.font(Font.custom(font.rawValue, size: size))
    }
}

import SwiftUI

public final class FontRegistration {
    public init() {}

    public func register() {
        Font.Montserrat.allCases.forEach { font in registerFont(bundle: .module, fontName: font.rawValue, fontExtension: "otf") }
    }

    private func registerFont(bundle: Bundle, fontName: String, fontExtension: String) {
        guard let fontURL = bundle.url(forResource: fontName, withExtension: fontExtension) else {
            fatalError("Couldn't find font \(fontName)")
        }

        guard let fontDataProvider = CGDataProvider(url: fontURL as CFURL) else {
            fatalError("Couldn't load data from the font \(fontName)")
        }

        guard let font = CGFont(fontDataProvider) else {
            fatalError("Couldn't create font from data")
        }

        var error: Unmanaged<CFError>?
        let success = CTFontManagerRegisterGraphicsFont(font, &error)
        guard success else {
            fatalError("Error registering font")
        }
    }
}

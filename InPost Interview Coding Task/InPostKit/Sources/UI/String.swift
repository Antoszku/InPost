import Foundation

public extension String {
    var localized: Self {
        return String(localized: LocalizedStringResource(stringLiteral: self))
    }
}

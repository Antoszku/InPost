import Foundation

public extension String {
    var localized: Self {
        String(localized: String.LocalizationValue(self), bundle: .module)
    }
}

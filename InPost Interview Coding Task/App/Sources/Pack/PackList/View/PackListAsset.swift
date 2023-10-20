import SwiftUI
import UI

struct PackListAssets {
    struct Texts {
        static let packageNumber = "packageNumber".localized
        static let status = "status".localized
        static let sender = "sender".localized
        static let more = "more".localized
    }

    struct Images {
        static let arrow = Image("arrow", bundle: .module)
        static let parcelLocker = Image("parcelLocker", bundle: .module)
        static let courier = Image("courier", bundle: .module)
    }
}

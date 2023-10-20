import Localizable
import SwiftUI
import UI

struct PackListAssets {
    struct Texts {
        static let packageNumber = "packageNumber".localized
        static let status = "status".localized
        static let sender = "sender".localized
        static let more = "more".localized
        static let packStatusUnsupported = "packStatusUnsupported".localized
        static let packStatusCreated = "packStatusCreated".localized
        static let packStatusNotReady = "packStatusNotReady".localized
        static let packStatusConfirmed = "packStatusConfirmed".localized
        static let packStatusAdoptedAtSourceBranch = "packStatusAdoptedAtSourceBranch".localized
        static let packStatusSentFromSourceBranch = "packStatusSentFromSourceBranch".localized
        static let packStatusAdoptedAtSortingCenter = "packStatusAdoptedAtSortingCenter".localized
        static let packStatusSentFromSortingCenter = "packStatusSentFromSortingCenter".localized
        static let packStatusOther = "packStatusOther".localized
        static let packStatusDelivered = "packStatusDelivered".localized
        static let packStatusReturnedToSender = "packStatusReturnedToSender".localized
        static let packStatusAvizo = "packStatusAvizo".localized
        static let packStatusOutForDelivery = "packStatusOutForDelivery".localized
        static let packStatusReadyToPickup = "packStatusReadyToPickup".localized
        static let packStatusPickupTimeExpired = "packStatusPickupTimeExpired".localized
    }

    struct Images {
        static let arrow = Image("arrow", bundle: .module)
        static let parcelLocker = Image("parcelLocker", bundle: .module)
        static let courier = Image("courier", bundle: .module)
    }
}

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

// TODO: Move it after creating DesignSystem
public enum ColorPalette {
    public static let text = Color(#colorLiteral(red: 0.2509803922, green: 0.2509803922, blue: 0.2549019608, alpha: 1)) // #404041
    public static let headerText = Color(#colorLiteral(red: 0.5725490196, green: 0.5803921569, blue: 0.5921568627, alpha: 1)) // #929497
    public static let background = Color(#colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)) // #F2F2F2
    public static let sectionHeader = Color(#colorLiteral(red: 0.7333333333, green: 0.7411764706, blue: 0.7490196078, alpha: 1)) // ##BBBDBF
}

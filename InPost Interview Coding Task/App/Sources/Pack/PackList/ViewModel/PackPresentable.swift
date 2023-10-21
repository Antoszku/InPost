import PackService
import SwiftUI

struct PackPresentable: Identifiable, Equatable {
    let id: String
    let packageNumber: String
    let status: String
    let sender: String
    let image: Image?
}

extension PackPresentable {
    init(dto: PackDTO) {
        id = dto.id
        packageNumber = dto.id
        sender = dto.sender
        switch dto.shipmentType {
        case .unsupported: image = nil
        case let .supported(shipmentType):
            switch shipmentType {
            case .courier: image = PackListAssets.Images.courier
            case .parcelLocker: image = PackListAssets.Images.parcelLocker
            }
        }

        switch dto.status {
        case .unsupported: status = PackListAssets.Texts.packStatusUnsupported
        case let .supported(packStatus):
            switch packStatus {
            case .created: status = PackListAssets.Texts.packStatusCreated
            case .notReady: status = PackListAssets.Texts.packStatusNotReady
            case .confirmed: status = PackListAssets.Texts.packStatusConfirmed
            case .adoptedAtSourceBranch: status = PackListAssets.Texts.packStatusAdoptedAtSourceBranch
            case .sentFromSourceBranch: status = PackListAssets.Texts.packStatusSentFromSourceBranch
            case .adoptedAtSortingCenter: status = PackListAssets.Texts.packStatusAdoptedAtSortingCenter
            case .sentFromSortingCenter: status = PackListAssets.Texts.packStatusSentFromSortingCenter
            case .other: status = PackListAssets.Texts.packStatusOther
            case .delivered: status = PackListAssets.Texts.packStatusDelivered
            case .returnedToSender: status = PackListAssets.Texts.packStatusReturnedToSender
            case .avizo: status = PackListAssets.Texts.packStatusAvizo
            case .outForDelivery: status = PackListAssets.Texts.packStatusOutForDelivery
            case .readyToPickup: status = PackListAssets.Texts.packStatusReadyToPickup
            case .pickupTimeExpired: status = PackListAssets.Texts.packStatusPickupTimeExpired
            }
        }
    }
}

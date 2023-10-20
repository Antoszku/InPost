import PackService
import SwiftUI

struct PackPresentable: Identifiable {
    let id: String
    let packageNumber: String
    let status: String
    let sender: String
    let image: Image?
}

extension PackPresentable {
    init(dto: PackDTO) {
        // TODO: Tests
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
        case .unsupported: status = ""
        case let .supported(packStatus):
            switch packStatus {
            case .created: status = ""
            case .confirmed: status = ""
            case .adoptedAtSourceBranch: status = ""
            case .sentFromSourceBranch: status = ""
            case .adoptedAtSortingCenter: status = ""
            case .sentFromSortingCenter: status = ""
            case .other: status = ""
            case .delivered: status = ""
            case .returnedToSender: status = ""
            case .avizo: status = ""
            case .outForDelivery: status = ""
            case .readyToPickup: status = ""
            case .pickupTimeExpired: status = ""
            }
        }
    }
}

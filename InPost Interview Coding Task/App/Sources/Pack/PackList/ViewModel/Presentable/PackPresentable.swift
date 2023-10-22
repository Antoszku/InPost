import InPostAppKit
import PackService
import SwiftUI

struct PackPresentable: Identifiable, Equatable {
    let id: String
    let packageNumber: String
    let status: String
    let sender: String
    let expiryDate: Date?
    let pickupDate: Date?
    let storedDate: Date?
    let packDateStatus: PackDateStatus?
    let icon: Image?
    let packState: PackState
    let sortOrderNumber: Int
}

extension PackPresentable {
    init(dto: PackDTO) {
        id = dto.id
        packageNumber = dto.id
        sender = dto.sender
        expiryDate = dto.expiryDate
        pickupDate = dto.pickupDate
        storedDate = dto.storedDate

        packDateStatus = Self.packDateStatus(for: dto)

        switch dto.shipmentType {
        case .unsupported: icon = nil
        case let .supported(shipmentType):
            icon = Self.image(for: shipmentType)
        }

        switch dto.status {
        case .unsupported:
            // TODO: Explain
            status = PackListAssets.Texts.packStatusUnsupported
            packState = .inTransit
            sortOrderNumber = 1000

        case let .supported(packStatus):
            status = Self.status(for: packStatus)
            packState = Self.packState(for: packStatus)
            sortOrderNumber = Self.sortOrderNumber(from: packStatus)
        }
    }

    private static func packDateStatus(for dto: PackDTO) -> PackDateStatus? {
        let formatter = DateFormatter()
        formatter.dateFormat = "E | dd.MM.yy | HH:mm"
        formatter.locale = AppConfiguration.locale

        if let pickupDate = dto.pickupDate {
            let dateString = formatter.string(from: pickupDate)
            return PackDateStatus(title: PackListAssets.Texts.packDateStatePickedUp, date: dateString)
        } else if let expiryDate = dto.expiryDate {
            let dateString = formatter.string(from: expiryDate)
            return PackDateStatus(title: PackListAssets.Texts.packDateStateReadyForPickUp, date: dateString)
        } else {
            return nil
        }
    }

    private static func image(for shipmentType: PackDTO.ShipmentType) -> Image {
        switch shipmentType {
        case .courier: PackListAssets.Images.courier
        case .parcelLocker: PackListAssets.Images.parcelLocker
        }
    }

    private static func status(for packStatus: PackDTO.Status) -> String {
        switch packStatus {
        case .created: PackListAssets.Texts.packStatusCreated
        case .notReady: PackListAssets.Texts.packStatusNotReady
        case .confirmed: PackListAssets.Texts.packStatusConfirmed
        case .adoptedAtSourceBranch: PackListAssets.Texts.packStatusAdoptedAtSourceBranch
        case .sentFromSourceBranch: PackListAssets.Texts.packStatusSentFromSourceBranch
        case .adoptedAtSortingCenter: PackListAssets.Texts.packStatusAdoptedAtSortingCenter
        case .sentFromSortingCenter: PackListAssets.Texts.packStatusSentFromSortingCenter
        case .other: PackListAssets.Texts.packStatusOther
        case .delivered: PackListAssets.Texts.packStatusDelivered
        case .returnedToSender: PackListAssets.Texts.packStatusReturnedToSender
        case .avizo: PackListAssets.Texts.packStatusAvizo
        case .outForDelivery: PackListAssets.Texts.packStatusOutForDelivery
        case .readyToPickup: PackListAssets.Texts.packStatusReadyToPickup
        case .pickupTimeExpired: PackListAssets.Texts.packStatusPickupTimeExpired
        }
    }

    private static func packState(for packStatus: PackDTO.Status) -> PackState {
        switch packStatus {
        case .created: .inTransit
        case .notReady: .inTransit
        case .confirmed: .inTransit
        case .adoptedAtSourceBranch: .inTransit
        case .sentFromSourceBranch: .inTransit
        case .adoptedAtSortingCenter: .inTransit
        case .sentFromSortingCenter: .inTransit
        case .other: .inTransit // TODO: What to do?
        case .delivered: .deliveryCompleted
        case .returnedToSender: .deliveryCompleted
        case .avizo: .inTransit
        case .outForDelivery: .inTransit
        case .readyToPickup: .inTransit
        case .pickupTimeExpired: .deliveryCompleted
        }
    }

    private static func sortOrderNumber(from status: PackDTO.Status) -> Int {
        switch status {
        case .created: 10
        case .notReady: 20
        case .confirmed: 30
        case .adoptedAtSourceBranch: 40
        case .sentFromSourceBranch: 50
        case .adoptedAtSortingCenter: 60
        case .sentFromSortingCenter: 70
        case .other: 80
        case .delivered: 90
        case .returnedToSender: 100
        case .avizo: 110
        case .outForDelivery: 120
        case .readyToPickup: 130
        case .pickupTimeExpired: 140
        }
    }
}

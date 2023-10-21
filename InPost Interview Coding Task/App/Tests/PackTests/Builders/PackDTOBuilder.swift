import DomainKit
import Foundation
@testable import PackService

extension PackDTO {
    static func build(id: String = "",
                      status: Supportable<Status> = .unsupported,
                      sender: String = "",
                      expiryDate: Date? = nil,
                      pickupDate: Date? = nil,
                      storedDate: Date? = nil,
                      shipmentType: Supportable<ShipmentType> = .unsupported) -> Self {
        PackDTO(
            id: id,
            status: status,
            sender: sender,
            expiryDate: expiryDate,
            pickupDate: pickupDate,
            storedDate: storedDate,
            shipmentType: shipmentType
        )
    }
}

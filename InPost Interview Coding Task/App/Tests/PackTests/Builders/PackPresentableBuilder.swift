@testable import Pack
import SwiftUI

extension PackPresentable {
    static func build(id: String = "",
                      packageNumber: String = "",
                      status: String = "",
                      sender: String = "",
                      expiryDate: Date? = nil,
                      pickupDate: Date? = nil,
                      storedDate: Date? = nil,
                      packDateStatus: PackDateStatus? = nil,
                      icon: Image? = nil,
                      packState: PackState = .inTransit,
                      sortOrderNumber: Int = 0) -> PackPresentable {
        PackPresentable(id: .init(id),
                        packageNumber: packageNumber,
                        status: status,
                        sender: sender,
                        expiryDate: expiryDate,
                        pickupDate: pickupDate,
                        storedDate: storedDate,
                        packDateStatus: packDateStatus,
                        icon: icon,
                        packState: packState,
                        sortOrderNumber: sortOrderNumber)
    }
}

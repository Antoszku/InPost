@testable import Pack
import SwiftUI

extension PackPresentable {
    static func build(id: String = "",
                      packageNumber: String = "",
                      status: String = "",
                      sender: String = "",
                      packDateStatus: PackDateStatus? = nil,
                      image: Image? = nil,
                      packState: PackState = .inTransit) -> PackPresentable {
        PackPresentable(id: id,
                        packageNumber: packageNumber,
                        status: status,
                        sender: sender, packDateStatus: packDateStatus,
                        image: image,
                        packState: packState)
    }
}

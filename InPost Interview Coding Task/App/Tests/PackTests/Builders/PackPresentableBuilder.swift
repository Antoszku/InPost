@testable import Pack
import SwiftUI

extension PackPresentable {
    static func build(id: String = "",
                      packageNumber: String = "",
                      status: String = "",
                      sender: String = "",
                      image: Image? = nil,
                      packState: PackState = .inTransit) -> PackPresentable {
        PackPresentable(id: id,
                        packageNumber: packageNumber,
                        status: status,
                        sender: sender,
                        image: image,
                        packState: packState)
    }
}

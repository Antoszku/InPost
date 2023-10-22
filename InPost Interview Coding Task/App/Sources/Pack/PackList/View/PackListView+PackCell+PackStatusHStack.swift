import SwiftUI

extension PackListView.PackCell {
    struct PackStatusHStack: View {
        let pack: PackPresentable

        var body: some View {
            HStack {
                HeaderValueLabel(header: PackListAssets.Texts.status, value: pack.status, valueFont: .bold)
                if let packDateStatus = pack.packDateStatus {
                    Spacer()
                    HeaderValueLabel(header: packDateStatus.title, value: packDateStatus.date, valueFont: .medium, alignment: .trailing).layoutPriority(1)
                }
            }
        }
    }
}

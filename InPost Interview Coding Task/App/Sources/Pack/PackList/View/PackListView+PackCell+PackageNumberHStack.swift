import SwiftUI

extension PackListView.PackCell {
    struct PackageNumberHStack: View {
        let pack: PackPresentable

        var body: some View {
            HStack {
                HeaderValueLabel(header: PackListAssets.Texts.packageNumber, value: pack.packageNumber, valueFont: .medium)
                Spacer()
                pack.icon
            }
        }
    }
}

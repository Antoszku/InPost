import SwiftUI

extension PackListView.PackCell {
    struct PackSenderHStack: View {
        let pack: PackPresentable

        var body: some View {
            HStack {
                HeaderValueLabel(header: PackListAssets.Texts.sender, value: pack.sender, valueFont: .bold)
                Spacer()
                HStack(spacing: 4) {
                    Text(PackListAssets.Texts.more).appFont(.bold, size: 12).foregroundColor(ColorPalette.text)
                    PackListAssets.Images.arrow
                }
            }
        }
    }
}

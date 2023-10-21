import SwiftUI
import UI

extension PackListView {
    struct PackCell: View {
        let presentable: PackPresentable

        var body: some View {
            HStack {
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        HeaderValueLabel(header: PackListAssets.Texts.packageNumber, value: presentable.packageNumber, valueFont: .medium)
                        Spacer()
                        presentable.image
                    }
                    HeaderValueLabel(header: PackListAssets.Texts.status, value: presentable.status, valueFont: .bold)
                    HStack {
                        HeaderValueLabel(header: PackListAssets.Texts.sender, value: presentable.sender, valueFont: .bold)
                        Spacer()
                        HStack(spacing: 4) {
                            Text(PackListAssets.Texts.more).appFont(.bold, size: 12).foregroundColor(ColorPalette.text)
                            PackListAssets.Images.arrow
                        }
                    }
                }.padding(.horizontal, 20)
            }.padding(.vertical, 16).background(.white)
        }
    }
}

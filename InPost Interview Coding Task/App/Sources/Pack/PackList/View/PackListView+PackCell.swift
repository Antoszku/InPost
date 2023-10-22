import SwiftUI
import UI

extension PackListView {
    struct PackCell: View {
        let presentable: PackPresentable

        var body: some View {
            VStack {
                HStack {
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            HeaderValueLabel(header: PackListAssets.Texts.packageNumber, value: presentable.packageNumber, valueFont: .medium)
                            Spacer()
                            presentable.icon
                        }
                        HStack {
                            HeaderValueLabel(header: PackListAssets.Texts.status, value: presentable.status, valueFont: .bold)
                            if let packDateStatus = presentable.packDateStatus {
                                Spacer()
                                HeaderValueLabel(header: packDateStatus.title, value: packDateStatus.date, valueFont: .medium, alignment: .trailing)
                            }
                        }
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
            }.compositingGroup()
                .padding(.bottom, 8)
                .shadow(color: ColorPalette.shadow, radius: 5, x: 0, y: 10)
        }
    }
}

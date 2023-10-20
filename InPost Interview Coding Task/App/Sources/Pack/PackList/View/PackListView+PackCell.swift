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
                Spacer()
            }.padding(.vertical, 16).background(.white)
        }
    }
}

// TODO: Move it after creating DesignSystem
public enum ColorPalette {
    public static let text = Color(#colorLiteral(red: 0.2509803922, green: 0.2509803922, blue: 0.2549019608, alpha: 1)) // #404041
    public static let headerText = Color(#colorLiteral(red: 0.5725490196, green: 0.5803921569, blue: 0.5921568627, alpha: 1)) // #929497
}

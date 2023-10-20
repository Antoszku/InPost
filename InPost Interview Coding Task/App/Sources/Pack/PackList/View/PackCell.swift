import SwiftUI
import UI

extension PackListView {
    struct PackCell: View {
        let presentable: PackPresentable

        var body: some View {
            HStack {
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(PackListAssets.Texts.packageNumber).appFont(.semiBold, size: 11)
                            Text(presentable.packageNumber).appFont(.medium, size: 15)
                        }
                        Spacer()
                        Image("paczkomat", bundle: .module)
                    }
                    VStack(alignment: .leading) {
                        Text(PackListAssets.Texts.status).appFont(.semiBold, size: 11)
                        Text(presentable.status).appFont(.bold, size: 15)
                    }
                    HStack {
                        VStack(alignment: .leading) {
                            Text(PackListAssets.Texts.sender).appFont(.semiBold, size: 11)
                            Text(presentable.sender).appFont(.bold, size: 15)
                        }
                        Spacer()
                        HStack(spacing: 4) {
                            Text(PackListAssets.Texts.more).appFont(.bold, size: 12)
                            PackListAssets.Images.arrow
                        }
                    }
                }.padding(.horizontal, 20)
                Spacer()
            }.padding(.vertical, 16).background(.white)
        }
    }
}

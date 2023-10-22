import SwiftUI
import UI

extension PackListView {
    struct PackCell: View {
        let pack: PackPresentable

        @EnvironmentObject private var viewModel: PackListViewModel

        var body: some View {
            VStack {
                HStack {
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            HeaderValueLabel(header: PackListAssets.Texts.packageNumber, value: pack.packageNumber, valueFont: .medium)
                            Spacer()
                            pack.icon
                        }
                        HStack {
                            HeaderValueLabel(header: PackListAssets.Texts.status, value: pack.status, valueFont: .bold)
                            if let packDateStatus = pack.packDateStatus {
                                Spacer()
                                HeaderValueLabel(header: packDateStatus.title, value: packDateStatus.date, valueFont: .medium, alignment: .trailing)
                            }
                        }
                        HStack {
                            HeaderValueLabel(header: PackListAssets.Texts.sender, value: pack.sender, valueFont: .bold)
                            Spacer()
                            HStack(spacing: 4) {
                                Text(PackListAssets.Texts.more).appFont(.bold, size: 12).foregroundColor(ColorPalette.text)
                                PackListAssets.Images.arrow
                            }
                        }
                        if viewModel.isExpandedPackCell(pack) {
                            HStack {
                                Button {
                                    Task { await viewModel.onArchivePack(pack) }
                                } label: {
                                    Text(PackListAssets.Texts.archive).appFont(.semiBold, size: 15).foregroundStyle(.black).padding(8)
                                }.background(ColorPalette.accentColor)
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

import SwiftUI

extension PackListView.PackCell {
    struct ArchiveView: View {
        @EnvironmentObject private var viewModel: PackListViewModel

        let pack: PackPresentable

        var body: some View {
            if viewModel.isExpandedPackCell(pack) {
                HStack {
                    Button {
                        Task { await viewModel.onArchivePack(pack) }
                    } label: {
                        Text(PackListAssets.Texts.archive)
                            .appFont(.semiBold, size: 15)
                            .foregroundStyle(.black)
                            .padding(8)
                    }
                }.background(ColorPalette.accentColor)
            }
        }
    }
}

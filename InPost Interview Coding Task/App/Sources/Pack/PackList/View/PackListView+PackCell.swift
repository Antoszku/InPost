import SwiftUI

extension PackListView {
    struct PackCell: View {
        let pack: PackPresentable

        var body: some View {
            VStack {
                VStack(alignment: .leading, spacing: 16) {
                    PackageNumberHStack(pack: pack)
                    PackStatusHStack(pack: pack)
                    PackSenderHStack(pack: pack)
                    ArchiveView(pack: pack)
                }.padding(.horizontal, 20)
            }
            .padding(.vertical, 16)
            .background(.white)
            .compositingGroup()
            .padding(.bottom, 8)
            .shadow(color: ColorPalette.shadow, radius: 5, x: 0, y: 10)
        }
    }
}

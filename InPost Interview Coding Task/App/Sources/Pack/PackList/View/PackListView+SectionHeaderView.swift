import SwiftUI

extension PackListView {
    struct SectionHeaderView: View {
        var section: PacksSectionPresentable

        var body: some View {
            HStack(spacing: 16) {
                VStack { Divider().overlay(ColorPalette.sectionHeader) }
                Text(section.name)
                    .foregroundStyle(ColorPalette.sectionHeader)
                    .appFont(.semiBold, size: 13)
                    .layoutPriority(1)
                VStack { Divider().overlay(ColorPalette.sectionHeader) }
            }.padding(.vertical, 16).padding(.horizontal, 20)
        }
    }
}

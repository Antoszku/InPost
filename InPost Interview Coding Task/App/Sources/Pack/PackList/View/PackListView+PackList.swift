import SwiftUI

extension PackListView {
    struct PackList: View {
        @EnvironmentObject private var viewModel: PackListViewModel

        let sections: [PacksSectionPresentable]

        var body: some View {
            ScrollView {
                LazyVStack {
                    ForEach(sections) { section in
                        Section(header: SectionHeaderView(section: section)) {
                            ForEach(section.packs) { pack in
                                PackCell(pack: pack)
                                    .onTapGesture { viewModel.expandedPackCell = pack }
                            }
                        }
                    }
                }
            }.kerning(0.4)
                .refreshable { Task { await viewModel.onPullToRefresh() } }
        }
    }
}

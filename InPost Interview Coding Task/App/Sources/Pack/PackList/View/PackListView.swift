import SwiftUI

struct PackListView: View {
    @StateObject var viewModel: PackListViewModel

    var body: some View {
        VStack {
            switch viewModel.state {
            case .loading: ProgressView().tint(.gray)
            case let .data(sections):
                ScrollView {
                    LazyVStack {
                        ForEach(sections) { section in
                            Section(header: SectionHeaderView(section: section)) {
                                ForEach(section.variations) { pack in
                                    PackCell(pack: pack)
                                        .onTapGesture { viewModel.expandedPackCell = pack }
                                        .animation(.linear(duration: 0.2), value: viewModel.expandedPackCell)
                                }
                            }
                        }
                    }
                }.kerning(0.4)
                    .refreshable { Task { await viewModel.onPullToRefresh() } }
            }

        }.environmentObject(viewModel).frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(ColorPalette.background)

            .onAppear { Task { await viewModel.onAppear() } }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text(PackListAssets.Texts.navigationTitle)
                        .appFont(.bold, size: 15)
                        .kerning(0.4)
                        .foregroundColor(ColorPalette.text)
                }
            }.toolbarBackground(.white, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
    }
}

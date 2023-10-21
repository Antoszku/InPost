import SwiftUI

struct PackListView: View {
    @StateObject var viewModel: PackListViewModel

    var body: some View {
        VStack {
            switch viewModel.state {
            case .loading: ProgressView()
            case let .data(sections):
                ScrollView {
                    LazyVStack {
                        ForEach(sections) { section in
                            Section(header: SectionHeaderView(section: section)) {
                                ForEach(section.variations) { pack in
                                    PackCell(presentable: pack)
                                }
                            }
                        }
                    }
                }.kerning(0.4)
                    .refreshable {
                        Task {
                            await viewModel.onPullToRefresh()
                        }
                    }
            }

        }.background(ColorPalette.background)
            .onAppear {
                Task {
                    await viewModel.onAppear()
                }
            }
    }
}

import SwiftUI

struct PackListView: View {
    @StateObject var viewModel: PackListViewModel

    var body: some View {
        VStack {
            switch viewModel.state {
            case .loading: ProgressView()
            case let .data(packs):
                ScrollView {
                    LazyVStack {
                        ForEach(packs) { pack in
                            PackCell(presentable: pack)
                        }
                    }
                }
            }
        }.background(Color(uiColor: UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1))) // TODO: Change
            .onAppear {
                Task {
                    await viewModel.onAppear()
                }
            }
    }
}

import SwiftUI

// TODO: Remove public properties after adding mainView
public struct PackListView: View {
    public init() {}

    @StateObject var viewModel = PackViewModel()

    public var body: some View {
        VStack {
            switch viewModel.state {
            case .loading: ProgressView()
            case let .data(packs):
                ScrollView {
                    LazyVStack {
                        ForEach(packs) { pack in
                            PackCell(presentable: pack)
                        }
                    }.background(.red)
                }
            }
        }.onAppear {
            Task {
                viewModel.onAppear()
            }
        }
    }
}

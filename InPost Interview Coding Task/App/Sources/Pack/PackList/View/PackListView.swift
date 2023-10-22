import SwiftUI

struct PackListView: View {
    @StateObject var viewModel: PackListViewModel

    var body: some View {
        VStack {
            switch viewModel.state {
            case .loading: ProgressView().tint(.gray)
            case let .data(sections):
                PackList(sections: sections)
            }
        }.environmentObject(viewModel)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
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

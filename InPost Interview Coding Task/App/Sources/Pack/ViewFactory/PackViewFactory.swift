import DI
import SwiftUI

public struct PackViewFactory {
    public var rootView: AnyView { AnyView(makePackList()) }

    public init(resolver: Resolver) {
        self.resolver = resolver
    }

    private let resolver: Resolver

    private func makePackList() -> PackListView {
        let interactor = resolver.resolve(PackListInteractor.self)
        let viewModel = PackListViewModel(interactor: interactor)
        return PackListView(viewModel: viewModel)
    }
}

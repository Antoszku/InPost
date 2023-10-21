import DI
import Pack
import SwiftUI

public struct MainView: View {
    @State var path = NavigationPath()

    private let packViewFactory: PackViewFactory

    public init(resolver: Resolver) {
        packViewFactory = PackViewFactory(resolver: resolver)
    }

    public var body: some View {
        NavigationStack(path: $path) { packViewFactory.rootView }
    }
}

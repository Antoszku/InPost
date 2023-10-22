import DI

public struct NetworkingAssembler {
    private enum MockFile: String {
        case packs
        case packsWithMultipleStatuses
        case packsWithRandomOrderToCheckSorting
        case thousandPacksToCheckPerformance
    }

    @discardableResult
    public init(resolver: Resolver) {
        resolver.register(APIClient.self) { _ in
            MockApiClient(fileName: MockFile.packs.rawValue)
        }
//        resolver.register(APIClient.self, initializer: DefaultApiClient.init) // TODO: Explain in documentation
    }
}

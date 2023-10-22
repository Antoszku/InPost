import DI

public struct NetworkingAssembler {
    enum MockFile: String {
        case packs
        case multipleStatuses
    }

    @discardableResult
    public init(resolver: Resolver) {
        resolver.register(APIClient.self) { _ in
            MockApiClient(fileName: MockFile.packs.rawValue)
        }
//        resolver.register(APIClient.self, initializer: DefaultApiClient.init) // TODO: Explain in documentation
    }
}

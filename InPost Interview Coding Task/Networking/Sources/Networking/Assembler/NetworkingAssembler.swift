import DI

public struct NetworkingAssembler {
    @discardableResult
    public init(resolver: Resolver) {
        resolver.register(APIClient.self, initializer: MockApiClient.init)
//        resolver.register(APIClient.self, initializer: DefaultApiClient.init) // TODO: Explain in documentation
    }
}

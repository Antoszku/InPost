import DI

public struct PackAssembler {
    @discardableResult
    public init(resolver: Resolver) {
        resolver.register(PackListInteractor.self, initializer: DefaultPackListInteractor.init)
    }
}

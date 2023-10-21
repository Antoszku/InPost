import DI

public struct PackServiceAssembler {
    @discardableResult
    public init(resolver: Resolver) {
        resolver.register(PackService.self, initializer: DefaultPackService.init)
    }
}

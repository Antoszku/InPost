import Swinject
import SwinjectAutoregistration

public struct Resolver {
    private let container = Container()

    public init() {}

    public func resolve<T>(_: T.Type) -> T {
        container.resolve(T.self)!
    }

    // MARK: Autoregister

    public func register<T>(_ type: T.Type, initializer: @escaping (() -> T)) {
        container.autoregister(type, initializer: initializer)
    }

    public func register<T, A>(_ type: T.Type, initializer: @escaping ((A) -> T)) {
        container.autoregister(type, initializer: initializer)
    }

    public func register<T, A, B>(_ type: T.Type, initializer: @escaping ((A, B) -> T)) {
        container.autoregister(type, initializer: initializer)
    }

    // MARK: Register

    public func register<T>(_ type: T.Type, initializer: @escaping ((Swinject.Resolver) -> T)) {
        container.register(type, factory: initializer)
    }
}

import DI
import Pack

public struct AppAssembler {
    @discardableResult
    public init(resolver: Resolver) {
        PackAssembler(resolver: resolver)
    }
}

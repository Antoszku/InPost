import DI
import Networking
import PackService

public struct DomainAssembler {
    @discardableResult
    public init(resolver: Resolver) {
        PackServiceAssembler(resolver: resolver)
        NetworkingAssembler(resolver: resolver)
    }
}

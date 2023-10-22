import DI
import Foundation

public struct DataStorageAssembler {
    @discardableResult
    public init(resolver: Resolver) {
        resolver.register(DataStorage.self) { _ in
            DefaultDataStorage(defaults: UserDefaults.standard)
        }
    }
}

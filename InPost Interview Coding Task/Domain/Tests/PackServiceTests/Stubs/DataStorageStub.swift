@testable import DataStorage

final class DataStorageStub: DataStorage {
    var addValueToSetCalled: (String, DataStorageKey)?
    var getStringSetCalledWithKey: DataStorageKey?

    func addValueToSet(_ value: String, forKey key: DataStorageKey) {
        addValueToSetCalled = (value, key)
    }

    func getStringSet(forKey key: DataStorageKey) -> Set<String> {
        getStringSetCalledWithKey = key
        return []
    }
}

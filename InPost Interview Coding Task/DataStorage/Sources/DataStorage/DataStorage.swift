import Foundation

public protocol DataStorage {
    func addValueToSet(_ value: String, forKey key: DataStorageKey)
    func getStringSet(forKey key: DataStorageKey) -> Set<String>
}

struct DefaultDataStorage: DataStorage {
    let defaults: UserDefaultsProtocol

    func getStringSet(forKey key: DataStorageKey) -> Set<String> {
        guard let ArrayOfStrings = defaults.stringArray(forKey: key.rawValue) else { return [] }

        return Set(ArrayOfStrings)
    }

    func addValueToSet(_ value: String, forKey key: DataStorageKey) {
        var stringSet: Set<String>

        if let existingSet = defaults.stringArray(forKey: key.rawValue) {
            stringSet = Set(existingSet)
        } else {
            stringSet = Set<String>()
        }

        stringSet.insert(value)

        defaults.set(Array(stringSet), forKey: key.rawValue)
    }
}

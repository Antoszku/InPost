@testable import DataStorage

class UserDefaultsStub: UserDefaultsProtocol {
    var stringArrayCalledWithKey: String?
    var stringArrayReturn: [String]?

    var setCalledWithValues: (String, [String])?

    func stringArray(forKey key: String) -> [String]? {
        stringArrayCalledWithKey = key
        return stringArrayReturn
    }

    func set(_ newValue: Any?, forKey key: String) {
        if let value = newValue as? [String] {
            setCalledWithValues = (key, value)
        }
    }
}

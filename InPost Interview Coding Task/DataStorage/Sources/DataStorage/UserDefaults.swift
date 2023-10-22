import Foundation

public protocol UserDefaultsProtocol {
    func stringArray(forKey: String) -> [String]?
    func set(_ newValue: Any?, forKey: String)
}

extension UserDefaults: UserDefaultsProtocol {}

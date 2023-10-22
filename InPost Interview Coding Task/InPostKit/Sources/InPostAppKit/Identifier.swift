import Foundation

public struct Identifier<T>: Equatable, Hashable {
    public let value: String

    public init(_ value: String) {
        self.value = value
    }
}

extension Identifier: Comparable {
    public static func < (lhs: Identifier<T>, rhs: Identifier<T>) -> Bool {
        lhs.value < rhs.value
    }

    public static func > (lhs: Identifier<T>, rhs: Identifier<T>) -> Bool {
        lhs.value > rhs.value
    }

    public static func == (lhs: Identifier<T>, rhs: Identifier<T>) -> Bool {
        lhs.value == rhs.value
    }
}

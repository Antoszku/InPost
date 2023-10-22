// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "DataStorage",
    platforms: [.iOS(.v16)],
    products: [
        .library(target: .DataStorage),
    ],
    dependencies: [
        .package(.InPostKit),
    ],
    targets: [
        .target(name: .DataStorage, dependencies: [.DI]),
        .testTarget(name: .DataStorageTests, dependencies: [.DataStorage]),
    ]
)

enum Targets: String {
    case DataStorage
    case DataStorageTests
}

enum Dependencies: String {
    // Data Storage
    case DataStorage

    // InPostKit
    case DI

    func dependency() -> Target.Dependency {
        switch self {
        // Data Storage
        case .DataStorage:
            Target.Dependency(self)
        // InPostKit
        case .DI:
            Target.Dependency(self, package: .InPostKit)
        }
    }
}

enum Packages: String {
    case InPostKit
}

extension Target {
    static func target(name: Targets,
                       dependencies: [Dependencies] = [],
                       resources: [Resource]? = nil) -> Target {
        .target(name: name.rawValue,
                dependencies: dependencies.map { $0.dependency() },
                path: "Sources/\(name)",
                resources: resources)
    }

    static func testTarget(name: Targets,
                           dependencies: [Dependencies] = [],
                           resources: [Resource]? = nil) -> Target {
        .testTarget(name: name.rawValue,
                    dependencies: dependencies.map { $0.dependency() },
                    path: "Tests/\(name)",
                    resources: resources)
    }
}

extension Target.Dependency {
    init(_ target: Dependencies) {
        self.init(stringLiteral: target.rawValue)
    }

    init(_ target: Dependencies, package: Packages) {
        self = Self.product(name: target.rawValue, package: package.rawValue)
    }
}

extension Product {
    static func library(target: Targets) -> PackageDescription.Product {
        library(name: target.rawValue, targets: [target.rawValue])
    }

    static func library(target: Targets, targets: [Targets]) -> PackageDescription.Product {
        library(name: target.rawValue, targets: targets.map(\.rawValue))
    }
}

extension Package.Dependency {
    static func package(_ package: Packages) -> Package.Dependency {
        Self.package(name: package.rawValue, path: "../\(package.rawValue)")
    }
}

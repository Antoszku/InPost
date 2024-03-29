// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "Domain",
    platforms: [.iOS(.v16)],
    products: [
        .library(target: .Domain),
        .library(target: .PackService),
    ],
    dependencies: [
        .package(.InPostKit),
        .package(.Networking),
        .package(.DataStorage),
    ],
    targets: [
        .target(name: .Domain, dependencies: [.PackService]),
        .target(name: .PackService, dependencies: [.DI, .DomainKit, .Networking, .DataStorage]),
        .testTarget(name: .PackServiceTests, dependencies: [.PackService]),
    ]
)

enum Targets: String {
    case Domain
    case PackService
    case PackServiceTests
}

enum Dependencies: String {
    // Domain
    case PackService

    // InPostKit
    case DomainKit
    case DI

    // Networking
    case Networking

    // DataStorage
    case DataStorage

    func dependency() -> Target.Dependency {
        switch self {
        // Domain
        case .PackService:
            Target.Dependency(self)
        // DI
        case .DomainKit, .DI:
            Target.Dependency(self, package: .InPostKit)

        // Networking
        case .Networking:
            Target.Dependency(self, package: .Networking)

        // DataStorage
        case .DataStorage:
            Target.Dependency(self, package: .DataStorage)
        }
    }
}

enum Packages: String {
    case InPostKit
    case Networking
    case DataStorage
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

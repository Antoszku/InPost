// swift-tools-version: 5.8

import PackageDescription

let package = Package(
    name: "App",
    platforms: [.iOS(.v16)],
    products: [
        .library(target: .App),
        .library(target: .Pack),
    ],
    dependencies: [
        .package(.Domain),
        .package(.InPostKit),
    ],
    targets: [
        .target(name: .App, dependencies: [.Pack]),
        .target(name: .Pack, dependencies: [.PackService, .DI, .UI], resources: [.process("Pack.xcassets")]),
        .testTarget(name: .PackTests, dependencies: [.Pack]),
    ]
)

enum Targets: String {
    case App
    case Pack
    case PackTests
}

enum Dependencies: String {
    // App
    case Pack

    // Domain
    case PackService
    // InPostKit
    case UI
    case DI

    func dependency() -> Target.Dependency {
        switch self {
        // App
        case .Pack:
            return Target.Dependency(self)

        // Domain
        case .PackService:
            return Target.Dependency(self, package: .Domain)

        case .UI, .DI:
            return Target.Dependency(self, package: .InPostKit)
        }
    }
}

enum Packages: String {
    case Domain
    case DI
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

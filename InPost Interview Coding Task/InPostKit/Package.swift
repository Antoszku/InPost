// swift-tools-version: 5.8

import PackageDescription

let package = Package(
    name: "InPostKit",
    platforms: [.iOS(.v16)],
    products: [
        .library(target: .UI),
        .library(target: .DomainKit),
        .library(target: .DI),
    ],
    dependencies: [
        .package(url: "https://github.com/Swinject/SwinjectAutoregistration.git", from: "2.8.3"),
    ],
    targets: [
        .target(name: .UI, resources: [.process("Resources")]),
        .target(name: .DomainKit),
        .target(name: .DI, dependencies: [.SwinjectAutoregistration]),
    ]
)

enum Targets: String {
    case UI
    case DomainKit
    case DI
}

enum Dependencies: String {
    case SwinjectAutoregistration

    func dependency() -> Target.Dependency {
        switch self {
        case .SwinjectAutoregistration:
            return Target.Dependency(self)
        }
    }
}

enum Packages: String {
    case Foo
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

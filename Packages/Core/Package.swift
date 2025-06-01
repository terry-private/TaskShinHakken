// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Core",
    platforms: [
        .iOS("18.0")
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Entity",
            targets: ["Entity"]),
        .library(
            name: "ProductAppFeature",
            targets: ["ProductAppFeature"]),
        .library(
            name: "TaskFeature",
            targets: ["TaskFeature"]),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "1.20.2"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Entity",
            swiftSettings: [
                .enableUpcomingFeature("BareSlashRegexLiterals"),
                .enableUpcomingFeature("ConciseMagicFile"),
                .enableUpcomingFeature("ExistentialAny"),
                .enableUpcomingFeature("ForwardTrailingClosures"),
                .enableUpcomingFeature("ImplicitOpenExistentials"),
                .enableUpcomingFeature("StrictConcurrency"),
                .unsafeFlags(["-enable-actor-data-race-checks"], .when(configuration: .debug)),
            ]
        ),
        .target(
            name: "ProductAppFeature",
            dependencies: [
                "Entity",
                "TaskFeature",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
            ],
            path: "./Sources/Features/ProductAppFeature",
            swiftSettings: [
                .enableUpcomingFeature("BareSlashRegexLiterals"),
                .enableUpcomingFeature("ConciseMagicFile"),
                .enableUpcomingFeature("ExistentialAny"),
                .enableUpcomingFeature("ForwardTrailingClosures"),
                .enableUpcomingFeature("ImplicitOpenExistentials"),
                .enableUpcomingFeature("StrictConcurrency"),
                .unsafeFlags(["-enable-actor-data-race-checks"], .when(configuration: .debug)),
            ]
        ),
        .target(
            name: "TaskFeature",
            dependencies: [
                "Entity",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
            ],
            path: "./Sources/Features/TaskFeature",
            swiftSettings: [
                .enableUpcomingFeature("BareSlashRegexLiterals"),
                .enableUpcomingFeature("ConciseMagicFile"),
                .enableUpcomingFeature("ExistentialAny"),
                .enableUpcomingFeature("ForwardTrailingClosures"),
                .enableUpcomingFeature("ImplicitOpenExistentials"),
                .enableUpcomingFeature("StrictConcurrency"),
                .unsafeFlags(["-enable-actor-data-race-checks"], .when(configuration: .debug)),
            ]
        ),
        .testTarget(
            name: "EntityTests",
            dependencies: ["Entity"]
        ),
    ]
)

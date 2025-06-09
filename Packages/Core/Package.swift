// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Core",
    platforms: [
        .iOS("18.0"),
        .macOS("10.15")
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "CoreClient",
            targets: ["CoreClient"]),
        .library(
            name: "CoreClientProduct",
            targets: ["CoreClientProduct"]),

        .library(
            name: "Entity",
            targets: ["Entity"]),

        // MARK: - Features

        .library(
            name: "AuthFeature",
            targets: ["AuthFeature"]),
        .library(
            name: "HomeFeature",
            targets: ["HomeFeature"]),
        .library(
            name: "ProductAppFeature",
            targets: ["ProductAppFeature"]),
        .library(
            name: "SettingsFeature",
            targets: ["SettingsFeature"]),
        .library(
            name: "TaskFeature",
            targets: ["TaskFeature"]),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "1.20.2"),
        .package(url: "https://github.com/firebase/firebase-ios-sdk.git", from: "11.14.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "CoreClient",
            dependencies: [
                "Entity",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
            ]
        ),
        .target(
            name: "CoreClientProduct",
            dependencies: [
                "CoreClient",
                "Entity",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
                .product(name: "FirebaseAuth", package: "firebase-ios-sdk"),
                .product(name: "FirebaseCore", package: "firebase-ios-sdk"),
            ]
        ),

        .target(
            name: "Entity"
        ),

        // MARK: - Features

        .target(
            name: "AuthFeature",
            dependencies: [
                "CoreClient",
                "Entity",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
            ],
            path: "./Sources/Features/AuthFeature"
        ),

        .target(
            name: "HomeFeature",
            dependencies: [
                "Entity",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
            ],
            path: "./Sources/Features/HomeFeature"
        ),
        .target(
            name: "ProductAppFeature",
            dependencies: [
                "CoreClient",
                "CoreClientProduct",
                "Entity",
                "AuthFeature",
                "HomeFeature",
                "TaskFeature",
                "SettingsFeature",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
            ],
            path: "./Sources/Features/ProductAppFeature"
        ),
        .target(
            name: "SettingsFeature",
            dependencies: [
                "Entity",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
            ],
            path: "./Sources/Features/SettingsFeature"
        ),
        .target(
            name: "TaskFeature",
            dependencies: [
                "Entity",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
            ],
            path: "./Sources/Features/TaskFeature"
        ),
        .testTarget(
            name: "EntityTests",
            dependencies: ["Entity"]
        ),
    ]
)

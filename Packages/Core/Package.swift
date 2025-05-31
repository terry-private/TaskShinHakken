// swift-tools-version: 6.0
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
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Entity"),
        .target(
            name: "ProductAppFeature",
            dependencies: [
                "Entity",
                "TaskFeature"
            ],
            path: "./Sources/Features/ProductAppFeature"
        ),
        .target(
            name: "TaskFeature",
            dependencies: ["Entity"],
            path: "./Sources/Features/TaskFeature"
        ),
        .testTarget(
            name: "EntityTests",
            dependencies: ["Entity"]
        ),
    ]
)

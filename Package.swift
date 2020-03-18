// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SimpleStore",
    platforms: [
        .macOS(.v10_13),
        .iOS(.v9),
        .watchOS(.v5)
    ],
    products: [
        .library(
            name: "SimpleStore",
            targets: ["SimpleStore"]),
    ],
    targets: [
        .target(
            name: "SimpleStore",
            dependencies: [],
            path: "SimpleStore"),
        .testTarget(
            name: "SimpleStoreTests",
            dependencies: ["SimpleStore"],
            path: "SimpleStoreTests"),
    ],
    swiftLanguageVersions: [
        .v5
    ]
)

// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Presentation",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "Presentation",
            targets: ["Presentation"])
    ],
    dependencies: [
            .package(path: "../Core"),
            .package(path: "../Domain"),
            .package(path: "../Data"),
            .package(path: "../Navigation")
        ],
    targets: [
        .target(
            name: "Presentation",
            dependencies: ["Core", "Domain", "Data", "Navigation"]),
        .testTarget(
            name: "PresentationTests",
            dependencies: ["Presentation"]
        )
    ]
)

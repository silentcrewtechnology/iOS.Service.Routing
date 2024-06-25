// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "Router",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(
            name: "Router",
            targets: ["Router"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "Router",
            dependencies: []),
    ]
)

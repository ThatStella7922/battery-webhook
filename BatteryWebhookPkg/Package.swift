// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BatteryWebhookPkg",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "BatteryWebhook",
            targets: ["BatteryWebhook"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "BatteryWebhookCore"),
        .target(
            name: "BatteryWebhook", dependencies: ["BatteryWebhookCore"]),
        .testTarget(
            name: "BatteryWebhookTests",
            dependencies: ["BatteryWebhook"]),
    ]
)

// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftUISpellBook",
    products: [
        .library(
            name: "SwiftUISpellBook",
            targets: ["SwiftUISpellBook"]
        ),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "SwiftUISpellBook",
            dependencies: []
        ),
        .testTarget(
            name: "SwiftUISpellBookTests",
            dependencies: ["SwiftUISpellBook"]
        ),
    ]
)

// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftUISpellBook",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
        .watchOS(.v6),
        .tvOS(.v13)
    ],
    products: [
        .library(
            name: "AllSwiftUISpellBooks",
            targets: ["AllSwiftUISpellBooks"]
        ),
        .library(
            name: "SwiftUIDebugToolsSpellBook",
            targets: ["SwiftUIDebugToolsSpellBook"]
        ),
        .library(
            name: "SwiftUISpellBook",
            targets: ["SwiftUISpellBook"]
        ),
        .library(
            name: "SwiftUIPopNavigationSpellBook",
            targets: ["SwiftUIPopNavigationSpellBook"]
        ),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "AllSwiftUISpellBooks",
            dependencies: [
                .target(name: "SwiftUIDebugToolsSpellBook"),
                .target(name: "SwiftUISpellBook"),
                .target(name: "SwiftUIPopNavigationSpellBook"),
            ]
        ),
        .target(
            name: "SwiftUIDebugToolsSpellBook",
            dependencies: []
        ),
        .target(
            name: "SwiftUISpellBook",
            dependencies: []
        ),
        .target(
            name: "SwiftUIPopNavigationSpellBook",
            dependencies: []
        ),
    ]
)

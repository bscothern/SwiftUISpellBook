// swift-tools-version:5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftUISpellBook",
    platforms: [
        .iOS(.v15),
        .macOS(.v12),
        .tvOS(.v15),
        .watchOS(.v8),
    ],
    products: [
        .library(
            name: "SwiftUISpellBook",
            targets: ["SwiftUISpellBook"]
        ),
        .library(
            name: "SwiftUIBundleFinder",
            targets: ["SwiftUIBundleFinder"]
        ),
        .library(
            name: "SwiftUICommonSpellBook",
            targets: ["SwiftUICommonSpellBook"]
        ),
        .library(
            name: "SwiftUIDebugToolsSpellBook",
            targets: ["SwiftUIDebugToolsSpellBook"]
        ),
        .library(
            name: "SwiftUILocalizationSpellBook",
            targets: ["SwiftUILocalizationSpellBook"]
        ),
        .library(
            name: "SwiftUIMissingComponentsSpellBook",
            targets: ["SwiftUIMissingComponentsSpellBook"]
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
            name: "SwiftUISpellBook",
            dependencies: [
                .target(name: "SwiftUIBundleFinder"),
                .target(name: "SwiftUICommonSpellBook"),
                .target(name: "SwiftUIDebugToolsSpellBook"),
                .target(name: "SwiftUILocalizationSpellBook"),
                .target(name: "SwiftUIMissingComponentsSpellBook"),
                .target(name: "SwiftUIPopNavigationSpellBook"),
            ]
        ),
        .target(
            name: "SwiftUIBundleFinder"
        ),
        .target(
            name: "SwiftUICommonSpellBook",
            dependencies: [
                .target(name: "SwiftUIMissingComponentsSpellBook"),
            ]
        ),
        .target(
            name: "SwiftUIDebugToolsSpellBook",
            dependencies: [
                .target(name: "SwiftUICommonSpellBook"),
                .target(name: "SwiftUIMissingComponentsSpellBook"),
            ]
        ),
        .target(
            name: "SwiftUILocalizationSpellBook"
        ),
        .target(
            name: "SwiftUIMissingComponentsSpellBook",
            dependencies: []
        ),
        .target(
            name: "SwiftUIPopNavigationSpellBook",
            dependencies: [
                .target(name: "SwiftUIMissingComponentsSpellBook"),
            ]
        ),
    ]
)

// swift-tools-version:6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftUISpellBook",
    platforms: [
        .iOS(.v15),
        .macOS(.v13),
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
            name: "SwiftUILocalizationSpellBook",
            targets: ["SwiftUILocalizationSpellBook"]
        ),
        .library(
            name: "SwiftUIMissingComponentsSpellBook",
            targets: ["SwiftUIMissingComponentsSpellBook"]
        ),
        .library(
            name: "SwiftUIGlassOS26SpellBook",
            targets: ["SwiftUIGlassOS26SpellBook"]
        )
    ],
    traits: [
        "GlassCompatibliity",
        .default(enabledTraits: ["GlassCompatibliity"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "SwiftUISpellBook",
            dependencies: [
                .target(name: "SwiftUIBundleFinder"),
                .target(name: "SwiftUICommonSpellBook"),
                .target(name: "SwiftUILocalizationSpellBook"),
                .target(name: "SwiftUIMissingComponentsSpellBook"),
                .target(name: "SwiftUIGlassOS26SpellBook"),
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
            name: "SwiftUILocalizationSpellBook"
        ),
        .target(
            name: "SwiftUIMissingComponentsSpellBook",
        ),
        .target(
            name: "SwiftUIGlassOS26SpellBook"
        ),
    ]
)

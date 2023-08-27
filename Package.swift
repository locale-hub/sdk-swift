// swift-tools-version: 5.8

import PackageDescription

let package = Package(
    name: "LocaleHub",
    platforms: [.iOS(.v16), .macOS(.v13)],
    products: [
        .library(
            name: "LocaleHubSDK",
            targets: [
                "LocaleHubSDK",
                "LocaleHubTranslationEngine",
                "LocaleHubTranslationModel",
            ]
        ),
        .library(
            name: "LocaleHubTranslationEngine",
            targets: [
                "LocaleHubTranslationEngine",
            ]
        ),
        .library(
            name: "LocaleHubTranslationModel",
            targets: [
                "LocaleHubTranslationModel",
            ]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-collections.git", .upToNextMinor(from: "1.0.0")),
    ],
    targets: [
        .target(
            name: "LocaleHubSDK",
            dependencies: [
                "LocaleHubTranslationModel",
                "LocaleHubTranslationEngine",
            ]
        ),
        .target(
            name: "LocaleHubTranslationModel",
            dependencies: [
                .product(name: "OrderedCollections", package: "swift-collections"),
            ]
        ),
        .target(
            name: "LocaleHubTranslationEngine",
            dependencies: [
                "LocaleHubTranslationModel",
            ]
        ),
    ]
)

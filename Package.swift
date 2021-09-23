// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UIPreviewCatalog",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15)
    ],
    products: [
        .library(
            name: "UIPreviewCatalog",
            targets: ["UIPreviewCatalog"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "MarkdownGenerator",
            dependencies: []),
        .target(
            name: "UIPreviewCatalog",
            dependencies: [
                "MarkdownGenerator",
            ]),
        
        .testTarget(
            name: "UIPreviewCatalogTests",
            dependencies: ["UIPreviewCatalog"]),
        .testTarget(
            name: "MarkdownGeneratorTests",
            dependencies: ["MarkdownGenerator"]),
    ]
)

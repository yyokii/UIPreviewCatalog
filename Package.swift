// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UIPreviewCatalog",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "UIPreviewCatalog",
            targets: ["SnapshotFeature"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "SnapshotFeature",
            dependencies: []),
        
        .testTarget(
            name: "SnapshotFeatureTests",
            dependencies: ["SnapshotFeature"]),
    ]
)

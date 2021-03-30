// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "RickAndMortyAPI",
    platforms: [.macOS(.v10_14), .iOS(.v13)],
    products: [
        .library(
            name: "RickAndMortyAPI",
            targets: ["RickAndMortyAPI"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "RickAndMortyAPI",
            dependencies: []),
        .testTarget(
            name: "RickAndMortyAPITests",
            dependencies: ["RickAndMortyAPI"]),
    ]
)

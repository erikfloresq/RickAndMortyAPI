// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "RickAndMortyAPI",
    platforms: [.macOS(.v10_15), .iOS(.v13), .tvOS(.v13), .watchOS(.v6)],
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

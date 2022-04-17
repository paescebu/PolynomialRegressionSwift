// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PolynomialRegressionSwift",
    platforms: [
        .iOS(.v15),
        .macOS(.v12)
    ],
    products: [
        .library(
            name: "PolynomialRegressionSwift",
            targets: ["PolynomialRegressionSwift"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "PolynomialRegressionSwift",
            dependencies: []),
        .testTarget(
            name: "PolynomialRegressionSwiftTests",
            dependencies: ["PolynomialRegressionSwift"]),
    ]
)

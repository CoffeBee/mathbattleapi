// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "mathbattleapi",
    platforms: [
        .macOS("10.15"),
    ],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            
            name: "mathbattleapi",
            targets: ["mathbattleapi"]),
        
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/websocket-kit.git", from: "2.0.0"),
        .package(url: "https://github.com/swift-server/async-http-client.git", from: "1.0.0")
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "mathbattleapi",
            
            dependencies: [
                .product(name: "WebSocketKit", package: "websocket-kit"),
                .product(name: "AsyncHTTPClient", package: "async-http-client")
                    ]
        ),
        .testTarget(
            name: "mathbattleapiTests",
            dependencies: ["mathbattleapi"]),
    ]
)

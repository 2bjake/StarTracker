// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "StarTracker",
    platforms: [.macOS(.v12)],
    dependencies: [
      .package(url: "https://github.com/2bjake/StarCoordinates", revision: "3b28965acfb75ee628e519629b4c159d1eaed35d")
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .executableTarget(
            name: "StarTracker",
            dependencies: ["StarCoordinates"]),
        .testTarget(
            name: "StarTrackerTests",
            dependencies: ["StarTracker"]),
    ]
)

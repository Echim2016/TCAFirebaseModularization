// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "ModuleDemoApp",
  platforms: [
    .iOS(.v18),
  ],
  products: [
    // Products define the executables and libraries a package produces, making them visible to other packages.
    .library(name: "App", targets: ["App"]),
    .library(name: "Home", targets: ["Home"]),
    .library(name: "Settings", targets: ["Settings"]),
    .library(name: "FirebaseClient", targets: ["FirebaseClient"]),
    .library(name: "FirebaseClientLive", targets: ["FirebaseClientLive"]),
  ],
  dependencies: [
    .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "1.19.1"),
    .package(url: "https://github.com/firebase/firebase-ios-sdk", from: "11.12.0"),
  ],
  targets: [
    .target(
      name: "App",
      dependencies: [
        .tca,
        "Home",
        "Settings",
      ]
    ),
    .target(
      name: "Home",
      dependencies: [
        .tca,
      ]
    ),
    .target(
      name: "Settings",
      dependencies: [
        .tca,
        "FirebaseClient",
      ]
    ),
    .target(
      name: "FirebaseClient",
      dependencies: [
        .tca,
      ]
    ),
    .target(
      name: "FirebaseClientLive",
      dependencies: [
        .tca,
        .firebaseFirestore,
        "FirebaseClient",
      ]
    ),
  ]
)

extension Target.Dependency {
  static let tca = Self.product(name: "ComposableArchitecture", package: "swift-composable-architecture")
  static let firebaseFirestore = Self.product(name: "FirebaseFirestore", package: "firebase-ios-sdk")
//  static let firebaseAnalytics = Self.product(name: "FirebaseAnalytics", package: "firebase-ios-sdk")
//  static let firebaseCrashlytics = Self.product(name: "FirebaseCrashlytics", package: "firebase-ios-sdk")
}

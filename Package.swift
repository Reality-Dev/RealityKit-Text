// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

import PackageDescription

let package = Package(
  name: "TextEntity",
  platforms: [.iOS("13.0")],
  products: [
    .library(name: "TextEntity", targets: ["TextEntity"])
  ],
  dependencies: [],
  targets: [
    .target(name: "TextEntity", dependencies: [])
  ],
  swiftLanguageVersions: [.v5]
)

import ProjectDescription
import ProjectDescriptionHelpers

let dependencies = Dependencies(
  carthage: nil,
  swiftPackageManager: SwiftPackageManagerDependencies([
    .remote(url: "https://github.com/SnapKit/SnapKit", requirement: .exact("5.6.0")),
    .remote(url: "https://github.com/DevYeom/ModernRIBs", requirement: .exact("1.0.2")),
    .remote(url: "https://github.com/CombineCommunity/CombineExt", requirement: .exact("1.8.1")),
  ]),
  platforms: [.iOS])

import ProjectDescription
import ProjectDescriptionHelpers

let pack = SwiftPackageManagerDependencies([
  .remote(url: "https://github.com/SnapKit/SnapKit", requirement: .exact("5.6.0")),
  .remote(url: "https://github.com/DevYeom/ModernRIBs", requirement: .exact("1.0.2")),
  .remote(url: "https://github.com/devxoul/Then", requirement: .exact("3.0.0")),
  .remote(url: "https://github.com/CombineCommunity/CombineCocoa", requirement: .exact("0.4.1"))
])

let dependencies = Dependencies(
  carthage: nil,
  swiftPackageManager: pack,
  platforms: [.iOS])

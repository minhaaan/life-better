import ProjectDescription
import ProjectDescriptionHelpers

/*
                +-------------+
                |             |
                |     App     | Contains LifeBetter App target and LifeBetter unit-test target
                |             |
         +------+-------------+-------+
         |         depends on         |
         |                            |
 +----v-----+                   +-----v-----+
 |          |                   |           |
 |   Kit    |                   |     UI    |   Two independent frameworks to share code and start modularising your app
 |          |                   |           |
 +----------+                   +-----------+

 */

// MARK: - Project

// Creates our project using a helper function defined in ProjectDescriptionHelpers

let appTarget = Target(
  name: "LifeBetter",
  platform: .iOS,
  product: .app,
  productName: "LifeBetter",
  bundleId: "com.minan.LifeBetter",
  deploymentTarget: .iOS(targetVersion: "16.1", devices: [.iphone]),
  infoPlist: .default,
  sources: ["Sources/**"],
  resources: ["Resources/**"],
  scripts: [],
  dependencies: [],
  settings: nil,
  environment: [:]
)

let testTarget = Target(
  name: "LifeBetterTests",
  platform: .iOS,
  product: .unitTests,
  productName: "LifeBetterTests",
  bundleId: "com.minan.LifeBetterTests",
  deploymentTarget: .iOS(targetVersion: "16.1", devices: [.iphone]),
  infoPlist: .default,
  sources: ["Tests/**"],
  dependencies: [],
  settings: nil
)

let project = Project(
  name: "LifeBetter",
  organizationName: "com.minan",
  packages: [],
  settings: nil,
  targets: [appTarget, testTarget]
)

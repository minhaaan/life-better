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

let project = Project(
  name: "LifeBetter",
  organizationName: "com.minan",
  packages: [],
  settings: nil,
  targets: Project.makeAppTargets(name: "LifeBetter", dependencies: [])
)

import ProjectDescription
import ProjectDescriptionHelpers

// MARK: Project

let utilsDependencies: [TargetDependency] = [
  .ModernRibs,
  .SwiftyBeaver
]

let project = Project(
  name: "Utils",
  organizationName: "com.minan",
  packages: [],
  targets: Project.makeFrameworkTargets(
    name: "Utils",
    isDynamic: true,
    dependencies: utilsDependencies
  ),
  schemes: [.makeScheme(name: "Utils")]
)

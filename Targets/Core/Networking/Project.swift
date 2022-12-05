import ProjectDescription
import ProjectDescriptionHelpers

// MARK: Project

let utilsDependencies: [TargetDependency] = [
  .platform.utils
]

let project = Project(
  name: "Networking",
  organizationName: "com.minan",
  packages: [],
  targets: Project.makeFrameworkTargets(
    name: "Networking",
    isDynamic: true,
    dependencies: utilsDependencies
  ),
  schemes: [.makeScheme(name: "Networking")]
)

import ProjectDescription
import ProjectDescriptionHelpers

// MARK: Project

let utilsDependencies: [TargetDependency] = [
]

let project = Project(
  name: "Network",
  organizationName: "com.minan",
  packages: [],
  targets: Project.makeFrameworkTargets(
    name: "Network",
    isDynamic: true,
    dependencies: utilsDependencies
  )
)

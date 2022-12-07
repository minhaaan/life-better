import ProjectDescription
import ProjectDescriptionHelpers

// MARK: Project

let subwayWidgetCoreDependencies: [TargetDependency] = [
]

let project = Project(
  name: "SubwayWidgetCore",
  organizationName: "com.minan",
  packages: [],
  targets: Project.makeFrameworkTargets(
    name: "SubwayWidgetCore",
    isDynamic: true,
    dependencies: subwayWidgetCoreDependencies
  ),
  schemes: [.makeScheme(name: "SubwayWidgetCore")]
)

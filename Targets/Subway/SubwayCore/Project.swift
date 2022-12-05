import ProjectDescription
import ProjectDescriptionHelpers

let subwayCoreDependencies: [TargetDependency] = [
]

let project = Project(
  name: "SubwayCore",
  organizationName: "com.minan",
  packages: [],
  targets: Project.makeFrameworkTargets(
    name: "SubwayCore",
    isDynamic: true,
    dependencies: subwayCoreDependencies
  ),
  schemes: [.makeScheme(name: "SubwayCore")]
)

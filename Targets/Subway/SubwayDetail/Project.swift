import ProjectDescription
import ProjectDescriptionHelpers

let subwayCoreDependencies: [TargetDependency] = [
  .platform.utils,
  .feature.subwayCore,
  .feature.subwayNetworking,
  .SnapKit
]

let project = Project(
  name: "SubwayDetail",
  organizationName: "com.minan",
  packages: [],
  targets: Project.makeFrameworkTargets(
    name: "SubwayDetail",
    isDynamic: false,
    dependencies: subwayCoreDependencies
  ),
  schemes: [.makeScheme(name: "SubwayDetail")]
)

import ProjectDescription
import ProjectDescriptionHelpers

let subwayDependencies: [TargetDependency] = [
  .SnapKit,
  .CombineCocoa,
  .platform.utils,
  .feature.subwayNetworking,
  .feature.subwayCore,
  .feature.subwayDetail
]

let project = Project(
  name: "Subway",
  organizationName: "com.minan",
  packages: [],
  targets: Project.makeFrameworkTargets(
    name: "Subway",
    isDynamic: false,
    dependencies: subwayDependencies
  ),
  schemes: [
    .makeScheme(name: "Subway")
  ]
)


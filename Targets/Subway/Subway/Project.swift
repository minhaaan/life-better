import ProjectDescription
import ProjectDescriptionHelpers

let subwayDependencies: [TargetDependency] = [
  .SnapKit,
  .CombineCocoa,
  .project(target: "Utils", path: "../../Platform/Utils"),
  .project(target: "SubwayNetworking", path: "../SubwayNetworking")
]

let project = Project(
  name: "Subway",
  organizationName: "com.minan",
  packages: [],
  targets: Project.makeFrameworkTargets(
    name: "Subway",
    isDynamic: false,
    dependencies: subwayDependencies
  )
)

import ProjectDescription
import ProjectDescriptionHelpers

let subwayRepositoryDependencies: [TargetDependency] = [
  .project(target: "Networking", path: "../../Core/Networking")
]

let project = Project(
  name: "SubwayNetworking",
  targets: Project.makeFrameworkTargets(
    name: "SubwayNetworking",
    isDynamic: false,
    dependencies: subwayRepositoryDependencies
  )
)



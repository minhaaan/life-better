import ProjectDescription
import ProjectDescriptionHelpers

let subwayRepositoryDependencies: [TargetDependency] = [
  .core.networking
]

let project = Project(
  name: "SubwayNetworking",
  targets: Project.makeFrameworkTargets(
    name: "SubwayNetworking",
    isDynamic: false,
    dependencies: subwayRepositoryDependencies
  )
)



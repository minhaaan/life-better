import ProjectDescription
import ProjectDescriptionHelpers

let subwayRepositoryDependencies: [TargetDependency] = [
  .project(target: "Networking", path: "../../Core/Networking")
]

let project = Project(
  name: "SubwayRepository",
  targets: Project.makeFrameworkTargets(
    name: "SubwayRepository",
    isDynamic: false,
    dependencies: subwayRepositoryDependencies
  )
)



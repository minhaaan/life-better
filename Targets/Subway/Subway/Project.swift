import ProjectDescription
import ProjectDescriptionHelpers

let subwayDependencies: [TargetDependency] = [
  .SnapKit,
  .CombineExt,
  .project(target: "Utils", path: "../../Platform/Utils")
]

let project = Project(
  name: "Subway",
  organizationName: "com.minan",
  packages: [],
  targets: Project.makeFrameworkTargets(
    name: "Subway",
    dependencies: subwayDependencies
  )
)

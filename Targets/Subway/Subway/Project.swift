import ProjectDescription
import ProjectDescriptionHelpers

let subwayDependencies: [TargetDependency] = [
  .FlexLayout,
  .ModernRibs,
  .SnapKit,
  .CombineExt
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

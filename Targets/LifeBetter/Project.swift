import ProjectDescription
import ProjectDescriptionHelpers

// MARK: - Project

let lifeBetterDependencies: [TargetDependency] = [
  .ModernRibs,
  .SnapKit,
  .CombineExt,
  .FlexLayout,
  .Then,
  .CombineCocoa,
  .project(target: "Subway", path: "../Subway/Subway")
]

let project = Project(
  name: "LifeBetter",
  organizationName: "com.minan",
  packages: [.FlexLayout],
  settings: nil,
  targets: Project.makeAppTargets(
    name: "LifeBetter",
    dependencies: lifeBetterDependencies
  )
)

import ProjectDescription
import ProjectDescriptionHelpers

// MARK: - Project

let lifeBetterDependencies: [TargetDependency] = [
  .FlexLayout,
  .ModernRibs,
  .SnapKit,
  .CombineExt
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

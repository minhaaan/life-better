import ProjectDescription
import ProjectDescriptionHelpers

// MARK: - Project

let lifeBetterDependencies: [TargetDependency] = [
  .SnapKit,
  .FlexLayout,
  .Then,
  .CombineCocoa,
  .project(target: "Subway", path: "../Subway/Subway"),
  .project(target: "Utils", path: "../Platform/Utils"),
  .project(target: "Network", path: "../Platform/Network")
]

let project = Project(
  name: "LifeBetter",
  organizationName: "com.minan",
  packages: [.FlexLayout],
  settings: nil,
  targets: Project.makeAppTargets(
    name: "LifeBetter",
    dependencies: lifeBetterDependencies
  ),
  schemes: [
    Scheme(
      name: "LifeBetter",
      shared: true,
      buildAction: .buildAction(targets: ["LifeBetter"]),
      testAction: .testPlans([.relativeToRoot("LifeBetter.xctestplan")]),
      runAction: .runAction(executable: "LifeBetter")
    )
  ]
)

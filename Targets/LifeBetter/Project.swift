import ProjectDescription
import ProjectDescriptionHelpers

// MARK: - Project

let lifeBetterDependencies: [TargetDependency] = [
  .SnapKit,
  .FlexLayout,
  .Then,
  .CombineCocoa,
  .feature.subway,
  .platform.utils,
  .core.networking,
  .core.subwayWidgetCore
]

let project = Project(
  name: "LifeBetter",
  organizationName: "com.minan",
  packages: [.FlexLayout],
  settings: nil,
  targets: Project.makeAppTargets(
    name: "LifeBetter",
    dependencies: lifeBetterDependencies
  ) + [.subwayWidgetTarget],
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

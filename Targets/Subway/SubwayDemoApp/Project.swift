import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
  name: "SubwayDemoApp",
  targets: Project.makeAppTargets(
    name: "SubwayDemoApp",
    dependencies: [
      .feature.subway
    ]
  ),
  schemes: [.makeScheme(name: "SubwayDemoApp")]
)



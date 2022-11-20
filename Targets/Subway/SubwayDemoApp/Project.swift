import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
  name: "SubwayDemoApp",
  targets: Project.makeAppTargets(
    name: "SubwayDemoApp",
    dependencies: [
      .project(target: "Subway", path: "../Subway")
    ]
  )
)



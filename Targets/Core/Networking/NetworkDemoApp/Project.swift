import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
  name: "NetworkDemoApp",
  targets: Project.makeAppTargets(
    name: "NetworkDemoApp",
    dependencies: [
      .project(target: "Networking", path: "../")
    ]
  )
)



import ProjectDescription
import ProjectDescriptionHelpers

let subwayCoreDependencies: [TargetDependency] = [
  .platform.utils,
  .platform.ribsUtils,
  .feature.subwayCore,
  .feature.subwayNetworking
]

let project = Project(
  name: "SubwayDetail",
  organizationName: "com.minan",
  packages: [],
  targets: Project.makeFrameworkTargets(
    name: "SubwayDetail",
    isDynamic: false,
    dependencies: subwayCoreDependencies
  )
)

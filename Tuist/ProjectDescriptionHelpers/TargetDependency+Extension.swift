import ProjectDescription

public extension TargetDependency {
  static let core = CoreTarget()
  static let platform = PlatformTarget()
  static let feature = FeatureTarget()
}

public struct CoreTarget {
  public let networking = TargetDependency.project(target: "Networking", path: .core.networking)
  public let subwayWidgetCore = TargetDependency.project(target: "SubwayWidgetCore", path: .core.subwayWidgetCore)
}

public struct PlatformTarget {
  public let utils = TargetDependency.project(target: "Utils", path: .platform.Utils)
}

public struct FeatureTarget {
  public let subway = TargetDependency.project(target: "Subway", path: .feature.subway.subway)
  public let subwayNetworking = TargetDependency.project(target: "SubwayNetworking", path: .feature.subway.subwayNetworking)
  public let subwayCore = TargetDependency.project(target: "SubwayCore", path: .feature.subway.subwayCore)
  public let subwayDetail = TargetDependency.project(target: "SubwayDetail", path: .feature.subway.subwayDetail)
  public let subwayWidget = TargetDependency.target(name: "SubwayWidget")
}

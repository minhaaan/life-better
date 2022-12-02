import ProjectDescription

public extension TargetDependency {
  static let core = CoreTarget()
  static let platform = PlatformTarget()
  static let feature = FeatureTarget()
}

public struct CoreTarget {
  public let networking = TargetDependency.project(target: "Networking", path: .core.networking)
}

public struct PlatformTarget {
  public let ribsUtils = TargetDependency.project(target: "RibsUtils", path: .platform.RibsUtil)
  public let utils = TargetDependency.project(target: "Utils", path: .platform.Utils)
}

public struct FeatureTarget {
  public let subway = TargetDependency.project(target: "Subway", path: .feature.subway)
  public let subwayNetworking = TargetDependency.project(target: "SubwayNetworking", path: .feature.subwayNetworking)
}

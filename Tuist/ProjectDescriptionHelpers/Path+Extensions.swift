import ProjectDescription

public extension Path {
  static let platform = Platform()
  static let core = Core()
  static let feature = Feature()
}

public struct Core {
  private static let defaultPath = "Targets/Core"
  public let networking: Path = Path.relativeToRoot("Targets/Core/Networking")
  public let subwayWidgetCore = Path.relativeToRoot("Targets/Core/SubwayWidgetCore")
}

public struct Platform {
  private static let defaultPath = "Targets/Platform"
  public let Utils: Path = Path.relativeToRoot("\(defaultPath)/Utils")
}

public struct Feature {
  public let subway = Subway()
}

// MARK: Feature+Subway

public struct Subway {
  public let subway = Path.relativeToRoot("Targets/Subway/Subway")
  public let subwayNetworking = Path.relativeToRoot("Targets/Subway/SubwayNetworking")
  public let subwayCore = Path.relativeToRoot("Targets/Subway/SubwayCore")
  public let subwayDetail = Path.relativeToRoot("Targets/Subway/SubwayDetail")
}

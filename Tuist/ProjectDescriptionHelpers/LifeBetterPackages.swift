import ProjectDescription

public extension TargetDependency{
  static let FlexLayout: TargetDependency = .package(product: "FlexLayout")
}

public extension Package {
  static let FlexLayout: Package = .remote(url: "https://github.com/layoutBox/FlexLayout", requirement: .exact("1.3.24"))
}

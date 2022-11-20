import ProjectDescription

public extension TargetDependency{
  // package
  static let FlexLayout: TargetDependency = .package(product: "FlexLayout")
  
  // external
  static let SnapKit: TargetDependency = .external(name: "SnapKit")
  static let ModernRibs: TargetDependency = .external(name: "ModernRIBs")
  static let CombineExt: TargetDependency = .external(name: "CombineExt")
}

public extension Package {
  static let FlexLayout: Package = .remote(url: "https://github.com/layoutBox/FlexLayout", requirement: .exact("1.3.24"))
}

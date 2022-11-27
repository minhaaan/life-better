import ProjectDescription

public extension TargetDependency{
  // package
  static let FlexLayout: TargetDependency = .package(product: "FlexLayout")
  
  // external
  static let SnapKit: TargetDependency = .external(name: "SnapKit")
  static let ModernRibs: TargetDependency = .external(name: "ModernRIBs")
  static let CombineExt: TargetDependency = .external(name: "CombineExt")
  static let Then: TargetDependency = .external(name: "Then")
  static let CombineCocoa: TargetDependency = .external(name: "CombineCocoa")
  static let Moya: TargetDependency = .external(name: "Moya")
  static let CombineMoya: TargetDependency = .external(name: "CombineMoya")
}

public extension Package {
  static let FlexLayout: Package = .remote(url: "https://github.com/layoutBox/FlexLayout", requirement: .exact("1.3.24"))
}

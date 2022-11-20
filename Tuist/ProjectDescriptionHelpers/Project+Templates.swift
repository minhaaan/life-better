import ProjectDescription

extension Project {
  public static func makeAppTargets(
    name: String,
    dependencies: [TargetDependency]
  ) -> [Target] {
    let infoPlist: [String: InfoPlist.Value] = [
      "CFBundleShortVersionString": "1.0",
      "CFBundleVersion": "1",
      "UIMainStoryboardFile": "",
      "UILaunchStoryboardName": "LaunchScreen",
      "GCC_PREPROCESSOR_DEFINITIONS" : "FLEXLAYOUT_SWIFT_PACKAGE=1", // FlexLayout error fix
    ]
    
    let appTarget = Target(
      name: name,
      platform: .iOS,
      product: .app,
      bundleId: "com.minan.\(name)",
      deploymentTarget: .iOS(targetVersion: "16.1", devices: .iphone),
      infoPlist: .extendingDefault(with: infoPlist),
      sources: ["Sources/**"],
      resources: ["Resources/**"],
      dependencies: dependencies
    )
    
    let testTarget = Target(
      name: "\(name)Tests",
      platform: .iOS,
      product: .unitTests,
      bundleId: "com.minan.\(name)Tests",
      deploymentTarget: .iOS(targetVersion: "16.1", devices: .iphone),
      infoPlist: .default,
      sources: ["Tests/**"],
      dependencies: [
        .target(name: "\(name)")
      ])
    return [appTarget, testTarget]
  }
  
  public static func makeFrameworkTargets(
    name: String,
    dependencies: [TargetDependency]
  ) -> [Target] {
    let infoPlist: [String: InfoPlist.Value] = [
      "GCC_PREPROCESSOR_DEFINITIONS" : "FLEXLAYOUT_SWIFT_PACKAGE=1" // FlexLayout error fix
    ]
    
    let framework = Target(
      name: name,
      platform: .iOS,
      product: .staticFramework,
      bundleId: "com.minan.\(name)",
      infoPlist: .extendingDefault(with: infoPlist),
      sources: ["Sources/**"],
      resources: ["Resources/**"],
      dependencies: [])
    let tests = Target(
      name: "\(name)Tests",
      platform: .iOS,
      product: .unitTests,
      bundleId: "com.minan.\(name)Tests",
      infoPlist: .default,
      sources: ["Tests/**"],
      dependencies: [.target(name: name)])
    return [framework, tests]
  }
}

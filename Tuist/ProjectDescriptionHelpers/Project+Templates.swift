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
      "NSAppTransportSecurity":   [
        "NSAllowsArbitraryLoads": true
      ],
      "NSSupportsLiveActivities": true // 라이브액티비티 지원.
    ]
    
    let baseSettings: [String: SettingValue] = [
      "GCC_PREPROCESSOR_DEFINITIONS" : "FLEXLAYOUT_SWIFT_PACKAGE=1", // FlexLayout error fix
      "OTHER_LDFAGS": "-ObjC",
      "DEVELOPMENT_TEAM": "7T8JF3V3RR"
    ]
    
    let appTarget = Target(
      name: name,
      platform: .iOS,
      product: .app,
      bundleId: "com.minan.\(name)",
      deploymentTarget: .iOS(targetVersion: "16.0", devices: [.iphone]),
      infoPlist: .extendingDefault(with: infoPlist),
      sources: ["Sources/**"],
      resources: ["Resources/**"],
      dependencies: dependencies,
      settings: .settings(base: baseSettings, configurations: [], defaultSettings: .recommended)
    )
    
    let testTarget = Target(
      name: "\(name)Tests",
      platform: .iOS,
      product: .unitTests,
      bundleId: "com.minan.\(name)Tests",
      deploymentTarget: .iOS(targetVersion: "16.0", devices: [.iphone]),
      infoPlist: .default,
      sources: ["Tests/**"],
      dependencies: [
        .target(name: "\(name)")
      ],
      settings: .settings(base: baseSettings, configurations: [], defaultSettings: .recommended)
    )
    return [appTarget, testTarget]
  }
  
  public static func makeFrameworkTargets(
    name: String,
    isDynamic: Bool,
    dependencies: [TargetDependency]
  ) -> [Target] {
    let infoPlist: [String: InfoPlist.Value] = [
      "GCC_PREPROCESSOR_DEFINITIONS" : "FLEXLAYOUT_SWIFT_PACKAGE=1" // FlexLayout error fix
    ]
    
    let baseSettings: [String: SettingValue] = [
      "DEVELOPMENT_TEAM": "7T8JF3V3RR"
    ]
    
    let framework = Target(
      name: name,
      platform: .iOS,
      product: isDynamic ? .framework : .staticFramework,
      bundleId: "com.minan.\(name)",
      deploymentTarget: .iOS(targetVersion: "16.0", devices: [.iphone]),
      infoPlist: .extendingDefault(with: infoPlist),
      sources: ["Sources/**"],
      resources: ["Resources/**"],
      dependencies: dependencies,
      settings: .settings(base: baseSettings, configurations: [], defaultSettings: .recommended)
    )
    let tests = Target(
      name: "\(name)Tests",
      platform: .iOS,
      product: .unitTests,
      bundleId: "com.minan.\(name)Tests",
      deploymentTarget: .iOS(targetVersion: "16.0", devices: [.iphone]),
      infoPlist: .default,
      sources: ["Tests/**"],
      dependencies: [.target(name: name)],
      settings: .settings(base: baseSettings, configurations: [], defaultSettings: .recommended)
    )
    return [framework, tests]
  }
}

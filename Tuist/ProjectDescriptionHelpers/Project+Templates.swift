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
      "UILaunchStoryboardName": "LaunchScreen"
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
}

//public static func makeFrameworkTargets(
//  name: String,
//  platform: Platform
//) -> [Target] {
//  let sources = Target(name: name,
//                       platform: platform,
//                       product: .framework,
//                       bundleId: "io.tuist.\(name)",
//                       infoPlist: .default,
//                       sources: ["Targets/\(name)/Sources/**"],
//                       resources: [],
//                       dependencies: [])
//  let tests = Target(name: "\(name)Tests",
//                     platform: platform,
//                     product: .unitTests,
//                     bundleId: "io.tuist.\(name)Tests",
//                     infoPlist: .default,
//                     sources: ["Targets/\(name)/Tests/**"],
//                     resources: [],
//                     dependencies: [.target(name: name)])
//  return [sources, tests]
//}

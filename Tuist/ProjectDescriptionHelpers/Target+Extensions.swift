import ProjectDescription

extension Target {
  public static let subwayWidgetTarget = Target(
    name: "SubwayWidget",
    platform: .iOS,
    product: .appExtension,
    productName: "SubwayWidget",
    bundleId: "com.minan.SubwayWidget",
    deploymentTarget: .iOS(targetVersion: "16.1", devices: [.iphone]),
    infoPlist: .extendingDefault(with: [
      "CFBundleDisplayName": "$(PRODUCT_NAME)",
      "NSExtension": [
        "NSExtensionPointIdentifier": "com.apple.widgetkit-extension"
      ]
    ]),
    sources: [.glob(.relativeToRoot("Targets/Subway/SubwayWidget/Sources**"))],
    resources: [.glob(pattern: .relativeToRoot("Targets/Subway/SubwayWidget/Resources/**"))],
    dependencies: [
      .core.subwayWidgetCore
    ],
    settings: .settings(
      base: [:],
      configurations: [],
      defaultSettings: .recommended
    )
  )
}


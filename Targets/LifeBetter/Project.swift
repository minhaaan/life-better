import ProjectDescription
import ProjectDescriptionHelpers

// MARK: - Project

let lifeBetterDependencies: [TargetDependency] = [
  .SnapKit,
  .FlexLayout,
  .Then,
  .CombineCocoa,
  .feature.subway,
  .platform.utils,
  .core.networking,
  .core.subwayWidgetCore
]

let subwayWidgetTarget = Target(
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
  sources: ["SubwayWidget/Sources/**"],
  resources: ["SubwayWidget/Resources/**"],
  dependencies: [
    .core.subwayWidgetCore
  ],
  settings: .settings(
    base: [
      "GCC_PREPROCESSOR_DEFINITIONS" : "FLEXLAYOUT_SWIFT_PACKAGE=1", // FlexLayout error fix
      "OTHER_LDFAGS": "-ObjC",
      "DEVELOPMENT_TEAM": "7T8JF3V3RR"
    ],
    configurations: [],
    defaultSettings: .recommended
  )
)

let project = Project(
  name: "LifeBetter",
  organizationName: "com.minan",
  packages: [.FlexLayout],
  settings: nil,
  targets: Project.makeAppTargets(
    name: "LifeBetter",
    dependencies: lifeBetterDependencies
  ) + [subwayWidgetTarget],
  schemes: [
    Scheme(
      name: "LifeBetter",
      shared: true,
      buildAction: .buildAction(targets: ["LifeBetter"]),
      testAction: .testPlans([.relativeToRoot("LifeBetter.xctestplan")]),
      runAction: .runAction(executable: "LifeBetter")
    )
  ]
)

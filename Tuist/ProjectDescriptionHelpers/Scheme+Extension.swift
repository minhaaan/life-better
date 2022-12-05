import ProjectDescription

extension Scheme {
  public static func makeScheme(name: String) -> Scheme {
    Scheme(
      name: "\(name)",
      shared: false,
      hidden: false,
      buildAction: .buildAction(targets: ["\(name)"]),
      testAction: .targets(["\(name)Tests"], options: .options(coverage: true, codeCoverageTargets: [])),
      runAction: .runAction()
    )
  }
}


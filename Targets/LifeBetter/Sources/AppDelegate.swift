import UIKit
import ModernRIBs

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  public var window: UIWindow?
  private var launchRouter: LaunchRouting?
  
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
  ) -> Bool {
    
    setupWindow()
    setupLaunchRouter()
    
    return true
  }
  
}

// MARK: Private Method

extension AppDelegate {
  private func setupWindow() {
    let window = UIWindow(frame: UIScreen.main.bounds)
    self.window = window
  }
  
  private func setupLaunchRouter() {
    guard let window = window else { return }
    let launchRouter = RootBuilder(dependency: AppComponent()).build()
    self.launchRouter = launchRouter
    launchRouter.launch(from: window)
  }
}

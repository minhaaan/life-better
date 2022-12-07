import UIKit
import ModernRIBs
import SwiftyBeaver
import Utils
import SubwayWidgetCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  public var window: UIWindow?
  private var launchRouter: LaunchRouting?
  
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
  ) -> Bool {
    
    setupLogger()
    setupWindow()
    setupLaunchRouter()
    
    return true
  }
  
  // 앱 종료할 때 LiveActivity 같이 없앰.
  func applicationWillTerminate(_ application: UIApplication) {
    if #available(iOS 16.1, *) {
      SubwayLiveActivityManager.shared.removeAllActivities()
    }
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
  
  private func setupLogger() {
    let console = ConsoleDestination()
    console.format = "$DHH:mm:ss$d $L $M"
    console.levelString.verbose = "💜 VERBOSE"
    console.levelString.debug = "💚 DEBUG"
    console.levelString.info = "💙 INFO"
    console.levelString.warning = "💛 WARNING"
    console.levelString.error = "❤️ ERROR"
    
    let cloud = SBPlatformDestination(
      appID: Keys.SWIFTY_BEAVER_KEY.appId,
      appSecret: Keys.SWIFTY_BEAVER_KEY.secret,
      encryptionKey: Keys.SWIFTY_BEAVER_KEY.encryptionKey
    )
    
    log.addDestination(console)
    log.addDestination(cloud)
  }
}

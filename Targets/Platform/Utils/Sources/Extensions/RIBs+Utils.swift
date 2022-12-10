import UIKit
import ModernRIBs

extension UINavigationController: ViewControllable {
    public var uiviewController: UIViewController { return self }
    
    public convenience init(root: ViewControllable) {
        self.init(rootViewController: root.uiviewController)
    }
}

extension ViewControllable {
  
  public func present(_ viewControllable: ViewControllable, animated: Bool, completion: (() -> Void)?) {
    self.uiviewController.present(viewControllable.uiviewController, animated: animated, completion: completion)
  }
  
  public func dismiss(completion: (() -> Void)?) {
    self.uiviewController.dismiss(animated: true, completion: completion)
  }
  
  public func pushViewController(_ viewControllable: ViewControllable, animated: Bool) {
    if let nav = self.uiviewController as? UINavigationController {
      nav.pushViewController(viewControllable.uiviewController, animated: animated)
    } else {
      self.uiviewController.navigationController?.pushViewController(viewControllable.uiviewController, animated: animated)
    }
  }
  
  public func popViewController(animated: Bool) {
    if let nav = self.uiviewController as? UINavigationController {
      nav.popViewController(animated: animated)
    } else {
      self.uiviewController.navigationController?.popViewController(animated: animated)
    }
  }
  
  public func popToRoot(animated: Bool) {
    if let nav = self.uiviewController as? UINavigationController {
      nav.popToRootViewController(animated: animated)
    } else {
      self.uiviewController.navigationController?.popToRootViewController(animated: animated)
    }
  }
  
  public func setViewControllers(_ viewControllerables: [ViewControllable]) {
    if let nav = self.uiviewController as? UINavigationController {
      nav.setViewControllers(viewControllerables.map(\.uiviewController), animated: true)
    } else {
      self.uiviewController.navigationController?.setViewControllers(viewControllerables.map(\.uiviewController), animated: true)
    }
  }
}

// MARK: ViewControllableMock

public final class ViewControllableMock: UIViewController, ViewControllable {
  
  public init() {
    super.init(nibName: nil, bundle: nil)
  }

  public required init?(coder: NSCoder) {
    fatalError()
  }
  
  var presentCallsCount = 0
  public override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
    presentCallsCount += 1
  }
  
  var dismissCallsCount = 0
  public override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
    dismissCallsCount += 1
  }
  
}

import ModernRIBs
import UIKit
import Then
import SnapKit
import FlexLayout
import CombineCocoa
import Combine
import Utils

protocol RootPresentableListener: AnyObject {
  func showSubwayHome()
}

final class RootViewController: UIViewController, RootPresentable, RootViewControllable {
  
  weak var listener: RootPresentableListener?
  
  // MARK: LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  // MARK: method
  
  func addChildRootListViewController(viewController: ViewControllable) {
    let rootListViewController = viewController.uiviewController
    view.addSubview(rootListViewController.view)
    addChild(rootListViewController)
    rootListViewController.view.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
  
}

#if canImport(SwiftUI)
import SwiftUI
struct RootVC_Preview: PreviewProvider {
  static var previews: some View {
    RootViewController().showPreview()
      .edgesIgnoringSafeArea(.all)
  }
}
#endif

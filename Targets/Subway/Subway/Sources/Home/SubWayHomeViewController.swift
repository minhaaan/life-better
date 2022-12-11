import ModernRIBs
import UIKit
import Then
import SnapKit
import Combine
import CombineCocoa

public protocol SubWayHomePresentableListener: AnyObject {
  // TODO: Declare properties and methods that the view controller can invoke to perform
  // business logic, such as signIn(). This protocol is implemented by the corresponding
  // interactor class.
  func detachSubwayHome()
}

final class SubWayHomeViewController: UIViewController, SubWayHomePresentable, SubWayHomeViewControllable {
  
  // MARK: Properties
  
  weak var listener: SubWayHomePresentableListener?
  
  private var bag = Set<AnyCancellable>()
  
  // MARK: LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func didMove(toParent parent: UIViewController?) {
    super.didMove(toParent: parent)
    if parent == nil {
      listener?.detachSubwayHome()
    }
  }
  
  // MARK: SubWayHomeViewControllable
  
  func addChildSubwayListViewController(viewController: ModernRIBs.ViewControllable) {
    view.addSubview(viewController.uiviewController.view)
    addChild(viewController.uiviewController)
    viewController.uiviewController.view.snp.makeConstraints { make in
      make.edges.equalTo(view.safeAreaLayoutGuide)
    }
  }
  
}



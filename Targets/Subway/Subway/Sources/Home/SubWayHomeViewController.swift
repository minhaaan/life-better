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
  
  var subwayData: String = "123"
  
  private var bag = Set<AnyCancellable>()
  
  // MARK: Layout Properties
  
  private let button = UIButton(type: .system).then {
    $0.setTitleColor(.white, for: .normal)
    $0.backgroundColor = .systemBlue
    $0.layer.cornerRadius = 8
  }
  
  // MARK: LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupLayout()
    setupTapGesture()
  }
  
  override func didMove(toParent parent: UIViewController?) {
    super.didMove(toParent: parent)
    if parent == nil {
      listener?.detachSubwayHome()
    }
  }
  
  // MARK: Method
  
  private func setupLayout() {
    view.backgroundColor = .systemPink
    
    button.setTitle(subwayData, for: .normal)
    view.addSubview(button)
    button.snp.makeConstraints { make in
      make.center.equalToSuperview()
    }
  }
  
  private func setupTapGesture() {
    button.tapPublisher
      .sink { [weak self] _ in
        self?.listener?.detachSubwayHome()
      }
      .store(in: &bag)
      
  }
}

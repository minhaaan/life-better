import ModernRIBs
import UIKit
import Then
import SnapKit
import FlexLayout
import CombineCocoa
import Combine
import Utils

protocol RootPresentableListener: AnyObject {
  // TODO: Declare properties and methods that the view controller can invoke to perform
  // business logic, such as signIn(). This protocol is implemented by the corresponding
  // interactor class.
  func showSubwayHome()
}

final class RootViewController: UIViewController, RootPresentable, RootViewControllable {
  
  weak var listener: RootPresentableListener?
  
  private let body = UIView().then { $0.backgroundColor = .white }
  
  private let titleLabel = UILabel().then {
    $0.text = "TITLE"
    $0.textColor = .black
    $0.font = .boldSystemFont(ofSize: 20)
  }
  
  private let button = UIButton(type: .system).then {
    $0.setTitle("button", for: .normal)
    $0.setTitleColor(.black, for: .normal)
    $0.titleLabel?.font = .boldSystemFont(ofSize: 22)
  }
  
  private var cancellable = Set<AnyCancellable>()
  
  // MARK: init
  
  init() {
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    body.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
      make.horizontalEdges.bottom.equalToSuperview()
    }
    body.flex.layout(mode: .adjustHeight)
  }
  
  // MARK: LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupLayout()
    setupTapGesture()
  }
  
  // MARK: method
  
  private func setupLayout() {
    view.backgroundColor = .white
    
    view.addSubview(body)
    
    body.flex.direction(.column)
      .width(UIScreen.main.bounds.width)
      .define { flex in
        flex.addItem(titleLabel)
          .alignSelf(.center)
        flex.addItem(button)
          .alignSelf(.center)
      }
  }
  
  private func setupTapGesture() {
    button.tapPublisher
      .throttle(for: 2, scheduler: DispatchQueue.main, latest: false)
      .sink { [weak self] _ in
        self?.listener?.showSubwayHome()
      }
      .store(in: &cancellable)
  }
  
}

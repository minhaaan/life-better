import UIKit
import Networking
import Combine

final class NetworkingTestViewController: UIViewController {
  
  // MARK: Properties
  
  private let apiManager = APIManager()
  
  private let button: UIButton = {
    let bt = UIButton(type: .system)
    bt.setTitle("send", for: .normal)
    return bt
  }()
  
  private var cancellable = Set<AnyCancellable>()
  
  // MARK: LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupLayout()
    setupTapGesture()
  }
  
  // MARK: Method
  
  private func setupLayout() {
    view.backgroundColor = .systemBackground
    
    view.addSubview(button)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
  }
  
  private func setupTapGesture() {
    button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
  }
  
  @objc
  private func buttonTapped() {
    apiManager.perform(SampleRequest.posts, type: [Post].self)
      .sink(receiveCompletion: { com in
        if case .failure(let err) = com {
          print("DEBUG: error is \(err)")
        }
      }, receiveValue: { value in
        print("DEBUG: value is \(value)")
        print("DEBUG: count is \(value.count)")
      })
      .store(in: &cancellable)
  }
  
}

struct Post: Decodable {
  let userId: Int
  let id: Int
  let title: String
  let body: String
}

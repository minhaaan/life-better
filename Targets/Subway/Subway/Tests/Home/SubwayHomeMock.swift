@testable import Subway
import ModernRIBs
import UIKit
import Combine

// MARK: SubwayHomePresentableMock
public final class SubwayHomePresentableMock: SubWayHomePresentable {
  public var subwayData: String = ""
  
  public var listener: SubWayHomePresentableListener?
  
  public init() {}
}

// MARK: - SubWayHomeListenerMock -
final class SubWayHomeListenerMock: SubWayHomeListener {
  
  // MARK: - detachSubwayHome
  
  var detachSubwayHomeCallsCount = 0
  var detachSubwayHomeCalled: Bool {
    detachSubwayHomeCallsCount > 0
  }
  var detachSubwayHomeClosure: (() -> Void)?
  
  func detachSubwayHome() {
    detachSubwayHomeCallsCount += 1
    detachSubwayHomeClosure?()
  }
}

// MARK: SubwayHomeViewControllableMock
final class SubwayHomeViewControllableMock: SubWayHomeViewControllable {
  
  var uiviewController: UIViewController = UIViewController()
  
  var addChildSubwayListViewControllerCallsCount = 0
  func addChildSubwayListViewController(viewController: ModernRIBs.ViewControllable) {
    addChildSubwayListViewControllerCallsCount += 1
  }
}

// MARK: SubwayHomeInteratableMock
final class SubwayHomeInteratableMock: SubWayHomeInteractable {
  var router: Subway.SubWayHomeRouting?
  var listener: Subway.SubWayHomeListener?
  
  var activateCallsCount = 0
  func activate() {
    activateCallsCount += 1
  }
  
  var deactivateCallsCount = 0
  func deactivate() {
    deactivateCallsCount += 1
  }
  
  var isActive: Bool = false
  var isActiveStream: AnyPublisher<Bool, Never> {
    let isActiveStream = PassthroughSubject<Bool, Never>()
    return isActiveStream.eraseToAnyPublisher()
  }
}

// MARK: - SubWayHomePresentableListenerMock -

final class SubWayHomePresentableListenerMock: SubWayHomePresentableListener {
    
   // MARK: - detachSubwayHome

    var detachSubwayHomeCallsCount = 0
    var detachSubwayHomeCalled: Bool {
        detachSubwayHomeCallsCount > 0
    }
    var detachSubwayHomeClosure: (() -> Void)?

    func detachSubwayHome() {
        detachSubwayHomeCallsCount += 1
        detachSubwayHomeClosure?()
    }
}
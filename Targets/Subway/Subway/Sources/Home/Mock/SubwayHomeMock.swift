import ModernRIBs
import UIKit
import Combine

// MARK: SubwayHomePresentableMock
public final class SubwayHomePresentableMock: SubWayHomePresentable {
  public var listener: SubWayHomePresentableListener?
  
  public init() {}
}

// MARK: SubWayHomeInteractorMock
public final class SubWayHomeInteractorMock: PresentableInteractor<SubWayHomePresentable>, SubWayHomeInteractable, SubWayHomePresentableListener {
  public weak var router: SubWayHomeRouting?
  public weak var listener: SubWayHomeListener?
  
  // TODO: Add additional dependencies to constructor. Do not perform any logic
  // in constructor.
  public override init(presenter: SubWayHomePresentable) {
    super.init(presenter: presenter)
    presenter.listener = self
  }
  
  public var didBecomeActiveCallCount = 0
  public override func didBecomeActive() {
    super.didBecomeActive()
    didBecomeActiveCallCount += 1
  }
  
  public var willResignActiveCallCount = 0
  public override func willResignActive() {
    super.willResignActive()
    willResignActiveCallCount += 1
  }
  
  public var detachSubwayHomeCallCount = 0
  public func detachSubwayHome() {
    detachSubwayHomeCallCount += 1
    listener?.detachSubwayHome()
  }
  
}

// MARK: SubwayHomeRouterMock
public final class SubwayHomeRouterMock: SubWayHomeRouting {
  public var viewControllable: ModernRIBs.ViewControllable
  
  public var interactable: ModernRIBs.Interactable
  
  public var children: [ModernRIBs.Routing] = []
  
  public var loadCallCount = 0
  public func load() {
    loadCallCount += 1
  }
  
  public func attachChild(_ child: ModernRIBs.Routing) {
  }
  
  public var detachChildCallsCount = 0
  public func detachChild(_ child: ModernRIBs.Routing) {
    detachChildCallsCount += 1
  }
  
  public var lifeCyclePublisher = PassthroughSubject<RouterLifecycle, Never>()
  public var lifecycle: AnyPublisher<ModernRIBs.RouterLifecycle, Never> {
    lifeCyclePublisher.eraseToAnyPublisher()
  }
  
  public init(interactable: ModernRIBs.Interactable, viewControllable: ModernRIBs.ViewControllable) {
    self.viewControllable = viewControllable
    self.interactable = interactable
  }
  
}

// MARK: SubwayHomeListenerMock
final class SubwayHomeListenerMock: SubWayHomeListener {
  var detachSubwayHomeCallsCount = 0
  func detachSubwayHome() {
    detachSubwayHomeCallsCount += 1
  }
}

// MARK: SubwayViewControllableMock
final public class SubwayHomeViewControllableMock: SubWayHomeViewControllable {
  public var uiviewController: UIViewController = UIViewController()
  
  public var initCallCount = 0
  public init() {
    initCallCount += 1
  }
}


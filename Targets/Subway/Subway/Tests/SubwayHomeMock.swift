@testable import Subway
import ModernRIBs

// MARK: SubwayHomePresentableMock
final class SubwayHomePresentableMock: SubWayHomePresentable {
  var listener: SubWayHomePresentableListener?
}

// MARK: SubWayHomeInteractorMock
final class SubWayHomeInteractorMock: PresentableInteractor<SubWayHomePresentable>, SubWayHomeInteractable, SubWayHomePresentableListener {
  weak var router: SubWayHomeRouting?
  weak var listener: SubWayHomeListener?
  
  // TODO: Add additional dependencies to constructor. Do not perform any logic
  // in constructor.
  override init(presenter: SubWayHomePresentable) {
    super.init(presenter: presenter)
    presenter.listener = self
  }
  
  var didBecomeActiveCallCount = 0
  override func didBecomeActive() {
    super.didBecomeActive()
    didBecomeActiveCallCount += 1
  }
  
  var willResignActiveCallCount = 0
  override func willResignActive() {
    super.willResignActive()
    willResignActiveCallCount += 1
  }
  
  var detachSubwayHomeCallCount = 0
  func detachSubwayHome() {
    detachSubwayHomeCallCount += 1
    listener?.detachSubwayHome()
  }
  
}

// MARK: SubwayHomeRouterMock
final class SubwayHomeRouterMock: ViewableRouter<SubWayHomeInteractable, SubWayHomeViewControllable>, SubWayHomeRouting {
  override init(interactor: SubWayHomeInteractable, viewController: SubWayHomeViewControllable) {
    super.init(interactor: interactor, viewController: viewController)
    interactor.router = self
  }
}

// MARK: SubwayHomeListenerMock
final class SubwayHomeListenerMock: SubWayHomeListener {
  var detachSubwayHomeCallsCount = 0
  func detachSubwayHome() {
    detachSubwayHomeCallsCount += 1
  }
}

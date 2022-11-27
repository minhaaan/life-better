@testable import LifeBetter
import ModernRIBs
import Subway
import UIKit

// MARK: - RootPresentableMock -

final class RootPresentableMock: RootPresentable {
  var listener: RootPresentableListener?
  
  init(listener: RootPresentableListener) {
    self.listener = listener
  }
}

// MARK: - RootPresentableListenerMock -

final class RootPresentableListenerMock: RootPresentableListener {
  
  // MARK: - showSubwayHome
  
  var showSubwayHomeCallsCount = 0
  var showSubwayHomeCalled: Bool {
    showSubwayHomeCallsCount > 0
  }
  var showSubwayHomeClosure: (() -> Void)?
  
  func showSubwayHome() {
    showSubwayHomeCallsCount += 1
    showSubwayHomeClosure?()
  }
}

// MARK: - RootRouterProtocolMock -

final class RootRouterMock: LaunchRouter<RootInteractable, RootViewControllable>, RootRouting {
    
   // MARK: - subwayHomeBuilder

    var subwayHomeBuilder: SubWayHomeBuildable {
        get { underlyingSubwayHomeBuilder }
        set(value) { underlyingSubwayHomeBuilder = value }
    }
    private var underlyingSubwayHomeBuilder: SubWayHomeBuildable!
    var subwayHome: SubWayHomeRouting?
    
   // MARK: - init

  // TODO: Constructor inject child builder protocols to allow building children.
  init(interactor: RootInteractable,
       viewController: RootViewControllable,
       subwayHomeBuilder: SubWayHomeBuildable) {
    super.init(interactor: interactor, viewController: viewController)
    self.subwayHomeBuilder = subwayHomeBuilder
    interactor.router = self
  }
    
   // MARK: - routeToSubwayHome

    var routeToSubwayHomeCallsCount = 0
    var routeToSubwayHomeCalled: Bool {
        routeToSubwayHomeCallsCount > 0
    }
    var routeToSubwayHomeClosure: (() -> Void)?

    func routeToSubwayHome() {
        routeToSubwayHomeCallsCount += 1
        routeToSubwayHomeClosure?()
    }
    
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

final class RootInteractorMock: PresentableInteractor<RootPresentable>, RootInteractable, RootPresentableListener {
  weak var router: RootRouting?
  weak var listener: RootListener?
  
  // TODO: Add additional dependencies to constructor. Do not perform any logic
  // in constructor.
  override init(presenter: RootPresentable) {
    super.init(presenter: presenter)
    presenter.listener = self
  }
  
  override func didBecomeActive() {
    super.didBecomeActive()
    // TODO: Implement business logic here.
  }
  
  override func willResignActive() {
    super.willResignActive()
    // TODO: Pause any business logic.
  }
  
  var showSubwayHomeCallcount = 0
  func showSubwayHome() {
    showSubwayHomeCallcount += 1
    router?.routeToSubwayHome()
  }
  
  var detachSubwayHomeCallcount = 0
  func detachSubwayHome() {
    router?.detachSubwayHome()
  }
}

// MARK: SubwayHomeBuildableMock

final class SubwayHomeBuildableMock: SubWayHomeBuildable {
  
  var buildHandler: ((_ listener: SubWayHomeListener) -> SubWayHomeRouting)?
  
  var buildCallCount = 0
  func build(withListener listener: SubWayHomeListener) -> SubWayHomeRouting {
    
    if let buildHandler = buildHandler {
      return buildHandler(listener)
    }
    
    fatalError()
  }
  
}

@testable import LifeBetter
import ModernRIBs
import Subway
import UIKit
import Combine

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

// MARK: SubwayHomeBuildableMock

final class SubwayHomeBuildableMock: SubWayHomeBuildable {
  
  var buildHandler: ((_ listener: SubWayHomeListener) -> SubWayHomeRouting)?
  
  var buildCallCount = 0
  func build(withListener listener: SubWayHomeListener) -> SubWayHomeRouting {
    buildCallCount += 1
    if let buildHandler = buildHandler {
      return buildHandler(listener)
    }
    
    fatalError()
  }
}

// MARK: SubwayHomeListenerMock
final class SubwayHomeListenerMock: SubWayHomeListener {
  var detachSubwayHomeCallsCount = 0
  func detachSubwayHome() {
    detachSubwayHomeCallsCount += 1
  }
}

// MARK: SubWayHomeInteractableMock
final class SubWayHomeInteractableMock: SubWayHomeInteractable {
    var router: SubWayHomeRouting?
    var listener: SubWayHomeListener?
    
   // MARK: - isActive

    var isActive: Bool {
        get { underlyingIsActive }
        set(value) { underlyingIsActive = value }
    }
    private var underlyingIsActive: Bool!
    
   // MARK: - isActiveStream

    var isActiveStream: AnyPublisher<Bool, Never> {
        get { underlyingIsActiveStream }
        set(value) { underlyingIsActiveStream = value }
    }
    private var underlyingIsActiveStream: AnyPublisher<Bool, Never>!
    
   // MARK: - activate

    var activateCallsCount = 0
    var activateCalled: Bool {
        activateCallsCount > 0
    }
    var activateClosure: (() -> Void)?

    func activate() {
        activateCallsCount += 1
        activateClosure?()
    }
    
   // MARK: - deactivate

    var deactivateCallsCount = 0
    var deactivateCalled: Bool {
        deactivateCallsCount > 0
    }
    var deactivateClosure: (() -> Void)?

    func deactivate() {
        deactivateCallsCount += 1
        deactivateClosure?()
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

  public var attachChildCallsCount = 0
  public func attachChild(_ child: ModernRIBs.Routing) {
    attachChildCallsCount += 1
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

// MARK: SubwayViewControllableMock
final public class SubwayHomeViewControllableMock: SubWayHomeViewControllable {
  public var uiviewController: UIViewController = UIViewController()

  public var initCallCount = 0
  public init() {
    initCallCount += 1
  }
  
  public var addChildSubwayListViewControllerCallsCount = 0
  public func addChildSubwayListViewController(viewController: ModernRIBs.ViewControllable) {
    addChildSubwayListViewControllerCallsCount += 1
  }
}

// MARK: RootListBuilableMock
final class RootListBuildableMock: RootListBuildable {
  
  var buildHandler: ((_ listener: RootListListener) -> RootListRouting)?
  
  var buildCallsCount = 0
  func build(withListener listener: LifeBetter.RootListListener) -> LifeBetter.RootListRouting {
    buildCallsCount += 1
    if let buildHandler {
      return buildHandler(listener)
    }
    
    fatalError()
  }
}

// MARK: - RootListRoutingMock -
final class RootListRoutingMock: RootListRouting {
    
   // MARK: - viewControllable

    var viewControllable: ModernRIBs.ViewControllable {
        get { underlyingViewControllable }
        set(value) { underlyingViewControllable = value }
    }
    private var underlyingViewControllable: ModernRIBs.ViewControllable!
    
   // MARK: - interactable

    var interactable: ModernRIBs.Interactable {
        get { underlyingInteractable }
        set(value) { underlyingInteractable = value }
    }
    private var underlyingInteractable: ModernRIBs.Interactable!
    var children: [ModernRIBs.Routing] = []
    
   // MARK: - lifecycle

    var lifecycle: AnyPublisher<ModernRIBs.RouterLifecycle, Never> {
        get { underlyingLifecycle }
        set(value) { underlyingLifecycle = value }
    }
    private var underlyingLifecycle: AnyPublisher<ModernRIBs.RouterLifecycle, Never>!
    
   // MARK: - load

    var loadCallsCount = 0
    var loadCalled: Bool {
        loadCallsCount > 0
    }
    var loadClosure: (() -> Void)?

    func load() {
        loadCallsCount += 1
        loadClosure?()
    }
    
   // MARK: - attachChild

    var attachChildCallsCount = 0
    var attachChildCalled: Bool {
        attachChildCallsCount > 0
    }
    var attachChildReceivedChild: ModernRIBs.Routing?
    var attachChildReceivedInvocations: [ModernRIBs.Routing] = []
    var attachChildClosure: ((ModernRIBs.Routing) -> Void)?

    func attachChild(_ child: ModernRIBs.Routing) {
        attachChildCallsCount += 1
        attachChildReceivedChild = child
        attachChildReceivedInvocations.append(child)
        attachChildClosure?(child)
    }
    
   // MARK: - detachChild

    var detachChildCallsCount = 0
    var detachChildCalled: Bool {
        detachChildCallsCount > 0
    }
    var detachChildReceivedChild: ModernRIBs.Routing?
    var detachChildReceivedInvocations: [ModernRIBs.Routing] = []
    var detachChildClosure: ((ModernRIBs.Routing) -> Void)?

    func detachChild(_ child: ModernRIBs.Routing) {
        detachChildCallsCount += 1
        detachChildReceivedChild = child
        detachChildReceivedInvocations.append(child)
        detachChildClosure?(child)
    }
}

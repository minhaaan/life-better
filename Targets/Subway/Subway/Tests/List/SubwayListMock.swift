@testable import Subway
import ModernRIBs
import Foundation
import Combine
import UIKit
import SubwayDetail
import SubwayCore

// MARK: SubwayListBuildableMock
final class SubwayListBuildableMock: SubwayListBuildable {
  
  var buildHandler: ((_ listener: SubwayListListener) -> SubwayListRouting)?
  
  var buildCallsCount = 0
  func build(withListener listener: Subway.SubwayListListener) -> Subway.SubwayListRouting {
    buildCallsCount += 1
    if let buildHandler {
      return buildHandler(listener)
    }
    fatalError()
  }
}

// MARK: SubwayListRoutingMock
final class SubwayListRoutingMock: SubwayListRouting {
  
  var viewControllable: ModernRIBs.ViewControllable
  var interactable: ModernRIBs.Interactable
  
  var children: [ModernRIBs.Routing] = []
  
  init(viewControllable: ModernRIBs.ViewControllable, interactable: ModernRIBs.Interactable) {
    self.viewControllable = viewControllable
    self.interactable = interactable
  }
  
  var loadCallsCount = 0
  func load() {
    loadCallsCount += 1
  }
  
  var attachChildCallsCount = 0
  func attachChild(_ child: ModernRIBs.Routing) {
    attachChildCallsCount += 1
  }
  
  var detachChildCallsCount = 0
  func detachChild(_ child: ModernRIBs.Routing) {
    detachChildCallsCount += 1
  }
  
  var lifecycle: AnyPublisher<ModernRIBs.RouterLifecycle, Never> {
    return PassthroughSubject<RouterLifecycle, Never>().eraseToAnyPublisher()
  }
  
  var attachSubwayDetailCallsCount = 0
  func attachSubwayDetail(station: SubwayStation) {
    attachSubwayDetailCallsCount += 1
  }
  
  var detachSubwayDetailCallsCount = 0
  func detachSubwayDetail() {
    detachSubwayDetailCallsCount += 1
  }
  
}

// MARK: SubwayListListnerMock
final class SubwayListListnerMock: SubwayListListener {
  
}

// MARK: SubwayListPresentable
final class SubwayListPresentableMock: SubwayListPresentable {
  var listener: Subway.SubwayListPresentableListener?
  
  var updateSubwayStationsCallsCount = 0
  var updatedSubwayStations: [SubwayStation] = []
  func updateSubwayStations(with subwayStations: [SubwayStation]) {
    updateSubwayStationsCallsCount += 1
    updatedSubwayStations = subwayStations
  }
}

// MARK: SubwayStationsMockData
let subwayStationsMockData: [SubwayStation] = [
  .init(subwayId: 1, stationId: 1, stationName: "1"),
  .init(subwayId: 2, stationId: 2, stationName: "2"),
  .init(subwayId: 3, stationId: 3, stationName: "3"),
  .init(subwayId: 4, stationId: 4, stationName: "4")
]

// MARK: SubwayListViewControllbleMock
final class SubwayListViewControllableMock: SubwayListViewControllable {
  var uiviewController: UIViewController
  
  var initCallsCount = 0
  init() {
    self.uiviewController = UIViewController()
  }
  
}

// MARK: - SubwayListInteractable -

final class SubwayListInteractableMock: SubwayListInteractable {
  var router: Subway.SubwayListRouting?
  var listener: Subway.SubwayListListener?
  
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
  
  var detachSubwayDetailCallsCount = 0
  func detachSubwayDetail() {
    detachSubwayDetailCallsCount += 1
    router?.detachSubwayDetail()
  }
}

// MARK: SubwayDetailBuildableMock
final class SubwayDetailBuildableMock: SubwayDetailBuildable {
  
  var buildHandler: ((_ listener: SubwayDetailListener) -> SubwayDetailRouting)?
  
  var buildCallsCount = 0
  func build(
    withListener listener: SubwayDetail.SubwayDetailListener,
    station: SubwayStation
  ) -> SubwayDetail.SubwayDetailRouting {
    buildCallsCount += 1
    if let buildHandler {
      return buildHandler(listener)
    }
    fatalError()
  }
}

// MARK: SubwayDetailListnerMock
final class SubwayDetailListnerMock: SubwayDetailListener {
  var detachSubwayDetailCallsCount = 0
  func detachSubwayDetail() {
    detachSubwayDetailCallsCount += 1
  }
}

// MARK: - SubwayDetailRoutingMock -

final class SubwayDetailRoutingMock: SubwayDetailRouting {
  
  // MARK: - viewControllable
  
  var viewControllable: ModernRIBs.ViewControllable
  var interactable: ModernRIBs.Interactable
  
  var children: [ModernRIBs.Routing] = []
  
  init(viewControllable: ModernRIBs.ViewControllable, interactable: ModernRIBs.Interactable) {
    self.viewControllable = viewControllable
    self.interactable = interactable
  }
  
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

// MARK: - SubwayDetailInteractableMock -

final class SubwayDetailInteractableMock: SubwayDetailInteractable {
    var router: SubwayDetail.SubwayDetailRouting?
    var listener: SubwayDetail.SubwayDetailListener?
    
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

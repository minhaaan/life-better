@testable import Subway
import ModernRIBs
import Foundation
import Combine
import UIKit

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
}

// MARK: SubwayListListnerMock
final class SubwayListListnerMock: SubwayListListener {
  
}

// MARK: SubwayListPresentable
final class SubwayListPresentableMock: SubwayListPresentable {
  var listener: Subway.SubwayListPresentableListener?
  
  var updateSubwayStationsCallsCount = 0
  var updatedSubwayStations: [SubwayStation] = []
  func updateSubwayStations(with subwayStations: [Subway.SubwayStation]) {
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

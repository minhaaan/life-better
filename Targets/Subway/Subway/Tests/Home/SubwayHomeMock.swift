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


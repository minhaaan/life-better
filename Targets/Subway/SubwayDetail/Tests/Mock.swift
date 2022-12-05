@testable import SubwayDetail
import Foundation
import Combine
import SubwayCore
import UIKit

// MARK: SubwayDetailPresentableMock
final class SubwayDetailPresentableMock: SubwayDetailPresentable {
  var listener: SubwayDetail.SubwayDetailPresentableListener?
  
  var arrivalData: PassthroughSubject<SubwayCore.RealtimeStationArrivalModel, Never> = .init()
}


// MARK: SubwayDetailListenerMock
final class SubwayDetailListenerMock: SubwayDetailListener {
  var detachSubwayDetailCallsCount = 0
  var detachSubwayDetailCalled = false
  func detachSubwayDetail() {
    detachSubwayDetailCallsCount += 1
    detachSubwayDetailCalled = true
  }
}

@testable import SubwayDetail
import Foundation
import Combine
import SubwayCore
import UIKit
import ModernRIBs

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

// MARK: PresentableInteractorMock
final class SubwayDetailPresentableInteractorMock: PresentableInteractor<SubwayDetailPresentable> {
}

// MARK: SubwayDetailInteractorMock
final class SubwayDetailPresentableListenerMock: SubwayDetailPresentableListener {
  
  var detachSubwayDetailCallsCount = 0
  var detachSubwayDetailCalled = false
  func detachSubwayDetail() {
    detachSubwayDetailCalled = true
    detachSubwayDetailCallsCount += 1
  }
  
  var getArrivalDataCallsCount = 0
  var getArrivalDataCalled = false
  func getArrivalData() {
    getArrivalDataCalled = true
    getArrivalDataCallsCount += 1
  }
}

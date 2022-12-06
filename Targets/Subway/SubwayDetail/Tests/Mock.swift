@testable import SubwayDetail
import Foundation
import Combine
import SubwayCore
import UIKit
import ModernRIBs

// MARK: SubwayDetailPresentableMock
final class SubwayDetailPresentableMock: SubwayDetailPresentable {
  
  var listener: SubwayDetail.SubwayDetailPresentableListener?
  
  var updateHeadingListCallsCount = 0
  var updateHeadingListCalled: Bool {
    updateHeadingListCallsCount > 0
  }
  func updateHeadingList(with: Set<String>) {
    updateHeadingListCallsCount += 1
  }
  
  var updateArrivalListCallsCount = 0
  var updateArrivalListCalled: Bool {
    updateArrivalListCallsCount > 0
  }
  func updateArrivalList(with: [SubwayCore.RealtimeArrivalList]) {
    updateArrivalListCallsCount += 1
  }
  
  var updateLabelTextCallsCount = 0
  var updateLabelTextCalled: Bool {
    updateLabelTextCallsCount > 0
  }
  func updateLabelText(with text: String) {
    updateLabelTextCallsCount += 1
  }
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
  
  var filterSelectedTrainLineNmWithListCallsCount = 0
  var filterSelectedTrainLineNmWithListCalled: Bool {
    filterSelectedTrainLineNmWithListCallsCount > 0
  }
  func filterSelectedTrainLineNmWithList(with trainLineName: String) {
    filterSelectedTrainLineNmWithListCallsCount += 1
  }
}

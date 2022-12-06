//
//  SubwayDetailViewControllerTests.swift
//  SubwayDetailTests
//
//  Created by 최민한 on 2022/12/06.
//  Copyright © 2022 com.minan. All rights reserved.
//

@testable import SubwayDetail
import XCTest
import SubwayCore
import SubwayNetworking
import ModernRIBs

final class SubwayDetailViewControllerTests: XCTestCase {
  
  var viewController: SubwayDetailViewController!
  let station = SubwayStation(subwayId: 1001, stationId: 1, stationName: "두류")
  var presentableInteractor: SubwayDetailPresentableInteractorMock!
  var presentableListener: SubwayDetailPresentableListenerMock!
  
  override func setUp() {
    self.viewController = SubwayDetailViewController(stationName: station.stationName)
    self.presentableInteractor = SubwayDetailPresentableInteractorMock(presenter: viewController)
    self.presentableListener = SubwayDetailPresentableListenerMock()
    viewController.listener = presentableListener
  }

  override func tearDown() {
    viewController.listener = nil
    presentableListener = nil
  }
  
  func test_Nav_Title() {
    // GIVEN

    // WHEN

    // THEN
    XCTAssert(viewController.navigationItem.title == "두류")
  }

  func test_backgroundColor() {
    // GIVEN

    // WHEN
    viewController.viewDidLoad()

    // THEN
    XCTAssert(viewController.view.backgroundColor == .systemBackground)
  }

  func test_updateArrivalList() {
    // GIVEN
    let mockRealtimeStationArrivalModel: RealtimeStationArrivalModel! = RealtimeStationArrivalModel(errorMessage: ErrorMessage(status: 1, code: "1", message: "1", link: "1", developerMessage: "1", total: 1), realtimeArrivalList: [.init(totalCount: 1, rowNum: 1, subwayId: "1", statnNm: "1", trainLineNm: "1 - 1", barvlDt: "1", recptnDt: "1", arvlMsg2: "1", arvlMsg3: "1", arvlCd: "1")])

    // WHEN
    viewController.updateArrivalList(with: mockRealtimeStationArrivalModel.realtimeArrivalList)

    // THEN
    XCTAssert(viewController.list.first?.barvlDt == mockRealtimeStationArrivalModel.realtimeArrivalList.first?.barvlDt)
  }

  func test_didMove_to_listner_detach() {
    // GIVEN

    // WHEN
    viewController.viewDidLoad()
    viewController.didMove(toParent: nil)

    // THEN
    XCTAssert(presentableListener.detachSubwayDetailCalled)
    XCTAssert(presentableListener.detachSubwayDetailCallsCount == 1)
  }
  
  func test_When_ViewDIdLoad_call_getArrivalData() {
    // GIVEN
    
    // WHEN
    viewController.viewDidLoad()
    
    // THEN
    XCTAssert(presentableListener.getArrivalDataCalled)
    XCTAssert(presentableListener.getArrivalDataCallsCount > 0)
  }
  
  func test_filterSelectedTrainLineNmWithList() {
    // GIVEN
    let mockRealtimeArrivalList: [RealtimeArrivalList] = [
      .init(totalCount: 1, rowNum: 1, subwayId: "1", statnNm: "1", trainLineNm: "1 - 1", barvlDt: "1", recptnDt: "1", arvlMsg2: "1", arvlMsg3: "1", arvlCd: "1"),
      .init(totalCount: 2, rowNum: 2, subwayId: "2", statnNm: "2", trainLineNm: "2 - 2", barvlDt: "2", recptnDt: "2", arvlMsg2: "2", arvlMsg3: "2", arvlCd: "2")
    ]
    
    // WHEN
    viewController.viewDidLoad()
    viewController.list = mockRealtimeArrivalList
    viewController.filterSelectedTrainLineNmWithList(with: "2")
    
    // THEN
    XCTAssert(viewController.list.count == 1)
    XCTAssert(viewController.label.text == "2")
  }
  
  func test_updateHeadingList() {
    // GIVEN
    let mockHeadingList: Set<String> = ["1", "2"]
    
    // WHEN
    viewController.updateHeadingList(with: mockHeadingList)
    
    // THEN
    XCTAssert(viewController.heading.count == 2)
    XCTAssert(viewController.heading.contains("1"))
  }
  
}

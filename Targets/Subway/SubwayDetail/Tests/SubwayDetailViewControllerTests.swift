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
    viewController = nil
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
  
  func test_updateHeadingList() {
    // GIVEN
    let mockHeadingList: Set<String> = ["1", "2"]
    
    // WHEN
    viewController.updateHeadingList(with: mockHeadingList)
    
    // THEN
    XCTAssert(viewController.heading.count == 2)
    XCTAssert(viewController.heading.contains("1"))
  }
  
  func test_updateLabelText() {
    // GIVEN
    let text = "123"
    
    // WHEN
    viewController.updateLabelText(with: text)
    
    // THEN
    viewController.label.text = text
  }
  
}

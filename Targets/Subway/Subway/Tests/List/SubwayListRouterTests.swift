//
//  SubwayListRouterTests.swift
//  Subway
//
//  Created by 최민한 on 2022/11/28.
//  Copyright © 2022 com.minan. All rights reserved.
//

@testable import Subway
import XCTest
import SubwayDetail
import SubwayCore

final class SubwayListRouterTests: XCTestCase {
  
  private var router: SubwayListRouter!
  private var subwayListInteractor: SubwayListInteractableMock!
  private var subwayListViewControllable: SubwayListViewControllableMock!
  private var subwayDetailBuildable: SubwayDetailBuildableMock!
  private var subwayDetailListner: SubwayDetailListener!
  private var subwayDetailRouting: SubwayDetailRoutingMock!
  private var subwayDetailInteractable: SubwayDetailInteractableMock!
  
  // TODO: declare other objects and mocks you need as private vars
  
  override func setUp() {
    super.setUp()
    
    /*
     interactor, viewController, detailBuilderMock 필요
     */
    
    self.subwayListInteractor = SubwayListInteractableMock()
    self.subwayListViewControllable = SubwayListViewControllableMock()
    self.subwayDetailBuildable = SubwayDetailBuildableMock()
    self.subwayDetailListner = SubwayDetailListnerMock()
    self.subwayDetailInteractable = SubwayDetailInteractableMock()
    self.subwayDetailRouting = SubwayDetailRoutingMock(
      viewControllable: SubwayListViewControllableMock(),
      interactable: subwayDetailInteractable
    )
    
    
    self.subwayDetailBuildable.buildHandler = { (listner: SubwayDetailListener) -> SubwayDetailRouting in
      self.subwayDetailListner = listner
      return self.subwayDetailRouting
    }
    
    // TODO: instantiate objects and mocks
    self.router = SubwayListRouter(
      interactor: subwayListInteractor,
      viewController: subwayListViewControllable,
      subwayDetailBuilder: subwayDetailBuildable
    )
  }
  
  // MARK: - Tests
 
  func test_attachSubwayDetail() {
    // GIVEN
    let subwayStation = SubwayStation(subwayId: 1001, stationId: 1, stationName: "두류")
    
    // WHEN
    router.attachSubwayDetail(station: subwayStation)
    
    // THEN
    XCTAssert(subwayDetailBuildable.buildCallsCount == 1)
    XCTAssert(subwayDetailRouting.loadCalled == true)
    XCTAssert(subwayDetailInteractable.activateCalled)
    XCTAssert(subwayDetailInteractable.activateCallsCount == 1)
  }
  
  func test_detachSubwayDetail() {
    // GIVEN
    let station = SubwayStation(subwayId: 1001, stationId: 1, stationName: "두류")
    
    // WHEN
    router.attachSubwayDetail(station: station)
    router.detachSubwayDetail()
    
    // THEN
    XCTAssert(subwayDetailInteractable.deactivateCalled)
    XCTAssert(subwayDetailInteractable.deactivateCallsCount == 1)
  }
  
}

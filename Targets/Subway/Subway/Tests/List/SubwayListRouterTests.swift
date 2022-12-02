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

final class SubwayListRouterTests: XCTestCase {
  
  private var router: SubwayListRouter!
  private var subwayListInteractor: SubwayListInteractableMock!
  private var subwayListViewControllable: SubwayListViewControllableMock!
  private var subwayDetailBuildable: SubwayDetailBuildableMock!
  private var subwayDetailListner: SubwayDetailListener!
  private var subwayDetailRouting: SubwayDetailRoutingMock!
  
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
    self.subwayDetailRouting = SubwayDetailRoutingMock(
      viewControllable: SubwayListViewControllableMock(),
      interactable: subwayListInteractor
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
    let stationName: String = "죽전"
    
    // WHEN
    router.attachSubwayDetail(stationName: stationName)
    
    // THEN
    XCTAssert(subwayDetailBuildable.buildCallsCount == 1)
    XCTAssert(subwayDetailRouting.loadCalled == true)
  }
  
}

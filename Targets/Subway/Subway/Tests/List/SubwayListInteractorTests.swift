//
//  SubwayListInteractorTests.swift
//  Subway
//
//  Created by 최민한 on 2022/11/28.
//  Copyright © 2022 com.minan. All rights reserved.
//

@testable import Subway
import XCTest

final class SubwayListInteractorTests: XCTestCase {
  
  private var interactor: SubwayListInteractor!
  private var subwayListPresentable: SubwayListPresentableMock!
  private var subwayListRouter: SubwayListRoutingMock!
  
  // TODO: declare other objects and mocks you need as private vars
  
  override func setUp() {
    super.setUp()
    
    self.subwayListPresentable = SubwayListPresentableMock()
    
    interactor = SubwayListInteractor(
      presenter: self.subwayListPresentable,
      subwayStation: subwayStationsMockData
    )
    
    self.subwayListRouter = SubwayListRoutingMock(
      viewControllable: SubwayListViewControllableMock(),
      interactable: interactor
    )
    interactor.router = self.subwayListRouter
  }
  
  // MARK: - Tests
  
  func test_updateSearchKeywordWithEmptyString() {
    // GIVEN
    
    // WHEN
    interactor.updateSearchKeyword(keyword: "")
    
    // THEN
    XCTAssert(subwayListPresentable.updateSubwayStationsCallsCount == 1)
    XCTAssert(subwayListPresentable.updatedSubwayStations == subwayStationsMockData)
  }
  
  func test_updateSearchKeywordWith1() {
    // GIVEN
    
    // WHEN
    interactor.updateSearchKeyword(keyword: "1")
    
    // THEN
    XCTAssert(subwayListPresentable.updateSubwayStationsCallsCount == 1)
    XCTAssertTrue(subwayListPresentable.updatedSubwayStations.count == 1)
    XCTAssert(subwayListPresentable.updatedSubwayStations.first?.stationName == "1")
  }
  
  func test_listCell_Tapped() {
    // GIVEN
    
    // WHEN
    interactor.didTapSubwayStation(stationName: "")
    
    // THEN
    XCTAssert(subwayListRouter.attachSubwayDetailCallsCount == 1)
  }
  
  func test_detachSubwayDetail_Call() {
    // GIVEN
    
    // WHEN
    interactor.detachSubwayDetail()
    
    // THEN
    XCTAssert(subwayListRouter.detachSubwayDetailCallsCount == 1)
  }
}

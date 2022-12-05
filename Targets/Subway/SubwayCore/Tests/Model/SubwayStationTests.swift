//
//  SubwayStationTests.swift
//  SubwayTests
//
//  Created by 최민한 on 2022/12/06.
//  Copyright © 2022 com.minan. All rights reserved.
//
@testable import SubwayCore
import XCTest

final class SubwayStationTests: XCTestCase {
    
  override func setUpWithError() throws {
  }
  
  override func tearDownWithError() throws {
  }
  
  func test_getLineImageName() {
    // GIVEN
    let subwayStation = SubwayStation(subwayId: 1001, stationId: 1002000218, stationName: "두류")
    let mock1 = SubwayStation(subwayId: 1092, stationId: 12321, stationName: "1")
    
    // WHEN
    let result = subwayStation.lineImageName
    
    // THEN
    XCTAssert(result == 1)
    XCTAssert(mock1.lineImageName == 92)
  }
  
  func test_lineImage() {
    // GIVEN
    let subwayStation = SubwayStation(subwayId: 1001, stationId: 1002000218, stationName: "두류")
    let mock1 = SubwayStation(subwayId: 1092, stationId: 12321, stationName: "1")
    
    // WHEN
    let image = subwayStation.lineImage
    let nilImage = mock1.lineImage
    
    // THEN
    XCTAssert(image != nil)
    XCTAssert(nilImage == nil)
  }
  
}

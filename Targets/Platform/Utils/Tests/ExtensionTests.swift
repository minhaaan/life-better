//
//  ExtensionTests.swift
//  UtilsTests
//
//  Created by 최민한 on 2022/12/05.
//  Copyright © 2022 com.minan. All rights reserved.
//

import XCTest
import Utils

final class ExtensionTests: XCTestCase {

  override func setUp() {
    
  }
  
  override func tearDown() {
    
  }

  func test_Collection_isNotEmpty() {
    // GIVEN
    let emptyArray: [Int] = []
    let notEmptyarray: [Int] = [1,2,3]
    let emptyDic: [String: String] = [:]
    let notEmptyDic: [String: String] = ["1": "2"]
    
    // WHEN
    
    // THEN
    XCTAssert(emptyArray.isNotEmpty == false)
    XCTAssert(notEmptyarray.isNotEmpty)
    XCTAssert(emptyDic.isNotEmpty == false)
    XCTAssert(notEmptyDic.isNotEmpty)
  }
  
}

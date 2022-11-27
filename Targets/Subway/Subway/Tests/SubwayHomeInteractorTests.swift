//
//  SubwayHomeInteractorTests.swift
//  SubwayTests
//
//  Created by 최민한 on 2022/11/27.
//  Copyright © 2022 com.minan. All rights reserved.
//

@testable import Subway
import XCTest

final class SubwayHomeInteractorTests: XCTestCase {
  
  private var interactor: SubWayHomeInteractorMock!
  private var presentable: SubwayHomePresentableMock!
  private var listener: SubwayHomeListenerMock!
  private var router: SubWayHomeRouter!
  
  // TODO: declare other objects and mocks you need as private vars
  
  override func setUp() {
    super.setUp()
    
    self.presentable = SubwayHomePresentableMock()
    self.interactor = SubWayHomeInteractorMock(presenter: self.presentable)
    self.listener = SubwayHomeListenerMock()
    interactor.listener = listener
    interactor.router = self.router
  }
  
  // MARK: - Tests
  
  func test_SubwayHomePresentableMock에서_detachSubwayHome이_호출됐을때() {
    // GIVEN
    
    // WHEN
    presentable.listener?.detachSubwayHome()
    
    // THEN
    XCTAssert(interactor.detachSubwayHomeCallCount == 1)
    XCTAssert(listener.detachSubwayHomeCallsCount == 1)
  }
}

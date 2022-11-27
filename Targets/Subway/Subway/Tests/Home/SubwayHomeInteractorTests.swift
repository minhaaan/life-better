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
  
  private var interactor: SubWayHomeInteractor!
  private var presentable: SubwayHomePresentableMock!
  private var listener: SubWayHomeListenerMock!
  private var router: SubWayHomeRouter!
  
  // TODO: declare other objects and mocks you need as private vars
  
  override func setUp() {
    super.setUp()
    
    self.presentable = SubwayHomePresentableMock()
    self.interactor = SubWayHomeInteractor(presenter: self.presentable)
    self.listener = SubWayHomeListenerMock()
    interactor.listener = listener
    interactor.router = self.router
  }
  
  // MARK: - Tests
  
  func test_SubwayHomePresentableMock에서_detachSubwayHome이_호출됐을때() {
    // GIVEN
    
    // WHEN
    presentable.listener?.detachSubwayHome()
    
    // THEN
    XCTAssert(listener.detachSubwayHomeCallsCount == 1)
  }
}

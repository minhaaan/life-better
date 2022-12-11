//
//  SubwayHomeRouterTests.swift
//  SubwayTests
//
//  Created by 최민한 on 2022/11/27.
//  Copyright © 2022 com.minan. All rights reserved.
//

@testable import Subway
import XCTest

final class SubwayHomeRouterTests: XCTestCase {
  
  private var router: SubWayHomeRouter!
  private var subwayHomeViewControllable: SubwayHomeViewControllableMock!
  private var subwayHomeInteratable: SubwayHomeInteratableMock!
  private var subwayListBuildable: SubwayListBuildableMock!
  private var subwayListRouting: SubwayListRoutingMock!
  private var subwayListLister: SubwayListListener!
  
  // TODO: declare other objects and mocks you need as private vars
  
  override func setUp() {
    super.setUp()
    self.subwayHomeViewControllable = SubwayHomeViewControllableMock()
    self.subwayHomeInteratable = SubwayHomeInteratableMock()
    self.subwayListBuildable = SubwayListBuildableMock()
    self.subwayListRouting = SubwayListRoutingMock(viewControllable: subwayHomeViewControllable, interactable: subwayHomeInteratable)
    self.subwayListLister = SubwayListListnerMock()
    subwayListBuildable.buildHandler = { (listner: SubwayListListener) -> SubwayListRouting in
      self.subwayListLister = listner
      return self.subwayListRouting
    }
    router = SubWayHomeRouter(
      interactor: self.subwayHomeInteratable,
      viewController: self.subwayHomeViewControllable,
      subwayListBuilder: self.subwayListBuildable
    )
  }
  
  // MARK: - Tests
  
  func test_attachSubwayList() {
    // GIVEN
    
    // WHEN
    router.didLoad()
    
    // THEN
    XCTAssert(subwayListBuildable.buildCallsCount == 1)
    XCTAssert(subwayHomeViewControllable.addChildSubwayListViewControllerCallsCount == 1)
    XCTAssert(subwayListRouting.loadCallsCount == 1)
    XCTAssert(subwayHomeInteratable.activateCallsCount == 1)
  }
}

//
//  RootListRouterTests.swift
//  LifeBetter
//
//  Created by 최민한 on 2022/12/11.
//  Copyright © 2022 com.minan. All rights reserved.
//

@testable import LifeBetter
import XCTest
import Subway

final class RootListRouterTests: XCTestCase {
  
  private var router: RootListRouter!
  private var rootListInteractor: RootListInteractorMock!
  private var rootListViewControllable: RootListViewControllableMock!
  private var subwayHomeBuildable: SubwayHomeBuildableMock!
  private var subwayHomeInteractor: SubWayHomeInteractableMock!
  private var subwayHomeViewcontrollable: SubwayHomeViewControllableMock!
  private var subwayHomeRouting: SubwayHomeRouterMock!
  
  // TODO: declare other objects and mocks you need as private vars
  
  override func setUp() {
    super.setUp()
    self.rootListInteractor = RootListInteractorMock()
    self.rootListViewControllable = RootListViewControllableMock()
    self.subwayHomeInteractor = SubWayHomeInteractableMock()
    self.subwayHomeViewcontrollable = SubwayHomeViewControllableMock()
    self.subwayHomeRouting = SubwayHomeRouterMock(
      interactable: subwayHomeInteractor,
      viewControllable: subwayHomeViewcontrollable
    )
    self.subwayHomeBuildable = SubwayHomeBuildableMock()
    subwayHomeBuildable.buildHandler = { listener -> SubWayHomeRouting in
      return self.subwayHomeRouting
    }
    
    router = RootListRouter(
      interactor: rootListInteractor,
      viewController: RootListViewController(contents: []),
      subwayHomeBuilder: subwayHomeBuildable
    )
  }
  
  // MARK: - Tests
  
  func test_presentSubwayHome() {
    // GIVEN
    
    // WHEN
    router.presentSubwayHome()
    
    // THEN
    XCTAssert(subwayHomeBuildable.buildCallCount == 1)
  }
  
  func test_detachSubwayHome() {
    // GIVEN
    
    // WHEN
    router.presentSubwayHome()
    router.detachSubwayHome()
    
    // THEN
    XCTAssert(subwayHomeInteractor.deactivateCallsCount == 1)
  }
}

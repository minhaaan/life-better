//
//  RootRouterTests.swift
//  LifeBetterTests
//
//  Created by 최민한 on 2022/11/27.
//  Copyright © 2022 com.minan. All rights reserved.
//

@testable import LifeBetter
import XCTest
import Subway

final class RootRouterTests: XCTestCase {
  
  var router: RootRouter!
  var rootInteractable: RootInteractableMock!
  var rootViewControllable: RootViewControllableMock!
  var rootListBuildable: RootListBuildableMock!
  var rootListRouting: RootListRouting!
  var rootListViewControllable: RootListViewControllableMock!
  
  override func setUp() {
    self.rootInteractable = RootInteractableMock()
    self.rootViewControllable = RootViewControllableMock()
    self.rootListBuildable = RootListBuildableMock()
    self.rootListViewControllable = RootListViewControllableMock()
    self.rootListRouting = RootListRoutingMock(
      viewControllable: RootListViewController(contents: []),
      interactable: RootListInteractorMock()
    )
    rootListBuildable.buildHandler = { listener -> RootListRouting in
      return self.rootListRouting
    }
    
    router = RootRouter(
      interactor: rootInteractable,
      viewController: RootViewController(),
      rootListBuilder: rootListBuildable
    )
  }
  
  override func tearDown() {
    
  }
  
  // MARK: Tests
  
  func test_attachRootList() {
    // GIVEN
    
    // WHEN
    router.didLoad()
    
    // THEN
    XCTAssert(rootListBuildable.buildCallsCount == 1)
  }
  
}



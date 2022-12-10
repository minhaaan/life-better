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
  
  override func setUp() {
    self.rootInteractable = RootInteractableMock()
    self.rootViewControllable = RootViewControllableMock()
    self.rootListBuildable = RootListBuildableMock()
    self.rootListRouting = RootListRoutingMock(
      viewControllable: RootListViewController(contents: []),
      interactable: RootListInteractorMock()
    )
    rootListBuildable.buildHandler = { listener -> RootListRouting in
      return self.rootListRouting
    }
    
    router = RootRouter(
      interactor: rootInteractable,
      viewController: rootViewControllable,
      rootListBuilder: rootListBuildable
    )
  }
  
  override func tearDown() {
    
  }
  
  // MARK: Tests
  
  
}



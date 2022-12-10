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

  private var router: RootRouter!
  private var interactor: RootInteractor!
  private var subwayHomeBuildable: SubwayHomeBuildableMock!
  private var subWayHomeInteractable: SubWayHomeInteractableMock!
  public var subwayHomeRouter: SubwayHomeRouterMock!
  public var subwayHomeViewControllableMock: SubwayHomeViewControllableMock!
  var rootListBuildable: RootListBuildableMock!
  var rootListInteractor: RootListInteractorMock!
  var rootListRouting: RootListRoutingMock!

  // TODO: declare other objects and mocks you need as private vars

  override func setUp() {
    super.setUp()

    let presenter = RootPresentableMock(listener: RootPresentableListenerMock())
    interactor = RootInteractor(presenter: presenter)
    subwayHomeViewControllableMock = SubwayHomeViewControllableMock()
    subWayHomeInteractable = SubWayHomeInteractableMock()
    subwayHomeRouter = SubwayHomeRouterMock(interactable: subWayHomeInteractable, viewControllable: subwayHomeViewControllableMock)
    var subwayHomeListener: SubWayHomeListener? = nil
    self.subwayHomeBuildable = SubwayHomeBuildableMock()
    subwayHomeBuildable.buildHandler = { listener -> SubWayHomeRouting in
      subwayHomeListener = listener
      return self.subwayHomeRouter
    }
    self.rootListBuildable = RootListBuildableMock()
    self.rootListInteractor = RootListInteractorMock()
    self.rootListRouting = RootListRoutingMock(viewControllable: RootListViewController(contents: []), interactable: self.rootListInteractor)
    var rootListListener: RootListListener? = nil
    rootListBuildable.buildHandler = { listener -> RootListRouting in
      rootListListener = listener
      return self.rootListRouting
    }
    
    self.router = RootRouter(
      interactor: interactor,
      viewController: RootViewController(),
      subwayHomeBuilder: self.subwayHomeBuildable,
      rootListBuilder: self.rootListBuildable
    )
  }

  // MARK: - Tests

  func test_routeToExample_invokesToExampleResult() {
    // GIVEN

    // WHEN
    router.routeToSubwayHome()

    // THEN
    XCTAssert(subWayHomeInteractable.activateCallsCount == 1)
    XCTAssert(subwayHomeBuildable.buildCallCount == 1)
    XCTAssert(subwayHomeRouter.loadCallCount == 1)
  }
  
  func test_detachSubwayHome() {
    // GIVEN
    
    // WHEN
    router.routeToSubwayHome()
    XCTAssert(subWayHomeInteractable.deactivateCallsCount == 0)
    
    router.detachSubwayHome()
    
    // THEN
    XCTAssert(subWayHomeInteractable.deactivateCalled)
    XCTAssert(subWayHomeInteractable.deactivateCallsCount == 1)
  }
  
  func test_attachRootList() {
    // GIVEN
    
    
    // WHEN
    router.didLoad()
    
    // THEN
    XCTAssert(rootListBuildable.buildCallsCount == 1)
    XCTAssert(rootListRouting.loadCalled)
    XCTAssert(rootListRouting.loadCallsCount == 1)
  }
}

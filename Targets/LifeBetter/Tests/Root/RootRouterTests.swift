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
  private var subWayHomeInteractable: SubWayHomeInteractorMock!
  public var subwayHomeRouter: SubwayHomeRouterMock!
  public var subwayHomeViewControllableMock: SubwayHomeViewControllableMock!

  // TODO: declare other objects and mocks you need as private vars

  override func setUp() {
    super.setUp()

    let presenter = RootPresentableMock(listener: RootPresentableListenerMock())
    interactor = RootInteractor(presenter: presenter)
    subwayHomeViewControllableMock = SubwayHomeViewControllableMock()
    subWayHomeInteractable = SubWayHomeInteractorMock(presenter: SubwayHomePresentableMock())
    subwayHomeRouter = SubwayHomeRouterMock(interactable: subWayHomeInteractable, viewControllable: subwayHomeViewControllableMock)
    var subwayHomeListener: SubWayHomeListener? = nil
    self.subwayHomeBuildable = SubwayHomeBuildableMock()
    subwayHomeBuildable.buildHandler = { listener -> SubWayHomeRouting in
      subwayHomeListener = listener
      return self.subwayHomeRouter
    }
    
    self.router = RootRouter(
      interactor: interactor,
      viewController: RootViewController(),
      subwayHomeBuilder: self.subwayHomeBuildable
    )
  }

  // MARK: - Tests

  func test_routeToExample_invokesToExampleResult() {
    // GIVEN

    // WHEN
    router.routeToSubwayHome()

    // THEN
    XCTAssert(subWayHomeInteractable.didBecomeActiveCallCount == 1)
    XCTAssert(subwayHomeBuildable.buildCallCount == 1)
    XCTAssert(subwayHomeRouter.loadCallCount == 1)
  }
  
  func test_detachSubwayHome() {
    // GIVEN
    
    // WHEN
    router.routeToSubwayHome()
    router.detachSubwayHome()
    
    // THEN
    XCTAssert(subWayHomeInteractable.willResignActiveCallCount == 1)
  }
}
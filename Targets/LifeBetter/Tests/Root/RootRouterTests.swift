////
////  RootRouterTests.swift
////  LifeBetterTests
////
////  Created by 최민한 on 2022/11/27.
////  Copyright © 2022 com.minan. All rights reserved.
////
//
//@testable import LifeBetter
//import XCTest
//import Subway
//
//final class RootRouterTests: XCTestCase {
//
//  private var router: RootRouter!
//  private var interactor: RootInteractor!
//  private var subwayHomeBuildable: SubwayHomeBuildableMock!
//
//  // TODO: declare other objects and mocks you need as private vars
//
//  override func setUp() {
//    super.setUp()
//
//    let presenter = RootPresentableMock(listener: RootPresentableListenerMock())
//    interactor = RootInteractor(presenter: presenter)
//    self.subwayHomeBuildable = SubwayHomeBuildableMock()
//    self.router = RootRouter(
//      interactor: interactor,
//      viewController: RootViewController(),
//      subwayHomeBuilder: self.subwayHomeBuildable
//    )
//  }
//
//  // MARK: - Tests
//
//  func test_routeToExample_invokesToExampleResult() {
//    // GIVEN
//
//    // WHEN
//    router.routeToSubwayHome()
//
//    // THEN
//    XCTAssert(subwayHomeBuildable.buildCallCount == 1)
//  }
//}

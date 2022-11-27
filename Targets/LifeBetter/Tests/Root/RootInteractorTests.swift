//
//  RootInteractorTests.swift
//  LifeBetterTests
//
//  Created by 최민한 on 2022/11/27.
//  Copyright © 2022 com.minan. All rights reserved.
//

@testable import LifeBetter
import Subway
import XCTest

final class RootInteractorTests: XCTestCase {
  
  private var interactor: RootInteractorMock!
  private var presentableListener: RootPresentableListenerMock!
  private var presenter: RootPresentableMock!
  private var router: RootRouterMock!
  
  // TODO: declare other objects and mocks you need as private vars
  
  override func setUp() {
    super.setUp()
    
    presentableListener = RootPresentableListenerMock()
    presenter = RootPresentableMock(listener: self.presentableListener)
    interactor = RootInteractorMock(presenter: self.presenter)
    router = RootRouterMock(
      interactor: self.interactor,
      viewController: RootViewController(),
      subwayHomeBuilder: SubWayHomeBuilder(dependency: RootComponent(dependency: AppComponent()))
    )
  }
  
  // MARK: - Tests
  
  func test_RootPresentableListener에서_showSubwayHome가_호출됐을때() {
    // GIVEN
    
    // WHEN
    presenter.listener?.showSubwayHome()
    
    //THEN
    XCTAssert(interactor.showSubwayHomeCallcount == 1)
    XCTAssert(router.routeToSubwayHomeCalled == true)
    XCTAssert(router.routeToSubwayHomeCallsCount == 1)
  }
  
  func test_detachSubwayHome이_호출됐을때() {
    // GIVEN
    
    // WHEN
    interactor.detachSubwayHome()
    
    // THEN
    XCTAssert(router.detachSubwayHomeCalled == true)
    XCTAssert(router.detachSubwayHomeCallsCount == 1)
  }

}

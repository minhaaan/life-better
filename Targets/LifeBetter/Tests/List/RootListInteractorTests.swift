@testable import LifeBetter
import XCTest

final class RootListInteractorTests: XCTestCase {
  
  private var interactor: RootListInteractor!
  private var rootListPresentable: RootListPresentable!
  private var rootListRouting: RootListRoutingMock!
  
  override func setUp() {
    super.setUp()
    self.rootListPresentable = RootListPresentableMock()
    
    interactor = RootListInteractor(
      presenter: rootListPresentable
    )
    self.rootListRouting = RootListRoutingMock(
      viewControllable: RootListViewController(contents: []),
      interactable: interactor
    )
    interactor.router = rootListRouting
  }
  
  // MARK: - Tests
  
  func test_exampleObservable_callsRouterOrListener_exampleProtocol() {
    // GIVEN
    
    // WHEN
    interactor.attachSubway()
    
    // THEN
    XCTAssert(rootListRouting.presentSubwayHomeCallsCount == 1)
  }
  
  func test_detachSubwayHome() {
    // GIVEN
    
    // WHEN
    interactor.detachSubwayHome()
    
    // THEN
    XCTAssert(rootListRouting.detachSubwayHomeCallsCount == 1)
  }
}

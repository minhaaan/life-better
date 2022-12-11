@testable import Subway
import XCTest

final class SubwayHomeViewContorllerTests: XCTestCase {
  
  var viewController: SubWayHomeViewController!
  var presentableListener: SubWayHomePresentableListenerMock!
  
  override func setUpWithError() throws {
    presentableListener = SubWayHomePresentableListenerMock()
    
    viewController = SubWayHomeViewController()
    viewController.listener = presentableListener
  }
  
  override func tearDownWithError() throws {
  }
  
  func test_detachSubwayHome() {
    // GIVEN
    
    // WHEN
    viewController.didMove(toParent: nil)
    
    // THEN
    XCTAssert(presentableListener.detachSubwayHomeCallsCount == 1)
  }
  
}

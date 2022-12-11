@testable import LifeBetter
import XCTest
import UIKit
import SnapshotTesting

final class RootListViewControllerTests: XCTestCase {
  
  private var viewController: RootListViewController!
  private var contents: [Content]!
  private var rootListPresentableListener: RootListPresentableListenerMock!
  
  override func setUpWithError() throws {
    self.contents = [
      Content(imageName: "", name: "SUBWAY"),
      Content(imageName: "", name: "TBD..")
    ]
    self.rootListPresentableListener = RootListPresentableListenerMock()
    
    self.viewController = RootListViewController(contents: contents)
    viewController.listener = rootListPresentableListener
  }
  
  override func tearDownWithError() throws {
    
  }
  
  // MARK: Tests
  
  func test_SUBWAY_셀_탭_했을때_attachSubway호출(){
    // GIVEN
    let mockCollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
    let mockIndexPath = IndexPath(item: 0, section: 0)
    
    // WHEN
    viewController.viewDidLoad()
    viewController.collectionView(
      mockCollectionView,
      didSelectItemAt: mockIndexPath
    )
    
    // THEN
    XCTAssert(rootListPresentableListener.attachSubwayCalled)
    XCTAssert(rootListPresentableListener.attachSubwayCallsCount == 1)
  }
  
  func test_snapshot() {
    // GIVEN
    
    // WHEN
    viewController.viewDidLoad()
    
    // THEN
    assertSnapshot(
      matching: viewController,
      as: .image(on: .iPhone13)
    )
  }
  
}

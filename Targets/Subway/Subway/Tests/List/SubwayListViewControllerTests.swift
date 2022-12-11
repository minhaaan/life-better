//
//  SubwayListViewControllerTests.swift
//  SubwayTests
//
//  Created by 최민한 on 2022/12/11.
//  Copyright © 2022 com.minan. All rights reserved.
//

@testable import Subway
import XCTest
import SubwayCore

final class SubwayListViewControllerTests: XCTestCase {
  
  var viewController: SubwayListViewController!
  var presentableListener: SubwayListPresentableListenerMock!
  
  let mockSubwayStations: [SubwayStation] = [
    .init(subwayId: 1, stationId: 1, stationName: "1"),
    .init(subwayId: 2, stationId: 2, stationName: "2"),
    .init(subwayId: 3, stationId: 3, stationName: "3")
  ]
  let mockCollectionView = UICollectionView(
    frame: .zero,
    collectionViewLayout: UICollectionViewLayout()
  )
  
  override func setUpWithError() throws {
    self.presentableListener = SubwayListPresentableListenerMock()
    
    self.viewController = SubwayListViewController()
    viewController.listener = presentableListener
  }
  
  override func tearDownWithError() throws {
  }
  
  // MARK: Tests
  
  func test_updateSearchKeyword() {
    // GIVEN
    let mockSearchBar = UISearchBar()
    let mockSearchKeyword = "낙성대"
    
    // WHEN
    viewController.searchBar(
      mockSearchBar,
      textDidChange: mockSearchKeyword
    )
    
    // THEN
    XCTAssert(presentableListener.updateSearchKeywordKeywordCalled)
    XCTAssert(presentableListener.updateSearchKeywordKeywordCallsCount == 1)
  }
  
  func test_올바른_셀_didTapSubwayStation() {
    // GIVEN
    
    // WHEN
    viewController.updateSubwayStations(with: mockSubwayStations)
    viewController.collectionView(
      mockCollectionView,
      didSelectItemAt: IndexPath(item: 2, section: 0)
    )
    
    // THEN
    XCTAssert(presentableListener.didTapSubwayStationStationCalled)
    XCTAssert(presentableListener.didTapSubwayStationStationCallsCount == 1)
  }
  
  func test_unsafe_index_didTapSubwayStation() {
    // GIVEN
    
    // WHEN
    viewController.collectionView(
      mockCollectionView,
      didSelectItemAt: IndexPath(item: 2, section: 0)
    )
    
    // THEN
    XCTAssert(presentableListener.didTapSubwayStationStationCalled == false)
  }
  
  func test_cellForItemAt() {
    // GIVEN
    mockCollectionView.register(
      UICollectionViewListCell.self,
      forCellWithReuseIdentifier: "cell"
    )
    viewController.updateSubwayStations(with: mockSubwayStations)
    
    // WHEN
    let sut = viewController.collectionView(
      mockCollectionView,
      cellForItemAt: IndexPath(item: 2, section: 0)
    )
    
    // THEN
    XCTAssertNotNil(sut.contentConfiguration)
  }
  
  func test_numberOfItemsInSection() {
    // GIVEN
    viewController.updateSubwayStations(with: mockSubwayStations)
    
    // WHEN
    let sut = viewController.collectionView(
      mockCollectionView,
      numberOfItemsInSection: 0
    )
    
    // THEN
    XCTAssert(sut == 3)
  }
  
}

@testable import Subway
import XCTest

final class SubWayHomeComponentTests: XCTestCase {
  
  private var sut: SubWayHomeComponent!
  
  override func setUpWithError() throws {
    self.sut = SubWayHomeComponent()
  }
  
  override func tearDownWithError() throws {
  }
  
  func test_subwayStationListValue() {
    // GIVEN
    // WHEN
    
    // THEN
    XCTAssert(sut.subwayStations.isEmpty == false)
    XCTAssert(sut.subwayStations.first?.stationName == "소요산")
  }
  
  func test_loadSubwayStationList() {
    // GIVEN
    let fileName = "subway-station-list"
    let withExtension = "json"
    
    // WHEN
    let subwayStations = sut.loadSubwayStationList(
      fileName: fileName,
      withExtension: withExtension
    )
    
    // THEN
    XCTAssert(subwayStations.isEmpty == false)
    XCTAssert(subwayStations.first?.stationName == "소요산")
  }
  
  func test_loadJsonToStationList_withWrongFileName() {
    // GIVEN
    let fileName = "subway-station-123asdf"
    let withExtension = "png"
    
    // WHEN
    let subwayStations = sut.loadSubwayStationList(
      fileName: fileName,
      withExtension: withExtension
    )
    
    // THEN
    XCTAssert(subwayStations.isEmpty)
    XCTAssert(subwayStations.first == nil)
  }
  
}

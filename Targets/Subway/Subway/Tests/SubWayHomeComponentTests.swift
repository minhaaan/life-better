@testable import Subway
import XCTest

final class SubWayHomeComponentTests: XCTestCase {
  
  private var sut: SubWayHomeComponent!
  
  override func setUpWithError() throws {
    self.sut = SubWayHomeComponent()
  }
  
  override func tearDownWithError() throws {
  }
  
  func test_지하철역정보_제이슨파일_읽어서_SubwayStation_배열_리턴() {
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

import SubwayCore
import XCTest

final class RealtimeStationArrivalModelTests: XCTestCase {
  
  
  override func setUpWithError() throws {
  }
  
  override func tearDownWithError() throws {
  }
  
  func test_recptnDate() {
    // GIVEN
    let mockRealtimeStationArrivalModel = try? JSONDecoder().decode(RealtimeStationArrivalModel.self, from: RealtimeStationArrivalModel.mock)
    let firstRecptnDate = mockRealtimeStationArrivalModel?.realtimeArrivalList.first?.recptnDate
    
    // WHEN
    
    // THEN
    XCTAssertNotNil(mockRealtimeStationArrivalModel)
    XCTAssertNotNil(firstRecptnDate)
  }
  
  func test_calculatedBarvlDt() {
    // GIVEN
    let realtimeArrivalList = RealtimeArrivalList(totalCount: 1, rowNum: 1, subwayId: "1", statnNm: "1", trainLineNm: "1", barvlDt: "30", recptnDt: "2022-12-0716:44:10", arvlMsg2: "123", arvlMsg3: "123", arvlCd: "123")
    
    // WHEN
    
    // THEN
    XCTAssert(realtimeArrivalList.calculatedBarvlDt != nil)
  }
  
  func test_calculatedBarvlDt_with_recptnDate_nil() {
    // GIVEN
    let realtimeArrivalList = RealtimeArrivalList(totalCount: 1, rowNum: 1, subwayId: "1", statnNm: "1", trainLineNm: "1", barvlDt: "1", recptnDt: "1", arvlMsg2: "1", arvlMsg3: "1", arvlCd: "1")
    
    // WHEN
    
    // THEN
    XCTAssert(realtimeArrivalList.calculatedBarvlDt == nil)
  }
  
  func test_calculatedBarvlDt_with_barvlDt_convert_Int_fail() {
    // GIVEN
    let realtimeArrivalList = RealtimeArrivalList(totalCount: 1, rowNum: 1, subwayId: "1", statnNm: "1", trainLineNm: "1", barvlDt: "a", recptnDt: "1", arvlMsg2: "1", arvlMsg3: "1", arvlCd: "1")
    
    // WHEN
    
    // THEN
    XCTAssert(realtimeArrivalList.calculatedBarvlDt == nil)
  }
}

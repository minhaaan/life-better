@testable import Networking
import XCTest
import Combine

final class RequestProtocolTests: XCTestCase {
  
  private var request: RequestProtocol!
  
  override func setUp() {
    request = MockRequest.mock
  }
  
  override func tearDown() {
    request = nil
  }
  
  func test_createURLRequest() {
    // GIVEN
    guard let urlRequest = try? request.createURLRequest() else {
      XCTFail()
      return
    }
    
    // WHEN
    
    // THEN
    XCTAssert(urlRequest.allHTTPHeaderFields?.count ?? 0 >= 1)
    XCTAssert(urlRequest.httpMethod == "POST")
    XCTAssert(urlRequest.url?.absoluteString != "https://jsonplaceholder.typicode.com/mock")
    XCTAssert(urlRequest.value(forHTTPHeaderField: "Authorization") != nil)
    XCTAssert(urlRequest.allHTTPHeaderFields?.isEmpty == false)
    var a = urlRequest.allHTTPHeaderFields
    a?.removeValue(forKey: "mock") // Authorization 삭제
    XCTAssertEqual(urlRequest.allHTTPHeaderFields, a)
  }
  
}

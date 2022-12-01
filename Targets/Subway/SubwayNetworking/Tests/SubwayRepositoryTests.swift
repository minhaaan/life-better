//
//  SubwayRepositoryTests.swift
//  SubwayNetworkingTests
//
//  Created by 최민한 on 2022/12/02.
//
@testable import SubwayNetworking
import XCTest
import Networking
import Combine

final class SubwayRepositoryTests: XCTestCase {
  
  private var repository: SubwayRepository!
  private var bag: Set<AnyCancellable>!
  private var exp: XCTestExpectation!
  
  override func setUp() {
    let config = URLSessionConfiguration.default
    config.protocolClasses = [MockURLProtocol.self]
    let mockURLSession = URLSession.init(configuration: config)
    self.repository = SubwayRepository(urlSession: mockURLSession)
    self.bag = .init()
    self.exp = .init()
  }
  
  override func tearDown() {
    repository = nil
    exp = nil
    bag = nil
  }
  
  func test_getRealtimeStationArrival() {
    // GIVEN
    let stationName = "낙성대"
    MockURLProtocol.requestHandler = { request in
      guard let url = request.url, url == request.url?.absoluteURL else {
        throw URLError(.badURL)
      }
      
      let res = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
      return (res, MockData.RealtimeStationArrivalModelMock)
    }
    
    // WHEN
    let result = repository.getRealtimeStationArrival(stationName: stationName)
    
    // THEN
    result
      .sink { completion in
        if case .failure(let err) = completion {
          XCTFail(err.localizedDescription)
        }
      } receiveValue: { [weak self] data in
        XCTAssert(data.errorMessage.status == 200)
        XCTAssertNotNil(data)
        XCTAssert(data.realtimeArrivalList.count == 6)
        XCTAssert(data.errorMessage.message.isEmpty == false)
        XCTAssert(data.realtimeArrivalList.first?.rowNum == 2)
        XCTAssert(data.realtimeArrivalList.first?.statnNm == "선릉")
        XCTAssert(data.realtimeArrivalList.first?.recptnDt.isEmpty == false)
        self?.exp.fulfill()
      }
      .store(in: &bag)

    
    wait(for: [exp], timeout: 2.0)
  }
  
  func test_test_getRealtimeStationArrival_Decode_Error() {
    // GIVEN
    let stationName = "두류"
    MockURLProtocol.requestHandler = { request in
      guard let url = request.url, url == request.url?.absoluteURL else {
        throw URLError(.badURL)
      }
      
      let res = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
      return (res, Data())
    }
    
    // WHEN
    let result = repository.getRealtimeStationArrival(stationName: stationName)
    
    // THEN
    result.sink { [weak self] completion in
      if case .failure(let _) = completion {
        XCTAssert(true)
        self?.exp.fulfill()
      }
    } receiveValue: { _ in
      XCTFail()
    }
    .store(in: &bag)

    
    wait(for: [exp], timeout: 2.0)
  }
  
}

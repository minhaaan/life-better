//
//  SubwayDetailInteractorTests.swift
//  SubwayDetailTests
//
//  Created by 최민한 on 2022/12/05.
//  Copyright © 2022 com.minan. All rights reserved.
//

@testable import SubwayDetail
import XCTest
import SubwayNetworking
import Networking
import Foundation
import Combine
import SubwayCore

final class SubwayDetailInteractorTests: XCTestCase {
  
  private var interactor: SubwayDetailInteractor!
  private var station: SubwayStation = SubwayStation(subwayId: 1002, stationId: 1, stationName: "두류")
  private var subwayDetailPresenter: SubwayDetailPresentableMock!
  private var subwayRepository: SubwayRepository!
  private var bag: Set<AnyCancellable>!
  private var subwayDetailListener: SubwayDetailListenerMock!
  
  override func setUpWithError() throws {
    
    let config = URLSessionConfiguration.default
    config.protocolClasses = [MockURLProtocol.self]
    let mockURLSession = URLSession.init(configuration: config)
    self.subwayRepository = SubwayRepository(urlSession: mockURLSession)
    self.subwayDetailPresenter = SubwayDetailPresentableMock()
    self.subwayDetailListener = SubwayDetailListenerMock()
    self.interactor = SubwayDetailInteractor(
      presenter: subwayDetailPresenter,
      subwayRepository: subwayRepository,
      station: station
    )
    interactor.listener = self.subwayDetailListener
    self.bag = .init()
  }
  
  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func test_getArrivalDataData() {
    // GIVEN
    let exp = XCTestExpectation()
    MockURLProtocol.requestHandler = { request in
      guard let url = request.url, url == request.url?.absoluteURL else {
        throw URLError(.badURL)
      }
      
      let res = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
      return (res, RealtimeStationArrivalModel.mock)
    }
    
    // WHEN
    interactor.getArrivalData()
    
    // THEN
    Thread.sleep(forTimeInterval: 1)
    XCTAssert(subwayDetailPresenter.updateHeadingListCalled)
    XCTAssert(subwayDetailPresenter.updateHeadingListCallsCount == 1)
    XCTAssert(interactor.realtimeArrivalList.isNotEmpty)
    exp.fulfill()
    
    wait(for: [exp], timeout: 2.0)
  }
  
  func test_detachSubwayDetail() {
    // GIVEN
    
    // WHEN
    interactor.detachSubwayDetail()
    
    // THEN
    XCTAssert(subwayDetailListener.detachSubwayDetailCalled)
    XCTAssert(subwayDetailListener.detachSubwayDetailCallsCount == 1)
  }
  
  func test_filterSelectedTrainLineNmWithList() {
    // GIVEN
    let mockTrainLineName = "1"
    let mockRealtimeArrivalList: [RealtimeArrivalList] = [
      .init(totalCount: 1, rowNum: 1, subwayId: "1", statnNm: "1", trainLineNm: "1", barvlDt: "1", recptnDt: "1", arvlMsg2: "1", arvlMsg3: "1", arvlCd: "1"),
      .init(totalCount: 2, rowNum: 2, subwayId: "2", statnNm: "2", trainLineNm: "2", barvlDt: "2", recptnDt: "2", arvlMsg2: "2", arvlMsg3: "2", arvlCd: "2")
    ]
    
    // WHEN
    interactor.realtimeArrivalList = mockRealtimeArrivalList
    interactor.filterSelectedTrainLineNmWithList(with: mockTrainLineName)
    
    // THEN
    XCTAssert(subwayDetailPresenter.updateLabelTextCallsCount == 1)
    XCTAssert(subwayDetailPresenter.updateLabelTextCalled)
    XCTAssert(interactor.realtimeArrivalList.first?.trainLineNm == "1")
  }
  
  
  
}

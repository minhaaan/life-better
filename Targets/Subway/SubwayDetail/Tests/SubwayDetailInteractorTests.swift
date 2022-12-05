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
  private var stationName: String = "두류"
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
      stationName: stationName
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
    subwayDetailPresenter.listener?.getArrivalDataData()
    
    // THEN
    subwayDetailPresenter.arrivalData
      .sink { model in
        print("DEBUG: model is \(model)")
        XCTAssert(true)
        exp.fulfill()
      }
      .store(in: &bag)
      
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
  
  
  
}

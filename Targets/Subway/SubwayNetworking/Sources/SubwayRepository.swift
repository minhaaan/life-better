//
//  SubwayRepository.swift
//  SubwayRepository
//
//  Created by 최민한 on 2022/12/01.
//

import Foundation
import Networking
import Combine
import SubwayCore

public final class SubwayRepository {
 
  private let apiManager: APIManager
  
  public init(urlSession: URLSession = URLSession.shared) {
    self.apiManager = APIManager(urlSession: urlSession)
  }
  
  public func getRealtimeStationArrival(stationName: String) -> AnyPublisher<RealtimeStationArrivalModel, Error> {
    apiManager.perform(SubwayRequest(stationName: stationName), type: RealtimeStationArrivalModel.self)
  }
}

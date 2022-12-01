import Foundation
import Networking

public struct SubwayRequest {
  let stationName: String
}

extension SubwayRequest: RequestProtocol {
  public var host: String {
    "http://swopenAPI.seoul.go.kr/api/subway/(인증키)/json/realtimeStationArrival/0/5" // TODO: 인증키 넣기.
  }
  
  public var path: String {
    return "/\(self.stationName)"
  }
  
  public var requestType: Networking.RequestType {
    .GET
  }
  
  public var header: [String : String] {
    [:]
  }
}

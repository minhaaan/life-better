import UIKit

public struct SubwayStation: Decodable, Equatable {
  public let subwayId: Int
  public let stationId: Int
  public let stationName: String
  
  enum CodingKeys: String, CodingKey {
    case subwayId = "SUBWAY_ID"
    case stationId = "STATN_ID"
    case stationName = "STATN_NM"
  }
  
  public init(subwayId: Int, stationId: Int, stationName: String) {
    self.subwayId = subwayId
    self.stationId = stationId
    self.stationName = stationName
  }
}

extension SubwayStation {
  public var lineImage: UIImage? {
    return UIImage(systemName: "\(lineImageName).circle.fill")
  }
  
  public var lineImageName: Int {
    return subwayId % 100
  }
}

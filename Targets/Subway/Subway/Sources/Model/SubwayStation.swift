import UIKit

struct SubwayStation: Decodable, Equatable {
  let subwayId: Int
  let stationId: Int
  let stationName: String
  
  enum CodingKeys: String, CodingKey {
    case subwayId = "SUBWAY_ID"
    case stationId = "STATN_ID"
    case stationName = "STATN_NM"
  }
}

extension SubwayStation {
  var lineImage: UIImage? {
    return UIImage(systemName: "\(lineImageName).circle.fill")
  }
  
  var lineImageName: Int {
    return subwayId % 100
  }
}

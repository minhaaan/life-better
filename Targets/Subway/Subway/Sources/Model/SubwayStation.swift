import Foundation

struct SubwayStation: Decodable {
  let subwayId: Int
  let stationId: Int
  let stationName: String
  
  enum CodingKeys: String, CodingKey {
    case subwayId = "SUBWAY_ID"
    case stationId = "STATN_ID"
    case stationName = "STATN_NM"
  }
}

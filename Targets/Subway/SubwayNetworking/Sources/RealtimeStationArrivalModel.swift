import Foundation

// MARK: - RealtimeStationArrivalModel
public struct RealtimeStationArrivalModel: Codable {
    let errorMessage: ErrorMessage
    let realtimeArrivalList: [RealtimeArrivalList]
}

// MARK: - ErrorMessage
public struct ErrorMessage: Codable {
    let status: Int
    let code, message, link, developerMessage: String
    let total: Int
}

// MARK: - RealtimeArrivalList
public struct RealtimeArrivalList: Codable {
  let totalCount: Int
  let rowNum: Int
  let subwayId: String
  let statnNm: String
  let recptnDt: String // 열차도착정보를 생성한 시각
  let arvlMsg2: String // 첫번째도착메세지 (전역 진입, 전역 도착 등)
  let arvlMsg3: String // 두번째도착메세지 (종합운동장 도착, 12분 후 (광명사거리) 등)
  let arvlCd: String // 도착코드 (0:진입, 1:도착, 2:출발, 3:전역출발, 4:전역진입, 5:전역도착, 99:운행중)
}



import Foundation

// MARK: - RealtimeStationArrivalModel
public struct RealtimeStationArrivalModel: Codable {
  public let errorMessage: ErrorMessage
  public let realtimeArrivalList: [RealtimeArrivalList]
  
  public init(errorMessage: ErrorMessage, realtimeArrivalList: [RealtimeArrivalList]) {
      self.errorMessage = errorMessage
      self.realtimeArrivalList = realtimeArrivalList
  }
}

// MARK: - ErrorMessage
public struct ErrorMessage: Codable {
  public let status: Int
  public let code, message, link, developerMessage: String
  public let total: Int
  public init(status: Int, code: String, message: String, link: String, developerMessage: String, total: Int) {
      self.status = status
      self.code = code
      self.message = message
      self.link = link
      self.developerMessage = developerMessage
      self.total = total
  }
}

// MARK: - RealtimeArrivalList
public struct RealtimeArrivalList: Codable {
  public let totalCount: Int
  public let rowNum: Int
  public let subwayId: String
  public let statnNm: String
  public let recptnDt: String // 열차도착정보를 생성한 시각
  public let arvlMsg2: String // 첫번째도착메세지 (전역 진입, 전역 도착 등)
  public let arvlMsg3: String // 두번째도착메세지 (종합운동장 도착, 12분 후 (광명사거리) 등)
  public let arvlCd: String // 도착코드 (0:진입, 1:도착, 2:출발, 3:전역출발, 4:전역진입, 5:전역도착, 99:운행중)

  public init(totalCount: Int, rowNum: Int, subwayId: String, statnNm: String, recptnDt: String, arvlMsg2: String, arvlMsg3: String, arvlCd: String) {
      self.totalCount = totalCount
      self.rowNum = rowNum
      self.subwayId = subwayId
      self.statnNm = statnNm
      self.recptnDt = recptnDt
      self.arvlMsg2 = arvlMsg2
      self.arvlMsg3 = arvlMsg3
      self.arvlCd = arvlCd
  }
}



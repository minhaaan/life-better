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
  public let subwayId: String // Line Number 1002, 1004 2호선 4호선
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

// MARK: Mock

extension RealtimeStationArrivalModel {
  public static let mock = Data("{\"errorMessage\":{\"status\":200,\"code\":\"INFO-000\",\"message\":\"정상처리되었습니다.\",\"link\":\"\",\"developerMessage\":\"\",\"total\":7},\"realtimeArrivalList\":[{\"beginRow\":null,\"endRow\":null,\"curPage\":null,\"pageRow\":null,\"totalCount\":7,\"rowNum\":2,\"selectedCount\":6,\"subwayId\":\"1002\",\"subwayNm\":null,\"updnLine\":\"외선\",\"trainLineNm\":\"성수행-삼성방면\",\"subwayHeading\":\"오른쪽\",\"statnFid\":\"1002000221\",\"statnTid\":\"1002000219\",\"statnId\":\"1002000220\",\"statnNm\":\"선릉\",\"trainCo\":null,\"ordkey\":\"01005성수0\",\"subwayList\":\"1002,1075\",\"statnList\":\"1002000220,1075075215\",\"btrainSttus\":null,\"barvlDt\":\"640\",\"btrainNo\":\"8497\",\"bstatnId\":\"88\",\"bstatnNm\":\"성수\",\"recptnDt\":\"2022-12-0123:51:40\",\"arvlMsg2\":\"10분40초후\",\"arvlMsg3\":\"방배\",\"arvlCd\":\"99\"},{\"beginRow\":null,\"endRow\":null,\"curPage\":null,\"pageRow\":null,\"totalCount\":7,\"rowNum\":3,\"selectedCount\":6,\"subwayId\":\"1002\",\"subwayNm\":null,\"updnLine\":\"외선\",\"trainLineNm\":\"성수행-삼성방면\",\"subwayHeading\":\"오른쪽\",\"statnFid\":\"1002000221\",\"statnTid\":\"1002000219\",\"statnId\":\"1002000220\",\"statnNm\":\"선릉\",\"trainCo\":null,\"ordkey\":\"02007성수0\",\"subwayList\":\"1002,1075\",\"statnList\":\"1002000220,1075075215\",\"btrainSttus\":null,\"barvlDt\":\"880\",\"btrainNo\":\"6499\",\"bstatnId\":\"88\",\"bstatnNm\":\"성수\",\"recptnDt\":\"2022-12-0123:51:40\",\"arvlMsg2\":\"14분40초후\",\"arvlMsg3\":\"낙성대\",\"arvlCd\":\"99\"},{\"beginRow\":null,\"endRow\":null,\"curPage\":null,\"pageRow\":null,\"totalCount\":7,\"rowNum\":4,\"selectedCount\":6,\"subwayId\":\"1075\",\"subwayNm\":null,\"updnLine\":\"상행\",\"trainLineNm\":\"왕십리행-선정릉방면(막차)\",\"subwayHeading\":\"오른쪽\",\"statnFid\":\"1075075216\",\"statnTid\":\"1075075214\",\"statnId\":\"1075075215\",\"statnNm\":\"선릉\",\"trainCo\":null,\"ordkey\":\"02008왕십리0\",\"subwayList\":\"1002,1075\",\"statnList\":\"1002000220,1075075215\",\"btrainSttus\":null,\"barvlDt\":\"0\",\"btrainNo\":\"6234\",\"bstatnId\":\"165\",\"bstatnNm\":\"왕십리(막차)\",\"recptnDt\":\"2022-12-0123:51:31\",\"arvlMsg2\":\"[8]번째전역(가천대)\",\"arvlMsg3\":\"가천대\",\"arvlCd\":\"99\"},{\"beginRow\":null,\"endRow\":null,\"curPage\":null,\"pageRow\":null,\"totalCount\":7,\"rowNum\":5,\"selectedCount\":6,\"subwayId\":\"1075\",\"subwayNm\":null,\"updnLine\":\"하행\",\"trainLineNm\":\"죽전행-한티방면(막차)\",\"subwayHeading\":\"왼쪽\",\"statnFid\":\"1075075214\",\"statnTid\":\"1075075216\",\"statnId\":\"1075075215\",\"statnNm\":\"선릉\",\"trainCo\":null,\"ordkey\":\"11000죽전0\",\"subwayList\":\"1002,1075\",\"statnList\":\"1002000220,1075075215\",\"btrainSttus\":null,\"barvlDt\":\"0\",\"btrainNo\":\"6251\",\"bstatnId\":\"128\",\"bstatnNm\":\"죽전(막차)\",\"recptnDt\":\"2022-12-0123:46:31\",\"arvlMsg2\":\"선릉진입\",\"arvlMsg3\":\"선릉\",\"arvlCd\":\"0\"},{\"beginRow\":null,\"endRow\":null,\"curPage\":null,\"pageRow\":null,\"totalCount\":7,\"rowNum\":6,\"selectedCount\":6,\"subwayId\":\"1002\",\"subwayNm\":null,\"updnLine\":\"내선\",\"trainLineNm\":\"신도림행-역삼방면\",\"subwayHeading\":\"왼쪽\",\"statnFid\":\"1002000219\",\"statnTid\":\"1002000221\",\"statnId\":\"1002000220\",\"statnNm\":\"선릉\",\"trainCo\":null,\"ordkey\":\"11003신도림0\",\"subwayList\":\"1002,1075\",\"statnList\":\"1002000220,1075075215\",\"btrainSttus\":null,\"barvlDt\":\"256\",\"btrainNo\":\"4510\",\"bstatnId\":\"24\",\"bstatnNm\":\"신도림\",\"recptnDt\":\"2022-12-0123:51:40\",\"arvlMsg2\":\"4분16초후\",\"arvlMsg3\":\"종합운동장\",\"arvlCd\":\"99\"},{\"beginRow\":null,\"endRow\":null,\"curPage\":null,\"pageRow\":null,\"totalCount\":7,\"rowNum\":7,\"selectedCount\":6,\"subwayId\":\"1002\",\"subwayNm\":null,\"updnLine\":\"내선\",\"trainLineNm\":\"을지로입구행-역삼방면(막차)\",\"subwayHeading\":\"왼쪽\",\"statnFid\":\"1002000219\",\"statnTid\":\"1002000221\",\"statnId\":\"1002000220\",\"statnNm\":\"선릉\",\"trainCo\":null,\"ordkey\":\"12008을지로입구0\",\"subwayList\":\"1002,1075\",\"statnList\":\"1002000220,1075075215\",\"btrainSttus\":null,\"barvlDt\":\"821\",\"btrainNo\":\"8512\",\"bstatnId\":\"24\",\"bstatnNm\":\"을지로입구(막차)\",\"recptnDt\":\"2022-12-0123:51:40\",\"arvlMsg2\":\"13분41초후\",\"arvlMsg3\":\"구의\",\"arvlCd\":\"99\"}]}".utf8)
}



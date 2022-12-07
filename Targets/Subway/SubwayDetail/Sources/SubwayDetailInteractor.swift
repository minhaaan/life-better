import ModernRIBs
import SubwayNetworking
import SubwayCore
import Combine
import Utils

public protocol SubwayDetailRouting: ViewableRouting {
  // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol SubwayDetailPresentable: Presentable {
  var listener: SubwayDetailPresentableListener? { get set }
  func updateHeadingList(with: Set<String>)
  func updateLabelText(with text: String)
}

public protocol SubwayDetailListener: AnyObject {
  // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
  func detachSubwayDetail()
}

final class SubwayDetailInteractor: PresentableInteractor<SubwayDetailPresentable>, SubwayDetailInteractable, SubwayDetailPresentableListener {
  
  weak var router: SubwayDetailRouting?
  weak var listener: SubwayDetailListener?
  
  private let station: SubwayStation
  private let subwayRepository: SubwayRepository
  
  var realtimeArrivalList: [RealtimeArrivalList] = []
  
  private var bag = Set<AnyCancellable>()
  
  // TODO: Add additional dependencies to constructor. Do not perform any logic
  // in constructor.
  init(
    presenter: SubwayDetailPresentable,
    subwayRepository: SubwayRepository,
    station: SubwayStation
  ) {
    self.subwayRepository = subwayRepository
    self.station = station
    super.init(presenter: presenter)
    presenter.listener = self
  }
  
  override func didBecomeActive() {
    super.didBecomeActive()
    // TODO: Implement business logic here.
  }
  
  override func willResignActive() {
    super.willResignActive()
    // TODO: Pause any business logic.
  }
  
  // MARK: SubwayDetailPresentable
  
  func detachSubwayDetail() {
    listener?.detachSubwayDetail()
  }
  
  func getArrivalData() {
    subwayRepository
      .getRealtimeStationArrival(stationName: station.stationName)
      .map { [weak self] data in
        var result = data
        result.realtimeArrivalList = data.realtimeArrivalList.filter { $0.subwayId == String(self?.station.subwayId ?? 0) }
        return result
      }
      .sink { completion in
        if case .failure(let error) = completion {
          log.error("getRealtimeStationArrival error \(error)")
        }
      } receiveValue: { [weak self] value in
        log.debug("received realTimeStationArrival data \(value)")
        let headingListValue = value.realtimeArrivalList
          .map { $0.trainLineNm }
          .compactMap { trainLineNm in return trainLineNm.components(separatedBy: "-")[safe: 1]?.trimmingCharacters(in: .whitespaces) }
        self?.presenter.updateHeadingList(with: Set(headingListValue))
        self?.realtimeArrivalList = value.realtimeArrivalList
      }
      .store(in: &bag)
  }
  
  func filterSelectedTrainLineNmWithList(with trainLineName: String) {
    defer { presenter.updateLabelText(with: realtimeArrivalList.map { $0.arvlMsg2 }.joined(separator: ", ")) }
    realtimeArrivalList = realtimeArrivalList.filter { realTimeArrivalData in
      realTimeArrivalData.trainLineNm.contains(trainLineName)
    }
  }
}

import ModernRIBs
import SubwayNetworking
import SubwayCore
import Combine
import Utils
import Foundation
import SubwayWidgetCore

public protocol SubwayDetailRouting: ViewableRouting {
  // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol SubwayDetailPresentable: Presentable {
  var listener: SubwayDetailPresentableListener? { get set }
  var labelText: PassthroughSubject<String, Never> { get }
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
  
  var calculatedRealtimeArrivalList: [Int] {
    self.realtimeArrivalList
      .compactMap{ $0.getCalculatedBarvlDt(date: Date()) }
      .filter { $0 > 0 }
      .map { $0 }
  }
  
  private var bag = Set<AnyCancellable>()
  var updateTextCancellabel: AnyCancellable?
  
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
    updateTextCancellabel?.cancel()
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
    defer {
      startLabelTextTimer()
      SubwayLiveActivityManager.shared.removeAllActivities()
      SubwayLiveActivityManager.shared.addSubwayLiveActivity(
        stationName: station.stationName,
        state: SubwayWidgetAttributes.ContentState(arrivalData: calculatedRealtimeArrivalList)
      )
    }
    realtimeArrivalList = realtimeArrivalList.filter { realTimeArrivalData in
      realTimeArrivalData.trainLineNm.contains(trainLineName)
    }
  }
  
  // MARK: Private Method
  
  private func startLabelTextTimer() {
    updateTextCancellabel?.cancel()
    updateTextCancellabel = Timer.publish(every: 1.0, on: .main, in: .common)
      .autoconnect()
      .compactMap { [weak self] _ -> String? in
        self?.calculatedRealtimeArrivalList.map { $0 }
          .map { String($0) }
          .joined(separator: " ,")
      }
      .map { text in
        text.isEmpty ? "도착정보가 없습니다" : text
      }
      .sink { [weak self] text in
        log.debug("text is \(text)")
        self?.presenter.labelText.send("\(text)")
      }
  }
}

import ModernRIBs
import SubwayNetworking
import SubwayCore
import Combine

public protocol SubwayDetailRouting: ViewableRouting {
  // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol SubwayDetailPresentable: Presentable {
  var listener: SubwayDetailPresentableListener? { get set }
  var data: PassthroughSubject<RealtimeStationArrivalModel, Never> { get }
}

public protocol SubwayDetailListener: AnyObject {
  // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
  func detachSubwayDetail()
}

final class SubwayDetailInteractor: PresentableInteractor<SubwayDetailPresentable>, SubwayDetailInteractable, SubwayDetailPresentableListener {
  
  weak var router: SubwayDetailRouting?
  weak var listener: SubwayDetailListener?
  
  private let subwayRepository: SubwayRepository
  
  private var bag = Set<AnyCancellable>()
  
  // TODO: Add additional dependencies to constructor. Do not perform any logic
  // in constructor.
  init(
    presenter: SubwayDetailPresentable,
    subwayRepository: SubwayRepository
  ) {
    self.subwayRepository = subwayRepository
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
  
  func detachSubwayDetail() {
    listener?.detachSubwayDetail()
  }
  
  func getData() {
    subwayRepository
      .getRealtimeStationArrival(stationName: "")
      .sink { completion in
        if case .failure(let error) = completion {
          print("DEBUG: 에러났다.")
        }
      } receiveValue: { [weak self] data in
        self?.presenter.data.send(data)
      }
      .store(in: &bag)
  }
}

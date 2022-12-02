//
//  SubwayListInteractor.swift
//  Subway
//
//  Created by 최민한 on 2022/11/28.
//  Copyright © 2022 com.minan. All rights reserved.
//

import ModernRIBs
import Utils

protocol SubwayListRouting: ViewableRouting {
  // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
  func attachSubwayDetail(stationName: String)
}

protocol SubwayListPresentable: Presentable {
  var listener: SubwayListPresentableListener? { get set }
  // TODO: Declare methods the interactor can invoke the presenter to present data.
  func updateSubwayStations(with subwayStations: [SubwayStation])
}

public protocol SubwayListListener: AnyObject {
  // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class SubwayListInteractor: PresentableInteractor<SubwayListPresentable>, SubwayListInteractable, SubwayListPresentableListener {
  
  weak var router: SubwayListRouting?
  weak var listener: SubwayListListener?
  
  private let subwayStation: [SubwayStation]
  
  // TODO: Add additional dependencies to constructor. Do not perform any logic
  // in constructor.
  init(presenter: SubwayListPresentable, subwayStation: [SubwayStation]) {
    self.subwayStation = subwayStation
    super.init(presenter: presenter)
    presenter.listener = self
  }
  
  override func didBecomeActive() {
    super.didBecomeActive()
    presenter.updateSubwayStations(with: subwayStation) // didBecomeActive 때 SubwayList subwayStations 값 넣어주기.
  }
  
  override func willResignActive() {
    super.willResignActive()
    // TODO: Pause any business logic.
  }
  
  func updateSearchKeyword(keyword: String) {
    // keyword가 비어있다면 전체 목록 리턴
    guard keyword.isNotEmpty else {
      return presenter.updateSubwayStations(with: subwayStation)
    }
    let searchResult = subwayStation.filter { $0.stationName.contains(keyword) }
    presenter.updateSubwayStations(with: searchResult)
  }
  
  func didTapSubwayStation(stationName: String) {
    router?.attachSubwayDetail(stationName: stationName)
  }
}


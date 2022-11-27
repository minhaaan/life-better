//
//  SubWayHomeInteractor.swift
//  Subway
//
//  Created by 최민한 on 2022/11/23.
//  Copyright © 2022 com.minan. All rights reserved.
//

import ModernRIBs

public protocol SubWayHomeRouting: ViewableRouting {
  // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

public protocol SubWayHomePresentable: Presentable {
  var listener: SubWayHomePresentableListener? { get set }
  // TODO: Declare methods the interactor can invoke the presenter to present data.
}

public protocol SubWayHomeListener: AnyObject {
  // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
  func detachSubwayHome()
}

final class SubWayHomeInteractor: PresentableInteractor<SubWayHomePresentable>, SubWayHomeInteractable, SubWayHomePresentableListener {

  weak var router: SubWayHomeRouting?
  weak var listener: SubWayHomeListener?
  
  // TODO: Add additional dependencies to constructor. Do not perform any logic
  // in constructor.
  override init(presenter: SubWayHomePresentable) {
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
  
  func detachSubwayHome() {
    listener?.detachSubwayHome()
  }
}

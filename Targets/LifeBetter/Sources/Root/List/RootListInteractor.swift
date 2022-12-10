//
//  RootListInteractor.swift
//  LifeBetter
//
//  Created by 최민한 on 2022/12/10.
//  Copyright © 2022 com.minan. All rights reserved.
//

import ModernRIBs

protocol RootListRouting: ViewableRouting {
  func presentSubwayHome()
  func detachSubwayHome()
}

protocol RootListPresentable: Presentable {
  var listener: RootListPresentableListener? { get set }
  // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol RootListListener: AnyObject {
  // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class RootListInteractor: PresentableInteractor<RootListPresentable>, RootListInteractable, RootListPresentableListener {
  
  weak var router: RootListRouting?
  weak var listener: RootListListener?
  
  // TODO: Add additional dependencies to constructor. Do not perform any logic
  // in constructor.
  override init(presenter: RootListPresentable) {
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
  
  func attachSubway() {
    router?.presentSubwayHome()
  }
  
  func detachSubwayHome() {
    router?.detachSubwayHome()
  }
}

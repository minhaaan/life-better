//
//  RootRouter.swift
//  LifeBetter
//
//  Created by 최민한 on 2022/11/20.
//  Copyright © 2022 com.minan. All rights reserved.
//

import ModernRIBs
import Subway

protocol RootInteractable: Interactable, SubWayHomeListener {
  var router: RootRouting? { get set }
  var listener: RootListener? { get set }
}

protocol RootViewControllable: ViewControllable {
  // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>, RootRouting {
  
  // TODO: Constructor inject child builder protocols to allow building children.
  init(interactor: RootInteractable,
       viewController: RootViewControllable,
       subwayHomeBuilder: SubWayHomeBuildable) {
    self.subwayHomeBuilder = subwayHomeBuilder
    super.init(interactor: interactor, viewController: viewController)
    interactor.router = self
  }
  
  // MARK: Private
  
  private let subwayHomeBuilder: SubWayHomeBuildable
  
  private var subwayHome: ViewableRouting?
  
  func routeToSubwayHome() {
    let subwayHome = subwayHomeBuilder.build(withListener: interactor)
    self.subwayHome = subwayHome
    attachChild(subwayHome)
    viewControllable.uiviewController.present(subwayHome.viewControllable.uiviewController, animated: true)
  }
}

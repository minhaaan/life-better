//
//  RootRouter.swift
//  LifeBetter
//
//  Created by 최민한 on 2022/11/20.
//  Copyright © 2022 com.minan. All rights reserved.
//

import ModernRIBs
import Subway
import UIKit

protocol RootInteractable: Interactable, SubWayHomeListener, RootListListener {
  var router: RootRouting? { get set }
  var listener: RootListener? { get set }
}

protocol RootViewControllable: ViewControllable {
  func addChildRootListViewController(viewController: ViewControllable)
}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>, RootRouting {
  
  // TODO: Constructor inject child builder protocols to allow building children.
  init(interactor: RootInteractable,
       viewController: RootViewControllable,
       subwayHomeBuilder: SubWayHomeBuildable,
       rootListBuilder: RootListBuildable) {
    self.subwayHomeBuilder = subwayHomeBuilder
    self.rootListBuilder = rootListBuilder
    super.init(interactor: interactor, viewController: viewController)
    interactor.router = self
  }
  
  override func didLoad() {
    super.didLoad()    
    attachRootList()
  }
  
  // MARK: Private
  
  private let subwayHomeBuilder: SubWayHomeBuildable
  private var subwayHome: SubWayHomeRouting?
  
  private let rootListBuilder: RootListBuildable
  private var rootList: RootListRouting?
  
  func routeToSubwayHome() {
    let subwayHome = subwayHomeBuilder.build(withListener: interactor)
    self.subwayHome = subwayHome
    attachChild(subwayHome)
    viewControllable.pushViewController(subwayHome.viewControllable, animated: true)
  }
  
  func detachSubwayHome() {
    if let subwayHome {
      detachChild(subwayHome)
      subwayHome.viewControllable.popViewController(animated: true)
      self.subwayHome = nil
    }
  }
  
  func attachRootList() {
    let rootList = rootListBuilder.build(withListener: interactor)
    self.rootList = rootList
    attachChild(rootList)
    viewController.addChildRootListViewController(viewController: rootList.viewControllable)
  }
}

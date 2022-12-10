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

protocol RootInteractable: Interactable, RootListListener {
  var router: RootRouting? { get set }
  var listener: RootListener? { get set }
}

protocol RootViewControllable: ViewControllable {
  func presentRootListViewController(viewController: ViewControllable)
}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>, RootRouting {
  
  // TODO: Constructor inject child builder protocols to allow building children.
  init(interactor: RootInteractable,
       viewController: RootViewControllable,
       rootListBuilder: RootListBuildable) {
    self.rootListBuilder = rootListBuilder
    super.init(interactor: interactor, viewController: viewController)
    interactor.router = self
  }
  
  override func didLoad() {
    super.didLoad()    
    attachRootList()
  }
  
  // MARK: Private
  
  private let rootListBuilder: RootListBuildable
  private var rootList: RootListRouting?
  
  func attachRootList() {
    let rootList = rootListBuilder.build(withListener: interactor)
    self.rootList = rootList
    attachChild(rootList)
    let navViewController = UINavigationController(root: rootList.viewControllable)
    viewController.presentRootListViewController(viewController: navViewController)
  }
}

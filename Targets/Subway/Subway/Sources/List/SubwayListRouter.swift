//
//  SubwayListRouter.swift
//  Subway
//
//  Created by 최민한 on 2022/11/28.
//  Copyright © 2022 com.minan. All rights reserved.
//

import ModernRIBs

protocol SubwayListInteractable: Interactable, SubwayListListener {
  var router: SubwayListRouting? { get set }
  var listener: SubwayListListener? { get set }
}

protocol SubwayListViewControllable: ViewControllable {
  // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class SubwayListRouter: ViewableRouter<SubwayListInteractable, SubwayListViewControllable>, SubwayListRouting {
  
  // TODO: Constructor inject child builder protocols to allow building children.
  override init(interactor: SubwayListInteractable, viewController: SubwayListViewControllable) {
    super.init(interactor: interactor, viewController: viewController)
    interactor.router = self
  }
}

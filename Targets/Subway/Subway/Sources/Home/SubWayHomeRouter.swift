//
//  SubWayHomeRouter.swift
//  Subway
//
//  Created by 최민한 on 2022/11/23.
//  Copyright © 2022 com.minan. All rights reserved.
//

import ModernRIBs

public protocol SubWayHomeInteractable: Interactable {
  var router: SubWayHomeRouting? { get set }
  var listener: SubWayHomeListener? { get set }
}

public protocol SubWayHomeViewControllable: ViewControllable {
  // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class SubWayHomeRouter: ViewableRouter<SubWayHomeInteractable, SubWayHomeViewControllable>, SubWayHomeRouting {
  
  // TODO: Constructor inject child builder protocols to allow building children.
  init(
    interactor: SubWayHomeInteractable,
    viewController: SubWayHomeViewControllable,
    subwayListBuilder: SubwayListBuildable
  ) {
    self.subwayListBuilder = subwayListBuilder
    super.init(interactor: interactor, viewController: viewController)
    interactor.router = self
  }
  
  // MARK: Private
  
  private let subwayListBuilder: SubwayListBuildable
  private var subwayList: SubwayListRouting?
  
}

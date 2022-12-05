//
//  SubwayListRouter.swift
//  Subway
//
//  Created by 최민한 on 2022/11/28.
//  Copyright © 2022 com.minan. All rights reserved.
//

import ModernRIBs
import SubwayDetail
import SubwayCore

protocol SubwayListInteractable: Interactable, SubwayDetailListener {
  var router: SubwayListRouting? { get set }
  var listener: SubwayListListener? { get set }
}

protocol SubwayListViewControllable: ViewControllable {
  // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class SubwayListRouter: ViewableRouter<SubwayListInteractable, SubwayListViewControllable>, SubwayListRouting {
  
  // TODO: Constructor inject child builder protocols to allow building children.
  init(
    interactor: SubwayListInteractable,
    viewController: SubwayListViewControllable,
    subwayDetailBuilder: SubwayDetailBuildable
  ) {
    self.subwayDetailBuilder = subwayDetailBuilder
    super.init(interactor: interactor, viewController: viewController)
    interactor.router = self
  }
  
  private let subwayDetailBuilder: SubwayDetailBuildable
  private var subwayDetail: SubwayDetailRouting?
  
  func attachSubwayDetail(station: SubwayStation) {
    let subwayDetail = subwayDetailBuilder.build(withListener: interactor, station: station)
    self.subwayDetail = subwayDetail
    attachChild(subwayDetail)
    viewController.pushViewController(subwayDetail.viewControllable, animated: true)
  }
  
  func detachSubwayDetail() {
    if let subwayDetail {
      detachChild(subwayDetail)
    }
  }
  
}

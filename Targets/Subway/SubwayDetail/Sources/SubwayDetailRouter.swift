//
//  SubwayDetailRouter.swift
//  SubwayDetail
//
//  Created by 최민한 on 2022/12/02.
//  Copyright © 2022 com.minan. All rights reserved.
//

import ModernRIBs

protocol SubwayDetailInteractable: Interactable {
    var router: SubwayDetailRouting? { get set }
    var listener: SubwayDetailListener? { get set }
}

protocol SubwayDetailViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class SubwayDetailRouter: ViewableRouter<SubwayDetailInteractable, SubwayDetailViewControllable>, SubwayDetailRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: SubwayDetailInteractable, viewController: SubwayDetailViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}

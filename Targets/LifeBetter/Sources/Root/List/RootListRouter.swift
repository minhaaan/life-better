//
//  RootListRouter.swift
//  LifeBetter
//
//  Created by 최민한 on 2022/12/10.
//  Copyright © 2022 com.minan. All rights reserved.
//

import ModernRIBs

protocol RootListInteractable: Interactable {
    var router: RootListRouting? { get set }
    var listener: RootListListener? { get set }
}

protocol RootListViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class RootListRouter: ViewableRouter<RootListInteractable, RootListViewControllable>, RootListRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: RootListInteractable, viewController: RootListViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}

//
//  SubWayHomeBuilder.swift
//  Subway
//
//  Created by 최민한 on 2022/11/23.
//  Copyright © 2022 com.minan. All rights reserved.
//

import ModernRIBs

protocol SubWayHomeDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class SubWayHomeComponent: Component<SubWayHomeDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol SubWayHomeBuildable: Buildable {
    func build(withListener listener: SubWayHomeListener) -> SubWayHomeRouting
}

final class SubWayHomeBuilder: Builder<SubWayHomeDependency>, SubWayHomeBuildable {

    override init(dependency: SubWayHomeDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: SubWayHomeListener) -> SubWayHomeRouting {
        let component = SubWayHomeComponent(dependency: dependency)
        let viewController = SubWayHomeViewController()
        let interactor = SubWayHomeInteractor(presenter: viewController)
        interactor.listener = listener
        return SubWayHomeRouter(interactor: interactor, viewController: viewController)
    }
}

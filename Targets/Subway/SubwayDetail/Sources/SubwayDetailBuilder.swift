//
//  SubwayDetailBuilder.swift
//  SubwayDetail
//
//  Created by 최민한 on 2022/12/02.
//  Copyright © 2022 com.minan. All rights reserved.
//

import ModernRIBs

protocol SubwayDetailDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class SubwayDetailComponent: Component<SubwayDetailDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol SubwayDetailBuildable: Buildable {
    func build(withListener listener: SubwayDetailListener) -> SubwayDetailRouting
}

final class SubwayDetailBuilder: Builder<SubwayDetailDependency>, SubwayDetailBuildable {

    override init(dependency: SubwayDetailDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: SubwayDetailListener) -> SubwayDetailRouting {
        let component = SubwayDetailComponent(dependency: dependency)
        let viewController = SubwayDetailViewController()
        let interactor = SubwayDetailInteractor(presenter: viewController)
        interactor.listener = listener
        return SubwayDetailRouter(interactor: interactor, viewController: viewController)
    }
}

//
//  SubWayHomeBuilder.swift
//  Subway
//
//  Created by 최민한 on 2022/11/23.
//  Copyright © 2022 com.minan. All rights reserved.
//

import ModernRIBs

public protocol SubWayHomeDependency: Dependency {
  // TODO: Declare the set of dependencies required by this RIB, but cannot be
  // created by this RIB.
}

public final class SubWayHomeComponent: Component<SubWayHomeDependency> {
  
  // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
  public override init(dependency: SubWayHomeDependency) {
    super.init(dependency: dependency)
  }
}

// MARK: - Builder

public protocol SubWayHomeBuildable: Buildable {
  func build(withListener listener: SubWayHomeListener) -> SubWayHomeRouting
}

public final class SubWayHomeBuilder: Builder<SubWayHomeDependency>, SubWayHomeBuildable {
  
  public override init(dependency: SubWayHomeDependency) {
    super.init(dependency: dependency)
  }
  
  public func build(withListener listener: SubWayHomeListener) -> SubWayHomeRouting {
    let component = SubWayHomeComponent(dependency: dependency)
    let viewController = SubWayHomeViewController()
    let interactor = SubWayHomeInteractor(presenter: viewController)
    interactor.listener = listener
    return SubWayHomeRouter(interactor: interactor, viewController: viewController)
  }
}

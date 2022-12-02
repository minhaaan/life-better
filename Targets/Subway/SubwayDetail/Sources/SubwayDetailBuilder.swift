//
//  SubwayDetailBuilder.swift
//  SubwayDetail
//
//  Created by 최민한 on 2022/12/02.
//  Copyright © 2022 com.minan. All rights reserved.
//

import ModernRIBs

public protocol SubwayDetailDependency: Dependency {
  // TODO: Declare the set of dependencies required by this RIB, but cannot be
  // created by this RIB.
  var stationName: String { get }
}

final class SubwayDetailComponent: Component<SubwayDetailDependency> {
  
  // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
  var stationName: String {
    dependency.stationName
  }
}

// MARK: - Builder

public protocol SubwayDetailBuildable: Buildable {
  func build(withListener listener: SubwayDetailListener) -> SubwayDetailRouting
}

public final class SubwayDetailBuilder: Builder<SubwayDetailDependency>, SubwayDetailBuildable {
  
  public override init(dependency: SubwayDetailDependency) {
    super.init(dependency: dependency)
  }
  
  public func build(withListener listener: SubwayDetailListener) -> SubwayDetailRouting {
    let component = SubwayDetailComponent(dependency: dependency)
    let viewController = SubwayDetailViewController()
    let interactor = SubwayDetailInteractor(presenter: viewController)
    interactor.listener = listener
    return SubwayDetailRouter(interactor: interactor, viewController: viewController)
  }
}


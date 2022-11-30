//
//  SubwayListBuilder.swift
//  Subway
//
//  Created by 최민한 on 2022/11/28.
//  Copyright © 2022 com.minan. All rights reserved.
//

import ModernRIBs

protocol SubwayListDependency: Dependency {
  var subwayStations: [SubwayStation] { get }
}

final class SubwayListComponent: Component<SubwayListDependency> {
  var subwayStations: [SubwayStation] {
    dependency.subwayStations
  }
}

// MARK: - Builder

protocol SubwayListBuildable: Buildable {
  func build(withListener listener: SubwayListListener) -> SubwayListRouting
}

final class SubwayListBuilder: Builder<SubwayListDependency>, SubwayListBuildable {
  
  override init(dependency: SubwayListDependency) {
    super.init(dependency: dependency)
  }
  
  func build(withListener listener: SubwayListListener) -> SubwayListRouting {
    let component = SubwayListComponent(dependency: dependency)
    let viewController = SubwayListViewController(subwayStations: component.subwayStations)
    let interactor = SubwayListInteractor(presenter: viewController, subwayStation: component.subwayStations)
    interactor.listener = listener
    return SubwayListRouter(interactor: interactor, viewController: viewController)
  }
}

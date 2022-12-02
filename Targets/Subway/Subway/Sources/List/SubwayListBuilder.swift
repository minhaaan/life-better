//
//  SubwayListBuilder.swift
//  Subway
//
//  Created by 최민한 on 2022/11/28.
//  Copyright © 2022 com.minan. All rights reserved.
//

import ModernRIBs
import SubwayDetail

protocol SubwayListDependency: Dependency {
  var subwayStations: [SubwayStation] { get }
}

final class SubwayListComponent: Component<SubwayListDependency>, SubwayDetailDependency {
  var stationName: String = ""
  
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
    let viewController = SubwayListViewController()
    let interactor = SubwayListInteractor(presenter: viewController, subwayStation: component.subwayStations)
    interactor.listener = listener
    
    let subwayDetailBuilder = SubwayDetailBuilder(dependency: component)
    
    return SubwayListRouter(
      interactor: interactor,
      viewController: viewController,
      subwayDetailBuilder: subwayDetailBuilder
    )
  }
}

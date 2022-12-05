//
//  SubwayDetailBuilder.swift
//  SubwayDetail
//
//  Created by 최민한 on 2022/12/02.
//  Copyright © 2022 com.minan. All rights reserved.
//

import ModernRIBs
import SubwayNetworking
import SubwayCore

public protocol SubwayDetailDependency: Dependency {
}

final class SubwayDetailComponent: Component<SubwayDetailDependency> {
  
  let subwayRepository: SubwayRepository
  
  init(
    dependency: SubwayDetailDependency,
    subwayRepository: SubwayRepository
  ) {
    self.subwayRepository = subwayRepository
    super.init(dependency: dependency)
  }
  
}

// MARK: - Builder

public protocol SubwayDetailBuildable: Buildable {
  func build(withListener listener: SubwayDetailListener, station: SubwayStation) -> SubwayDetailRouting
}

public final class SubwayDetailBuilder: Builder<SubwayDetailDependency>, SubwayDetailBuildable {
  
  private let subwayRepository: SubwayRepository
  
  public init(
    dependency: SubwayDetailDependency,
    subwayRepository: SubwayRepository
  ) {
    self.subwayRepository = subwayRepository
    super.init(dependency: dependency)
  }
  
  public func build(withListener listener: SubwayDetailListener, station: SubwayStation) -> SubwayDetailRouting {
    let component = SubwayDetailComponent(
      dependency: dependency,
      subwayRepository: subwayRepository
    )
    let viewController = SubwayDetailViewController(stationName: station.stationName)
    let interactor = SubwayDetailInteractor(
      presenter: viewController,
      subwayRepository: component.subwayRepository,
      stationName: station.stationName
    )
    interactor.listener = listener
    return SubwayDetailRouter(interactor: interactor, viewController: viewController)
  }
}


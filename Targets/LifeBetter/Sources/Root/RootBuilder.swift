//
//  RootBuilder.swift
//  LifeBetter
//
//  Created by 최민한 on 2022/11/20.
//  Copyright © 2022 com.minan. All rights reserved.
//

import ModernRIBs
import Subway
import UIKit
import Utils

protocol RootDependency: Dependency {
  // TODO: Declare the set of dependencies required by this RIB, but cannot be
  // created by this RIB.
}

final class RootComponent: Component<RootDependency>, RootListDependency {
  
  let content: [Content] = [
    Content(imageName: "tram.fill", name: "SUBWAY"),
    Content(imageName: "wand.and.stars", name: "TBD..")
  ]
  
  override init(
    dependency: RootDependency
  ) {
    super.init(dependency: dependency)
  }
  
}

// MARK: - Builder

protocol RootBuildable: Buildable {
  func build() -> LaunchRouting
}

final class RootBuilder: Builder<RootDependency>, RootBuildable {
  
  override init(dependency: RootDependency) {
    super.init(dependency: dependency)
  }
  
  func build() -> LaunchRouting {
    let component = RootComponent(dependency: AppComponent())
    let viewController = RootViewController()
    
    let interactor = RootInteractor(presenter: viewController)
    
    let rootListBuilder = RootListBuilder(dependency: component)
    
    return RootRouter(interactor: interactor,
                      viewController: viewController,
                      rootListBuilder: rootListBuilder)
  }
}

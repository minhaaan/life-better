import ModernRIBs
import Foundation

public protocol SubWayHomeDependency: Dependency {
  // TODO: Declare the set of dependencies required by this RIB, but cannot be
  // created by this RIB.
}

public final class SubWayHomeComponent: Component<EmptyComponent> {
  
  var subwayStationList: [SubwayStation] {
    return loadSubwayStationList()
  }
  
  init() {
    super.init(dependency: EmptyComponent())
  }
  
  fileprivate func loadSubwayStationList() -> [SubwayStation] {
    let stationListJsonUrl = SubwayResources.bundle.url(
      forResource: "subway-station-list",
      withExtension: "json"
    )!
    guard
      let data = try? Data(contentsOf: stationListJsonUrl),
      let stationLists = try? JSONDecoder().decode([SubwayStation].self, from: data)
    else {
      return []
    }
    return stationLists
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
    let component = SubWayHomeComponent()
    let viewController = SubWayHomeViewController(subwayStationList: component.subwayStationList)
    let interactor = SubWayHomeInteractor(presenter: viewController)
    interactor.listener = listener
    return SubWayHomeRouter(interactor: interactor, viewController: viewController)
  }
}

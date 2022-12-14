import ModernRIBs
import Foundation
import SubwayCore

public protocol SubWayHomeDependency: Dependency {
  // TODO: Declare the set of dependencies required by this RIB, but cannot be
  // created by this RIB.
}

public final class SubWayHomeComponent: Component<EmptyComponent>, SubwayListDependency {
  
  var subwayStations: [SubwayStation] {
    loadSubwayStationList(
      fileName: "subway-station-list",
      withExtension: "json"
    )
  }
  
  init() {
    super.init(dependency: EmptyComponent())
  }
  
  func loadSubwayStationList(
    fileName: String,
    withExtension: String
  ) -> [SubwayStation] {
    guard
      let stationListJsonUrl = SubwayResources.bundle.url(
        forResource: fileName,
        withExtension: withExtension
      ),
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
    let viewController = SubWayHomeViewController()
    let interactor = SubWayHomeInteractor(presenter: viewController)
    interactor.listener = listener
    
    let subwayListBuilder = SubwayListBuilder(dependency: component)
    
    return SubWayHomeRouter(interactor: interactor, viewController: viewController, subwayListBuilder: subwayListBuilder)
  }
}

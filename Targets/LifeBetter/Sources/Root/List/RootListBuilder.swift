import ModernRIBs
import Subway

protocol RootListDependency: Dependency {
  // TODO: Declare the set of dependencies required by this RIB, but cannot be
  // created by this RIB.
  var content: [Content] { get }
}

final class RootListComponent: Component<RootListDependency>, SubWayHomeDependency {
  fileprivate var contents: [Content] {
    dependency.content
  }
}

// MARK: - Builder

protocol RootListBuildable: Buildable {
  func build(withListener listener: RootListListener) -> RootListRouting
}

final class RootListBuilder: Builder<RootListDependency>, RootListBuildable {
  
  override init(dependency: RootListDependency) {
    super.init(dependency: dependency)
  }
  
  func build(withListener listener: RootListListener) -> RootListRouting {
    let component = RootListComponent(dependency: dependency)
    let viewController = RootListViewController(contents: component.contents)
    let interactor = RootListInteractor(presenter: viewController)
    interactor.listener = listener
    
    let subwayHomeBuilder = SubWayHomeBuilder(dependency: component)
    
    return RootListRouter(interactor: interactor,
                          viewController: viewController,
                          subwayHomeBuilder: subwayHomeBuilder)
  }
}

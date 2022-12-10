import ModernRIBs
import Subway

protocol RootListInteractable: Interactable, SubWayHomeListener {
  var router: RootListRouting? { get set }
  var listener: RootListListener? { get set }
}

protocol RootListViewControllable: ViewControllable {
  // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class RootListRouter: ViewableRouter<RootListInteractable, RootListViewControllable>, RootListRouting {
  
  // TODO: Constructor inject child builder protocols to allow building children.
  init(interactor: RootListInteractable,
       viewController: RootListViewControllable,
       subwayHomeBuilder: SubWayHomeBuildable) {
    self.subwayHomeBuilder = subwayHomeBuilder
    super.init(interactor: interactor, viewController: viewController)
    interactor.router = self
  }
  
  private let subwayHomeBuilder: SubWayHomeBuildable
  private var subwayHome: SubWayHomeRouting?
  
  func presentSubwayHome() {
    let subwayHome = subwayHomeBuilder.build(withListener: interactor)
    self.subwayHome = subwayHome
    attachChild(subwayHome)
    viewController.pushViewController(subwayHome.viewControllable, animated: true)
  }
  
  func detachSubwayHome() {
    if let subwayHome {
      detachChild(subwayHome)
    }
  }
}

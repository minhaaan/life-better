import ModernRIBs
import UIKit
import Then
import SnapKit
import FlexLayout
import CombineCocoa
import Combine
import Utils

protocol RootPresentableListener: AnyObject {
  // TODO: Declare properties and methods that the view controller can invoke to perform
  // business logic, such as signIn(). This protocol is implemented by the corresponding
  // interactor class.
  func showSubwayHome()
}

final class RootViewController: UIViewController, RootPresentable, RootViewControllable {
  
  weak var listener: RootPresentableListener?
  
  enum Section {
    case main
  }
  
  // TODO: Collection RIBs 추가해서 분리
  private var collectionView: UICollectionView!
  private var dataSource: UICollectionViewDiffableDataSource<Section, Content>! = nil
  
  private var cancellable = Set<AnyCancellable>()
  
  // MARK: LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
//    setupCollectionView()
//    setupDatasource()
//    setupLayout()
  }
  
  // MARK: method
  
  func addChildRootListViewController(viewController: ViewControllable) {
    // zz
    let rootListViewController = viewController.uiviewController
    view.addSubview(rootListViewController.view)
    addChild(rootListViewController)
    rootListViewController.view.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
  
  private func setupCollectionView() {
    collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCollectionViewLayout())
    collectionView.contentInsetAdjustmentBehavior = .never
  }
  
  private func createCollectionViewLayout() -> UICollectionViewLayout {
    UICollectionViewCompositionalLayout { (sectionIndex: Int, env: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection in
      let itemSize = NSCollectionLayoutSize(
        widthDimension: .fractionalWidth(1),
        heightDimension: .fractionalHeight(1)
      )
      let item = NSCollectionLayoutItem(layoutSize: itemSize)
      
      let groupSize = NSCollectionLayoutSize(
        widthDimension: .fractionalWidth(0.7),
        heightDimension: .fractionalHeight(1)
      )
      let group = NSCollectionLayoutGroup.horizontal(
        layoutSize: groupSize,
        subitems: [item]
      )
      
      let section = NSCollectionLayoutSection(group: group)
      section.contentInsets = NSDirectionalEdgeInsets(top: env.container.contentSize.height/4, leading: 0, bottom: env.container.contentSize.height/4, trailing: 0)
      section.interGroupSpacing = 30
      section.orthogonalScrollingBehavior = .groupPagingCentered
      
      return section
    }
  }
  
  private func setupDatasource() {
    let cellRegistration = UICollectionView.CellRegistration<TextCell, Content> { cell, indexPath, itemIdentifier in
      cell.label.text = "\(itemIdentifier.name)"
      cell.contentView.backgroundColor = .systemBlue
      cell.layer.borderWidth = 1
      cell.layer.borderColor = UIColor.black.cgColor
      cell.label.textAlignment = .center
      cell.label.font = UIFont.preferredFont(forTextStyle: .title1)
    }
    
    dataSource = UICollectionViewDiffableDataSource<Section, Content>(
      collectionView: collectionView,
      cellProvider: { collectionView, indexPath, itemIdentifier in
        return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
    })
    
    var snapshot = NSDiffableDataSourceSnapshot<Section, Content>()
    snapshot.appendSections([.main])
    snapshot.appendItems(contents)
    dataSource.apply(snapshot, animatingDifferences: false)
  }
  
  private func setupLayout() {
    view.backgroundColor = .systemBackground
    
    view.addSubview(collectionView)
    collectionView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
  
}

#if canImport(SwiftUI)
import SwiftUI
struct RootVC_Preview: PreviewProvider {
  static var previews: some View {
    RootViewController(contents: [
      Content(imageName: "asdd", name: "SUBWAY"),
      Content(imageName: "asad", name: "TBD..")
    ]).showPreview()
      .edgesIgnoringSafeArea(.all)
  }
}
#endif

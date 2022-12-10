//
//  RootListViewController.swift
//  LifeBetter
//
//  Created by 최민한 on 2022/12/10.
//  Copyright © 2022 com.minan. All rights reserved.
//

import ModernRIBs
import UIKit
import Utils

protocol RootListPresentableListener: AnyObject {
  // TODO: Declare properties and methods that the view controller can invoke to perform
  // business logic, such as signIn(). This protocol is implemented by the corresponding
  // interactor class.
  func attachSubway()
}

final class RootListViewController: UIViewController, RootListPresentable, RootListViewControllable {
  
  weak var listener: RootListPresentableListener?
  
  enum Section {
    case main
  }
  
  private var collectionView: UICollectionView!
  private var dataSource: UICollectionViewDiffableDataSource<Section, Content>! = nil
  
  // MARK: Properties
  
  let contents: [Content]
  
  // MARK: init
  
  init(contents: [Content]) {
    self.contents = contents
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError()
  }
  
  // MARK: LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupCollectionView()
    setupDatasource()
    setupLayout()
  }
  
  // MARK: Method
  
  private func setupCollectionView() {
    collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCollectionViewLayout())
    collectionView.delegate = self
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

extension RootListViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    if let selectedContent = contents[safe: indexPath.row], selectedContent.name == "SUBWAY" {
      listener?.attachSubway()
    }
  }
}

#if canImport(SwiftUI)
import SwiftUI
struct RootList_Preview: PreviewProvider {
  static var previews: some View {
    RootListViewController(contents: [
      Content(imageName: "1", name: "SUBWAY"),
      Content(imageName: "2", name: "TBD..")
    ]).showPreview()
      .edgesIgnoringSafeArea(.all)
  }
}
#endif

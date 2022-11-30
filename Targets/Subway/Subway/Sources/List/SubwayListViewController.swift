//
//  SubwayListViewController.swift
//  Subway
//
//  Created by 최민한 on 2022/11/28.
//  Copyright © 2022 com.minan. All rights reserved.
//

import ModernRIBs
import UIKit

protocol SubwayListPresentableListener: AnyObject {
  // TODO: Declare properties and methods that the view controller can invoke to perform
  // business logic, such as signIn(). This protocol is implemented by the corresponding
  // interactor class.
}

final class SubwayListViewController: UIViewController, SubwayListPresentable, SubwayListViewControllable {
  
  weak var listener: SubwayListPresentableListener?
  
  private let subwayStations: [SubwayStation]
  
  // List CollectionView
  private let collectionView: UICollectionView = UICollectionView(
    frame: .zero,
    collectionViewLayout: UICollectionViewCompositionalLayout.list(
      using: UICollectionLayoutListConfiguration(appearance: .plain)
    )
  )
  
  // MARK: init
  
  init(subwayStations: [SubwayStation]) {
    self.subwayStations = subwayStations
    super.init(nibName: nil, bundle: nil)
  }
  required init?(coder: NSCoder) {
    fatalError()
  }
  
  // MARK: LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupLayout()
    setupCollectionView()
  }
  
  // MARK: func
  
  private func setupLayout() {
    view.backgroundColor = .systemPurple
    
    view.addSubview(collectionView)
    collectionView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
  
  private func setupCollectionView() {
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.register(UICollectionViewListCell.self, forCellWithReuseIdentifier: "cell")
  }
  
}

extension SubwayListViewController: UICollectionViewDataSource {
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    1
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    subwayStations.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: "cell",
      for: indexPath
    ) as? UICollectionViewListCell
    else {
      return UICollectionViewListCell()
    }
    
    var config = cell.defaultContentConfiguration()
    config.text = subwayStations[indexPath.row].stationName
    
    return cell
  }
}

extension SubwayListViewController: UICollectionViewDelegate {
  
}

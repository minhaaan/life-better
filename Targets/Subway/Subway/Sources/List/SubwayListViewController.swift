//
//  SubwayListViewController.swift
//  Subway
//
//  Created by 최민한 on 2022/11/28.
//  Copyright © 2022 com.minan. All rights reserved.
//

import ModernRIBs
import UIKit
import Then
import SubwayCore

protocol SubwayListPresentableListener: AnyObject {
  // TODO: Declare properties and methods that the view controller can invoke to perform
  // business logic, such as signIn(). This protocol is implemented by the corresponding
  // interactor class.
  func updateSearchKeyword(keyword: String)
  func didTapSubwayStation(station: SubwayStation)
}

final class SubwayListViewController: UIViewController, SubwayListPresentable, SubwayListViewControllable {
  
  weak var listener: SubwayListPresentableListener?
  
  private var subwayStations: [SubwayStation] = []
  
  // MARK: Layout Properties
  
  private lazy var searchBar = UISearchBar().then {
    $0.placeholder = "search"
    $0.barStyle = .default
    $0.sizeToFit()
    $0.delegate = self
  }
  
  // List CollectionView
  private let collectionView: UICollectionView = UICollectionView(
    frame: .zero,
    collectionViewLayout: UICollectionViewCompositionalLayout.list(
      using: UICollectionLayoutListConfiguration(appearance: .plain)
    )
  )
  
  // MARK: init
  
  init() {
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
    view.addSubview(searchBar)
    view.addSubview(collectionView)
    searchBar.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide)
      make.horizontalEdges.equalToSuperview()
    }
    collectionView.snp.makeConstraints { make in
      make.top.equalTo(searchBar.snp.bottom)
      make.horizontalEdges.bottom.equalToSuperview()
    }
  }
  
  private func setupCollectionView() {
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.register(UICollectionViewListCell.self, forCellWithReuseIdentifier: "cell")
  }
  
  func updateSubwayStations(with subwayStations: [SubwayStation]) {
    self.subwayStations = subwayStations
    collectionView.reloadData()
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
    
    guard let station = subwayStations[safe: indexPath.row] else { return UICollectionViewListCell() }
    
    var content = cell.defaultContentConfiguration()
    content.text = station.stationName
    // TODO: 수인분당, 신분당 등 처리.
    content.image = station.lineImage
    content.imageProperties.tintColor = SubwayAsset.lineImageColor.color
    cell.contentConfiguration = content
    return cell
  }
}

extension SubwayListViewController: UICollectionViewDelegate {
  func collectionView(
    _ collectionView: UICollectionView,
    didSelectItemAt indexPath: IndexPath
  ) {
    guard let selectedStation = subwayStations[safe: indexPath.row] else { return }
    listener?.didTapSubwayStation(station: selectedStation)
  }
}

extension SubwayListViewController: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    listener?.updateSearchKeyword(keyword: searchText)
  }
}

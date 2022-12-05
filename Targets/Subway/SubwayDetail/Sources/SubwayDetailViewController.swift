//
//  SubwayDetailViewController.swift
//  SubwayDetail
//
//  Created by 최민한 on 2022/12/02.
//  Copyright © 2022 com.minan. All rights reserved.
//

import ModernRIBs
import UIKit
import SubwayCore
import Combine

protocol SubwayDetailPresentableListener: AnyObject {
  // TODO: Declare properties and methods that the view controller can invoke to perform
  // business logic, such as signIn(). This protocol is implemented by the corresponding
  // interactor class.
  func detachSubwayDetail()
  func getArrivalData()
}

final class SubwayDetailViewController: UIViewController, SubwayDetailPresentable, SubwayDetailViewControllable {
  
  // MARK: Properties
  
  weak var listener: SubwayDetailPresentableListener?
  
  private let stationName: String
  
  var arrivalData = PassthroughSubject<RealtimeStationArrivalModel, Never>()
  
  private var bag = Set<AnyCancellable>()
  
  // MARK: LayoutProperties
  
  // MARK: init
  
  init(stationName: String) {
    self.stationName = stationName
    super.init(nibName: nil, bundle: nil)
    self.setupNavBar()
  }
  
  required init?(coder: NSCoder) {
    fatalError()
  }
  
  // MARK: LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupLayout()
    bind()
    listener?.getArrivalData()
  }
  
  override func didMove(toParent parent: UIViewController?) {
    super.didMove(toParent: parent)
    if parent == nil {
      listener?.detachSubwayDetail()
    }
  }
  
  // MARK: Method
  
  private func setupNavBar() {
    self.navigationItem.title = stationName
  }
  
  private func setupLayout() {
    view.backgroundColor = .systemBackground
  }
  
  private func bind() {
    arrivalData
      .sink(receiveCompletion: { compl in
        print("DEBUG: comp is \(compl)")
      }, receiveValue: { [weak self] value in
        print("DEBUG: value is \(value)")
      })
      .store(in: &bag)
    
  }
}

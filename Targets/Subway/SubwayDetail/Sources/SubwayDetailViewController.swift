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
  func getData()
}

final class SubwayDetailViewController: UIViewController, SubwayDetailPresentable, SubwayDetailViewControllable {
  
  // MARK: Properties
  
  weak var listener: SubwayDetailPresentableListener?
  
  var data = PassthroughSubject<RealtimeStationArrivalModel, Never>()
  
  private var bag = Set<AnyCancellable>()
  
  // MARK: LayoutProperties
  
  
  // MARK: init
  
  // MARK: LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupLayout()
    bind()
    listener?.getData()
  }
  
  override func didMove(toParent parent: UIViewController?) {
    super.didMove(toParent: parent)
    if parent == nil {
      listener?.detachSubwayDetail()
    }
  }
  
  // MARK: Method
  
  private func setupLayout() {
    view.backgroundColor = .systemGreen
  }
  
  private func bind() {
    data
      .sink(receiveCompletion: { compl in
      print("DEBUG: comp is \(compl)")
    }, receiveValue: { value in
      print("DEBUG: value is \(value)")
    })
    .store(in: &bag)

  }
}

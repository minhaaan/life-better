//
//  SubwayDetailViewController.swift
//  SubwayDetail
//
//  Created by 최민한 on 2022/12/02.
//  Copyright © 2022 com.minan. All rights reserved.
//

import ModernRIBs
import UIKit

protocol SubwayDetailPresentableListener: AnyObject {
  // TODO: Declare properties and methods that the view controller can invoke to perform
  // business logic, such as signIn(). This protocol is implemented by the corresponding
  // interactor class.
}

final class SubwayDetailViewController: UIViewController, SubwayDetailPresentable, SubwayDetailViewControllable {
    
  // MARK: Properties
  
  weak var listener: SubwayDetailPresentableListener?
  
  // MARK: init
  
  // MARK: LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupLayout()
  }
  
  // MARK: Method
  
  private func setupLayout() {
    view.backgroundColor = .systemGreen
  }
}

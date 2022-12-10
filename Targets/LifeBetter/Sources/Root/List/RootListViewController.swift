//
//  RootListViewController.swift
//  LifeBetter
//
//  Created by 최민한 on 2022/12/10.
//  Copyright © 2022 com.minan. All rights reserved.
//

import ModernRIBs
import UIKit

protocol RootListPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class RootListViewController: UIViewController, RootListPresentable, RootListViewControllable {

    weak var listener: RootListPresentableListener?
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .systemPink
  }
}

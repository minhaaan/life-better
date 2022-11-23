//
//  SubWayHomeViewController.swift
//  Subway
//
//  Created by 최민한 on 2022/11/23.
//  Copyright © 2022 com.minan. All rights reserved.
//

import ModernRIBs
import UIKit

protocol SubWayHomePresentableListener: AnyObject {
  // TODO: Declare properties and methods that the view controller can invoke to perform
  // business logic, such as signIn(). This protocol is implemented by the corresponding
  // interactor class.
}

final class SubWayHomeViewController: UIViewController, SubWayHomePresentable, SubWayHomeViewControllable {
  
  weak var listener: SubWayHomePresentableListener?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .systemPink
  }
}

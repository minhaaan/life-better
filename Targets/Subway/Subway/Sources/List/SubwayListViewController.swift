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
}

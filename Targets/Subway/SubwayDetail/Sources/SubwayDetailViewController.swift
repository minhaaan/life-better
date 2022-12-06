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
import Utils
import SnapKit

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
  
  var heading = Set<String>() {
    didSet {
      self.showSelectedTrainLineNmAlert()
    }
  }
  
  var list: [RealtimeArrivalList] = []
  
  private var bag = Set<AnyCancellable>()
  
  // MARK: LayoutProperties
  
  let label = UILabel()
  
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
    
    view.addSubview(label)
    label.snp.makeConstraints { make in
      make.center.equalToSuperview()
    }
  }
  
  private func showSelectedTrainLineNmAlert() {
    DispatchQueue.main.async {
      let alertVC = UIAlertController(title: "어디 방향으로 가시나요?", message: "😎", preferredStyle: .actionSheet)
      self.heading.forEach { trainLineNm in
        let alertAction = UIAlertAction(title: trainLineNm, style: .default) { [weak self] action in
          self?.filterSelectedTrainLineNmWithList(with: trainLineNm)
        }
        alertVC.addAction(alertAction)
      }
      alertVC.addAction(UIAlertAction(title: "다른역 선택하기", style: .cancel, handler: { [weak self] _ in
        self?.popViewController(animated: true)
        self?.listener?.detachSubwayDetail()
      }))
      self.present(alertVC, animated: true, completion: nil)
    }
  }
  
  func filterSelectedTrainLineNmWithList(with trainLineName: String) {
    defer { self.label.text = list.map { $0.arvlMsg2 }.joined(separator: ", ") }
    list = list.filter { realTimeArrivalData in
      realTimeArrivalData.trainLineNm.contains(trainLineName)
    }
  }
  
  func updateHeadingList(with: Set<String>) {
    self.heading = with
  }
  
  func updateArrivalList(with: [RealtimeArrivalList]) {
    self.list = with
  }
}

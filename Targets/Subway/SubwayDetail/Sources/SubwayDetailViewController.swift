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
  
  var arrivalData = PassthroughSubject<RealtimeStationArrivalModel, Never>()
  
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
    
    view.addSubview(label)
    label.snp.makeConstraints { make in
      make.center.equalToSuperview()
    }
  }
  
  private func bind() {
    arrivalData
      .sink(receiveValue: { [weak self] value in
        log.debug("arrivalData is \(value)")
        let headingListValue = value.realtimeArrivalList
          .map { $0.trainLineNm }
          .compactMap { trainLineNm in return trainLineNm.components(separatedBy: "-")[safe: 1]?.trimmingCharacters(in: .whitespaces) }
        self?.heading = Set(headingListValue)
        self?.list = value.realtimeArrivalList
      })
      .store(in: &bag)
  }
  
  private func showSelectedTrainLineNmAlert() {
    let alertVC = UIAlertController(title: "어디 방향으로 가시나요?", message: "😎", preferredStyle: .actionSheet)
    heading.forEach { trainLineNm in
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
  
  func filterSelectedTrainLineNmWithList(with trainLineName: String) {
    defer { self.label.text = list.map { $0.arvlMsg2 }.joined(separator: ", ") }
    list = list.filter { realTimeArrivalData in
      realTimeArrivalData.trainLineNm.contains(trainLineName)
    }
  }
}

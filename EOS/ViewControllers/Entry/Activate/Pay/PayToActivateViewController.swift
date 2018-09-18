//
//  PayToActivateViewController.swift
//  EOS
//
//  Created zhusongyu on 2018/9/6.
//  Copyright © 2018年 com.nbltrustdev. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import ReSwift
import XLPagerTabStrip

class PayToActivateViewController: BaseViewController,IndicatorInfoProvider {

	var coordinator: (PayToActivateCoordinatorProtocol & PayToActivateStateManagerProtocol)?

    @IBOutlet weak var contentView: PayView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupData()
        setupUI()
        setupEvent()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func refreshViewController() {
        
    }
    
    func setupUI() {
        
    }

    func setupData() {
        self.coordinator?.getBill()
    }
    
    func setupEvent() {
        
    }
    
    override func configureObserveState() {
        coordinator?.state.billInfo.asObservable().subscribe(onNext: {[weak self] (model) in
            guard let `self` = self else { return }
            self.contentView.adapterModelToPayView(model)
        }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
    }
}

//MARK: - TableViewDelegate

//extension PayToActivateViewController: UITableViewDataSource, UITableViewDelegate {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 10
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//          let cell = tableView.dequeueReusableCell(withIdentifier: R.nib.<#cell#>.name, for: indexPath) as! <#cell#>
//
//        return cell
//    }
//}


//MARK: - View Event

//extension PayToActivateViewController {
//    @objc func <#view#>DidClicked(_ data:[String: Any]) {
//        if let addressdata = data["data"] as? <#model#>, let view = data["self"] as? <#view#>  {
//
//        }
//    }
//}
extension PayToActivateViewController {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(stringLiteral: R.string.localizable.pay_to_activate.key.localized())
    }
    
    @objc func NextClick(_ data:[String :Any]) {
        self.coordinator?.initOrder()
    }
}

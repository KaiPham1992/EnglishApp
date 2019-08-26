//
//  HistoryBeeViewController.swift
//  EnglishApp
//
//  Created Kai Pham on 5/19/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class HistoryBeeViewController: BaseViewController {

	var presenter: HistoryBeePresenterProtocol?
    @IBOutlet weak var tbHistory: UITableView!
    @IBOutlet weak var headerView: HistoryBeeHeader!
    @IBOutlet weak var heightOfHeader: NSLayoutConstraint!
    
    var totalWallet = 0
    var wallet_type = 0
    
    var listWalletLog = [LogEntity](){
        didSet{
            tbHistory.reloadData()
        }
    }
	override func viewDidLoad() {
        super.viewDidLoad()
        configureTable()
        presenter?.getWalletLog(wallet_type: self.wallet_type)
        headerView.isHidden = true
        
    }
    
    override func setUpNavigation() {
        super.setUpNavigation()
        addBackToNavigation()
        setTitleNavigation(title: LocalizableKey.titleHistoryNap.showLanguage)
    }
    
    func loadHeaderView() {
        if self.wallet_type == 3 {
            heightOfHeader.constant = 300
        } else {
            heightOfHeader.constant = 220
        }
        headerView.displayData(walletType: self.wallet_type, total: self.totalWallet)
        headerView.delegate = self
        headerView.isHidden = false
    }

}


extension HistoryBeeViewController: UITableViewDelegate, UITableViewDataSource {
    func configureTable() {
        tbHistory.delegate = self
        tbHistory.dataSource = self
        tbHistory.registerXibFile(HistoryBeeCell.self)
        tbHistory.separatorStyle = .none
        tbHistory.rowHeight = UITableView.automaticDimension
        tbHistory.estimatedRowHeight = 80
        
//        tbHistory.estimatedRowHeight = 55
//        tbHistory.rowHeight = UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(HistoryBeeCell.self, for: indexPath)
        if indexPath.item < presenter?.listHistory.count ?? 0 {
            cell.walletLog = presenter?.listHistory[indexPath.item]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numOfRow() ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 60
//    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row >= ((presenter?.listHistory.count ?? 0) - 5) && presenter?.canLoadMore == true {
            presenter?.getWalletLog(wallet_type: self.wallet_type)
        }
    }
    
    // header
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let header = HistoryBeeHeader()
//        header.displayData(walletType: self.wallet_type, total: self.totalWallet)
//        header.delegate = self
//        return header
//    }
//
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        if self.wallet_type == 3{
//            return 300
//        }else{
//            return 220
//        }
//    }
}
extension HistoryBeeViewController: HistoryBeeViewProtocol{
    
    func didGetWalletLog(listWalletLog: [LogEntity], totalWallet: Int) {
        
        if presenter?.listHistory.count == 0 {
            showNoData()
            self.totalWallet = 0
        }else{
            hideNoData()
            self.totalWallet = totalWallet
        }
        self.listWalletLog = listWalletLog
        loadHeaderView()
    }
    
    func didGetWalletLog(error: Error) {
        print(error.localizedDescription)
    }
}

extension HistoryBeeViewController: HistoryBeeHeaderDelegate{
    
    func btnAddTapped() {
        let storeViewController = StoreViewController()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15, execute: {
            storeViewController.moveToViewController(at: 1)
        })
        self.push(controller: storeViewController)
    }
}

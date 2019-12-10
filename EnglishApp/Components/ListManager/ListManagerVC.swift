//
//  ListManager.swift
//  EnglishApp
//
//  Created by Steve on 7/30/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

class ListManagerVC: BaseViewController {

    var tableView: UITableView = UITableView()
    
    //list data of tableview
    var listData: [Any] = []
    //add title navigation
    var customTitle = ""
    //add back butotn
    var showButtonBack = true
    //set offset of param
    var offset = 0
    //true -> use pull to fresh : false -> disable pull to refresh
    var isAddPullToFresh = true
    // constraint use callAPI -> ovrrived to use pull to refresh
    var isLoadmore = true
    
    var messageNoData = LocalizableKey.lbNoData.showLanguage
    
    //pull to refresh
    private let refreshControl = UIRefreshControl()
    
    private var isShowProgressView = true
    
    override func setUpViews() {
        self.view.addSubview(tableView)
        isShowProgressView = true
        tableView.fillSuperview()
        setupViewListManager()
        registerTableView()
        if isAddPullToFresh {
            addPullToRefresh()
        }
        callAPI()
        self.tableView.isHidden = true
    }
    
    func setupViewListManager(){

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.tableFooterView = UIView()
        self.tableView.tableFooterView?.isHidden = true
    }
    
    func initLoadData(data: [Any]){
        DispatchQueue.global().async {
            if self.offset == 0 {
                self.listData.removeAll()
                self.listData = data
            } else {
                self.listData += data
            }
            if data.count < limit {
                self.isLoadmore = false
            } else {
                self.isLoadmore = true
                self.offset += limit
            }
            DispatchQueue.main.async {
                self.tableView.isHidden = false
                ProgressView.shared.hide()
                if data.count == 0 && self.offset == 0 {
                    self.showNoData(text: self.messageNoData)
                } else {
                    self.hideNoData()
                }
                self.tableView.reloadData()
            }
        }
    }
    
    override func setUpNavigation() {
        super.setUpNavigation()
        if showButtonBack {
            addBackToNavigation()
        }
        setTitleNavigation(title: customTitle)
    }
    
    func registerTableView(){
        self.tableView.separatorStyle = .none
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    private func addPullToRefresh(){
        if #available(iOS 10.0, *) {
            self.tableView.refreshControl = refreshControl
        } else {
            self.tableView.addSubview(refreshControl)
        }
        refreshControl.addTarget(self, action: #selector(ListManagerVC.actionPullToRefresh), for: .valueChanged)
    }
    
    @objc func actionPullToRefresh(){
        isLoadmore = true
        self.offset = 0
        isShowProgressView = false
        callAPI()
        refreshControl.endRefreshing()
    }
    
    func callAPI() {
        if isShowProgressView {
            ProgressView.shared.show()
        }
    }
    
    func cellForRowListManager(item: Any,_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        return UITableViewCell()
    }
    
    func didSelectTableView(item: Any, indexPath: IndexPath){
        
    }
}

extension ListManagerVC : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectTableView(item: listData[indexPath.row], indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == listData.count - 5 && isLoadmore {
            self.isShowProgressView = false
            callAPI()
            let spiner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
            spiner.startAnimating()
            spiner.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 44)
            self.tableView.tableFooterView = spiner
            self.tableView.tableFooterView?.isHidden = false
        } else {
            self.tableView.tableFooterView?.isHidden = true
        }
    }
}

extension ListManagerVC : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let row = listData.count
        return row
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cellForRowListManager(item: listData[indexPath.row], tableView, cellForRowAt: indexPath)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

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
    // if height row = 0 -> set dynamic height
    var heightRow  : CGFloat = 50
    //to set dymanic height
    var estimateHeightRow : CGFloat = 50
    
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
    
    //pull to refresh
    private let refreshControl = UIRefreshControl()
    
    override func setUpViews() {
        self.view.addSubview(tableView)
        tableView.fillSuperview()
        setupViewListManager()
        registerTableView()
        if isAddPullToFresh {
            addPullToRefresh()
        }
        callAPI()

    }
    
    func setupViewListManager(){

    }
    
    func initLoadData(data: [Any],replaceData : Bool = true){
        if data.count < limit {
            isLoadmore = false
        }
        if replaceData {
            self.listData = data
        } else {
            self.listData += data
        }
        self.tableView.reloadData()
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
    
    func didSelectTableView(indexPath: IndexPath){
        
    }
    
    private func addPullToRefresh(){
        refreshControl.addTarget(self, action: #selector(actionPullToRefresh), for: .valueChanged)
        if #available(iOS 10.0, *) {
            self.tableView.refreshControl = refreshControl
        } else {
            self.tableView.addSubview(refreshControl)
        }
    }
    
    @objc func actionPullToRefresh(){
        isLoadmore = true
        callAPI()
        refreshControl.endRefreshing()
    }
    
    func callAPI(){
        
    }
    
    func loadMoreData(){
    }
    
    func cellForRowListManager(item: Any,_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        return UITableViewCell()
    }
}
extension ListManagerVC : UITableViewDelegate{
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return estimateHeightRow
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightRow == 0 ? 170 : heightRow
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectTableView(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == listData.count - 1 && isLoadmore{
            loadMoreData()
        }
    }
}

extension ListManagerVC : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let row = listData.count
        if row == 0 {
            showNoData()
        } else {
            hideNoData()
        }
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

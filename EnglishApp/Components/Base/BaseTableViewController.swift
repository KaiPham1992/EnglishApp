//
//  BaseTableViewController.swift
//  EnglishApp_Dev
//
//  Created by Steve on 8/31/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import UIKit

open class BaseTableViewController: BaseViewController {

    // Config tableview
    public var tableView: UITableView?
    
    // Add push to refresh
    var isAddPullToFresh = true
    
    // List data of tableview
    var listData: [Any] = []
    var offset : Int = 0
    
    // Pull to refresh
    private let refreshControl = UIRefreshControl()
    
    // Constraint use callAPI -> overrived to use 'pull to refresh'
    var isLoadmore = true
    var addLoadmore = true
    private var isShowProgressView = true
    var showProgressViewOnTableView = false

    var messageNoData = LocalizableKey.lbNoData.showLanguage
    
    override open func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func initTableView(tableView: UITableView) {
        self.tableView = tableView
        self.tableView?.dataSource = self
        self.tableView?.delegate = self
        self.registerXibFile()
        if isAddPullToFresh {
            self.addPullToRefresh()
        }
    }
    
    func registerXibFile() { }
    
    private func addPullToRefresh(){
        refreshControl.addTarget(self, action: #selector(BaseTableViewController.actionPullToRefresh), for: .valueChanged)
        if #available(iOS 10.0, *) {
            self.tableView?.refreshControl = refreshControl
        } else {
            self.tableView?.addSubview(refreshControl)
        }
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
            if showProgressViewOnTableView {
                ProgressView.shared.showOnFrame(frame: tableView?.frame ?? CGRect.zero)
            } else {
                ProgressView.shared.show()
            }
        }
    }
    
    func initLoadData(data: [Any]){
        DispatchQueue.global().async {
            if self.offset == 0 {
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
                ProgressView.shared.hide()
                if data.count == 0 && self.offset == 0 {
                    self.showNoData()
                } else {
                    self.tableView?.isHidden = false
                    self.hideNoData()
                }
                self.tableView?.reloadData()
            }
        }
    }
    
    func addData(data: Any, index: Int) {
        listData.insert(data, at: index)
        hideNoData()
        UIView.performWithoutAnimation {
            self.tableView?.reloadData()
        }
    }
    
    func cellForRowAt(item: Any,_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { return UITableViewCell() }
    
    func didSelectedRowAt(item: Any, indexPath: IndexPath) { }
    
}

// MARK: - UITableViewDataSource
extension BaseTableViewController : UITableViewDataSource {
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
        
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectedRowAt(item: listData[indexPath.row], indexPath: indexPath)
    }
    
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if addLoadmore {
            if indexPath.row == listData.count - 5 && isLoadmore {
                self.isShowProgressView = false
                callAPI()
                let spiner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
                spiner.startAnimating()
                spiner.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 44)
                self.tableView?.tableFooterView = spiner
                self.tableView?.tableFooterView?.isHidden = false
            } else {
                self.tableView?.tableFooterView?.isHidden = true
            }
        }
    }
}

// MARK: - UITableViewDelegate
extension BaseTableViewController : UITableViewDelegate {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let row = listData.count
        return row
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cellForRowAt(item: listData[indexPath.row], tableView, cellForRowAt: indexPath)
        return cell
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

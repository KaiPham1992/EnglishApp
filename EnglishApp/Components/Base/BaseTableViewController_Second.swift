//
//  BaseTableViewController_Second.swift
//  EnglishApp
//
//  Created by Henry Tran on 1/3/20.
//  Copyright © 2020 demo. All rights reserved.
//


import UIKit

//let limit = 10

class BaseTableViewControllerSecond: BaseViewController {
    
    @IBOutlet weak var myTableView: UITableView!
    
    var listItem: [Any] = [] {
        didSet {
            ProgressView.shared.hide()
            if refreshControl.isRefreshing { refreshControl.endRefreshing() }
            print("* list tableview item count = \(self.listItem.count) *")
            DispatchQueue.main.async {
                self.myTableView.isHidden = false
                self.myTableView.reloadData()
            }
        }
    }
    let refreshControl = UIRefreshControl()
    var canLoadMore = false
    var showLoadingIcon = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addPullToRefresh()
        
        myTableView.dataSource = self
        myTableView.delegate = self
        myTableView.showsVerticalScrollIndicator = false

    }
    
    // MARK: - Fetch data from API
    func fetchData() {
        if showLoadingIcon {
            ProgressView.shared.show()
        }
    }
    
    func didFetchData(data: [Any]) {
        
        // Check can load more
        if data.count < limit {
            canLoadMore = false
        } else {
            canLoadMore = true
        }
        // Store data
        if listItem.count == 0 {
            listItem = data
        } else {
            listItem += data
        }
        /** Show no data if need
            ...
        */
        
    }
    
    // MARK: - For pull to refresh
    private func addPullToRefresh() {
        refreshControl.tintColor = UIColor.gray
        refreshControl.addTarget(self, action: #selector(BaseTableViewControllerSecond.pullToRefresh), for: .valueChanged)
        if #available(iOS 10.0, *) {
            self.myTableView.refreshControl = refreshControl
        } else {
            self.myTableView.addSubview(refreshControl)
        }
    }
    
    @objc func pullToRefresh() {
        self.listItem.removeAll()
        myTableView.reloadData() /** Ignore crash by "Out of index" */
        canLoadMore = true
        showLoadingIcon = false
        fetchData()
        
    }
    
    
    // MARK:- Override to use
    func cellForRowAt(item: Any, for indexPath: IndexPath, tableView: UITableView) -> UITableViewCell {
        /** Do something
            ...
        */
        return UITableViewCell()
    }
    
    func didSelectRowAt(selectedItem: Any, indexPath: IndexPath) {
        /** Do something
            ...
        */
    }
    
    func setHeightForRow() -> CGFloat {
        let height: CGFloat = UITableView.automaticDimension
        return height
    }
}

// MARK: - Table view delegate
extension BaseTableViewControllerSecond: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return setHeightForRow()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectRowAt(selectedItem: listItem[indexPath.row], indexPath: indexPath)
    }
    
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == listItem.count - 1 && canLoadMore {
            self.showLoadingIcon = false
            let spiner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
            spiner.startAnimating()
            spiner.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50)
            tableView.tableFooterView = spiner
            tableView.tableFooterView?.isHidden = false
            // -----
            print("* loadmore *")
            fetchData()
        } else {
            tableView.tableFooterView = nil
            tableView.tableFooterView?.isHidden = true
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        dismissKeyBoard()
    }
    
}

// MARK: - Table view datasource
extension BaseTableViewControllerSecond: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cellForRowAt(item: listItem[indexPath.row], for: indexPath, tableView: tableView)
    }
}

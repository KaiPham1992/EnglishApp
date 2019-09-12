//
//  NotificationListViewController.swift
//  EnglishApp
//
//  Created Kai Pham on 6/2/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class NotificationListViewController: BaseViewController, NotificationListViewProtocol {

    @IBOutlet weak var tbNotification: UITableView!
	var presenter: NotificationListPresenterProtocol?
    
    let refreshControl = UIRefreshControl()
    
    var listNotification = [NotificationEntity]() {
        didSet {
            tbNotification.reloadData()
        }
    }

	override func viewDidLoad() {
        super.viewDidLoad()
        configureTable()
        presenter?.getNotification()
        
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
    }
    
    @objc func pullToRefresh() {
        refreshControl.endRefreshing()
        presenter?.getNotification()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        DispatchQueue.main.async {
//            self.tbNotification.reloadData()
//        }
    }
    
    override func setUpNavigation() {
        super.setUpNavigation()
         addBackToNavigation()
        setTitleNavigation(title: LocalizableKey.titleNotification.showLanguage)
        
        hideTabbar()
    }
    
    override func setTitleUI() {
        super.setTitleUI()
    }
    
    func didLoadNotification(listNotification: [NotificationEntity]) {
        if listNotification.count == 0 {
            showNoData()
        } else {
            hideNoData()
        }
        self.listNotification = listNotification
    }
    
    func goToScreen(actionKey: String, index: Int) {
        let noti = self.listNotification[index]
        switch actionKey {
        case "EXPIRED_PRODUCT":
            self.push(controller: StoreViewController())
        case "COMMENT_QUESTION":
            // do something
            break
        case "ASSIGNED_EXERCISE":
            // do something
            break
        case "NOTIF_EVENT":
            if let id = Int(noti.id&) {
                presenter?.readNotification(id: id)
                self.listNotification[index].isRead = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
                    self.tbNotification.reloadData()
                })
            }
            self.push(controller: NotificationDetailRouter.createModule(notification: noti))
        case "OTHER":
            break
        default:
            break
        }
    }
}


extension NotificationListViewController: UITableViewDelegate, UITableViewDataSource {
    func configureTable() {
        tbNotification.delegate = self
        tbNotification.dataSource = self
        tbNotification.registerXibFile(NotificationCell.self)
        tbNotification.separatorStyle = .none
        tbNotification.clipsToBounds = true
        
        tbNotification.estimatedRowHeight = 55
        tbNotification.rowHeight = UITableView.automaticDimension
        
        tbNotification.refreshControl = self.refreshControl
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(NotificationCell.self, for: indexPath)
        cell.notification = self.listNotification[indexPath.item]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listNotification.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let actionKey = self.listNotification[indexPath.item].actionKey else { return  }
        goToScreen(actionKey: actionKey, index: indexPath.item)
//        let noti = self.listNotification[indexPath.item]
//        if let id = Int(noti.id&) {
//            presenter?.readNotification(id: id)
//            self.listNotification[indexPath.item].isRead = true
//            self.tbNotification.reloadData()
//            self.push(controller: NotificationDetailRouter.createModule(idNotification: id))
//        }
//        self.push(controller: NotificationDetailRouter.createModule(notification: noti))
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if self.listNotification.count > 5 && indexPath.item >= self.listNotification.count - 5 {
            presenter?.loadMoreNotification()
        }
    }
}

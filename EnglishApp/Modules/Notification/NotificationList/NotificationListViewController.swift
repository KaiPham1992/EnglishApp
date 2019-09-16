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

class NotificationListViewController: ListManagerVC  {
   
	var presenter: NotificationListPresenterProtocol?

	override func viewDidLoad() {
        customTitle = LocalizableKey.titleNotification.showLanguage
        showButtonBack = true
        super.viewDidLoad()
        hideTabbar()
        
    }
    
    override func callAPI() {
        super.callAPI()
        self.presenter?.getNotification(offset: self.offset)
    }
    
    override func registerTableView() {
        super.registerTableView()
        tableView.registerXibFile(NotificationCell.self)
    }
    
    override func cellForRowListManager(item: Any, _ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = item as! NotificationEntity
        let cell = tableView.dequeue(NotificationCell.self, for: indexPath)
        cell.notification = data
        return cell
    }
   
    override func didSelectTableView(item: Any, indexPath: IndexPath) {
        let data = item as! NotificationEntity
        goToScreen(noti: data)
    }
    
    func goToScreen(noti: NotificationEntity) {
        let actionKey = noti.actionKey
        if noti.isRead == false {
            self.presenter?.readNotification(id: Int(noti.id ?? "0") ?? 0)
            noti.isRead = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
                self.tableView.reloadData()
            })
        }
        switch actionKey {
        case "ANSWERED_QUESTION":
            let oid = noti.objectId
            let vc = QADetailRouter.createModule(id: Int(oid&) ?? 0)
            self.push(controller: vc)
        case "EXPIRED_PRODUCT":
            self.push(controller: StoreViewController())
        case "COMMENT_QUESTION":
            let oid = noti.objectId
            let vc = ExplainExerciseGroupRouter.createModule(id: Int(oid&) ?? 0)
            self.push(controller: vc)
        case "ASSIGNED_EXERCISE":
            let vc = AssignExerciseRouter.createModule()
            self.push(controller: vc)
        case "NOTIF_EVENT":
            if let id = Int(noti.id&) {
                self.push(controller: NotificationDetailRouter.createModule(idNotification: id))
            }
        case "WALLET_DIAMOND":
            self.push(controller: HistoryBeeRouter.createModule(wallet_type: 1))
        case "WALLET_HONEY", "BUY_HONEY":
            self.push(controller: HistoryBeeRouter.createModule(wallet_type: 3))
        default:
            break
        }
    }
}

extension NotificationListViewController: NotificationListViewProtocol {
    func didLoadNotification(listNotification: [NotificationEntity]) {
        initLoadData(data: listNotification)
    }
}

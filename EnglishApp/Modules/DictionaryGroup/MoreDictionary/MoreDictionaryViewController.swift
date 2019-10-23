//
//  MoreDictionaryViewController.swift
//  EnglishApp
//
//  Created vinova on 5/15/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit
import RealmSwift

class MoreDictionaryViewController: ListManagerVC {
    
	var presenter: MoreDictionaryPresenterProtocol?
    public var callBackChangeDictionary : (() -> ())?

    override func setUpViews() {
        showButtonBack = true
        customTitle = LocalizableKey.addDictionary.showLanguage
        super.setUpViews()
    }
    
    let id_user = Int(UserDefaultHelper.shared.loginUserInfo?.id ?? "0") ?? 0
    
    override func registerTableView() {
        super.registerTableView()
        self.tableView.registerXibFile(MoreDictionaryCell.self)
    }
    
    override func callAPI() {
        self.presenter?.getListDictionary()
    }
    
    override func cellForRowListManager(item: Any, _ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = item as! ItemDictionaryResponse
        let cell = tableView.dequeueTableCell(MoreDictionaryCell.self)
        cell.setupCell(isDownloaded: data.isDownload, title: data.name&, isDefault: data.isDefault, idDownloading: data.isDownloading)
        
        cell.actionCell = {[weak self] (isDownloaded) in
            self?.processFile(isDownloaded: isDownloaded,item: data)
        }
        cell.actionSetDefaultDictionary = {[weak self] (isChoice) in
            data.isDefault = isChoice
            self?.setDefaultDictionary(id: data.id)
        }
        return cell
    }
    
    func setDefaultDictionary(id: Int){
        let listDataItem = listData as! [ItemDictionaryResponse]
        for item in listDataItem {
            if item.id == id {
                item.isDefault = true
            } else {
                item.isDefault = false
            }
        }
        self.tableView.reloadData()
        RealmDBManager.share.updateLocalConfigDictionary(id: id, id_user: id_user)
        self.callBackChangeDictionary?()
    }
    
    func processFileDownload(link: String, item: ItemDictionaryResponse, isRunBackground : Bool = false) {
        if !isRunBackground {
            ProgressView.shared.showFullScreen()
        }
        let objects = RealmDBManager.share.filter(objectType: LocalConfigDictionary.self, key: "id_dictionary", value: item.id)
        if objects.count > 0 {
            self.changeViewAfterDownloadSuccessed(item: item)
        } else {
            FileZipManager.shared.downLoadFile(idDictionary: item.id, link: link) {
                self.changeViewAfterDownloadSuccessed(item: item)
            }
        }
    }
    
    private func changeViewAfterDownloadSuccessed(item: ItemDictionaryResponse) {
        DispatchQueue.global(qos: DispatchQoS.QoSClass.background).async {
            let id_user = Int(UserDefaultHelper.shared.loginUserInfo?.id ?? "0") ?? 0
            let object = LocalConfigDictionary(id_dictionary: item.id, name: item.name, id_user: id_user)
            item.isDownload = true
            item.isDownloading = false
            LiveData.listDownloading = LiveData.listDownloading.filter{$0 != item.id}
            let numberDownloaded = (self.listData as! [ItemDictionaryResponse]).filter({$0.isDownload}).count
            if numberDownloaded == 1 {
                object.isDefault = 1
                item.isDefault = true
            }
            DispatchQueue.main.async {
                RealmDBManager.share.addObject(value: object)
                self.tableView.reloadData()
                ProgressView.shared.hide()
                self.callBackChangeDictionary?()
            }
        }
    }
    
    func processFile(isDownloaded: Bool,item: ItemDictionaryResponse){
        if !isDownloaded {
            let link = BASE_URL + item.link_dictionary&
            if link != BASE_URL {
                PopUpHelper.shared.showComfirmPopUp(message: LocalizableKey.run_background.showLanguage , titleYes: LocalizableKey.confirm.showLanguage.uppercased(), titleNo: LocalizableKey.cancel.showLanguage.uppercased(), complete: { [unowned self] in
                    let index = (self.listData as! [ItemDictionaryResponse]).map({$0.id}).index(item.id, offsetBy: 0, limitedBy: self.listData.count) ?? 0
                    if let cell = self.tableView.cellForRow(at: IndexPath(row: index - 1, section: 0)) as? MoreDictionaryCell{
                        cell.hideBtnDelete()
                    }
                    item.isDownloading = true
                    LiveData.listDownloading.append(item.id)
                    self.processFileDownload(link: link, item: item, isRunBackground: true)
                }) {
                    self.processFileDownload(link: link, item: item)
                }
            }
        } else {
            DispatchQueue.main.async {
                ProgressView.shared.showFullScreen()
                let object = RealmDBManager.share.filter(objectType: LocalConfigDictionary.self, key: "id_dictionary", value: item.id)
                if object.count == 1 {
                    RealmDBManager.share.removeAllObject(type: WordEntity.self, key: "id_dictionary", value: item.id)
                    RealmDBManager.share.removeAllObject(type: WordExplainEntity.self, key: "id_dictionary", value: item.id)
                }
                RealmDBManager.share.removeObject(type: LocalConfigDictionary.self, value: "\(item.id)_\(self.id_user)")
                item.isDownload = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    ProgressView.shared.hide()
                })
                self.tableView.reloadData()
                self.callBackChangeDictionary?()
            }
        }
    }
}

extension MoreDictionaryViewController : MoreDictionaryViewProtocol {
    func reloadDictionary(data: [ItemDictionaryResponse]){
        initLoadData(data: data)
    }
}

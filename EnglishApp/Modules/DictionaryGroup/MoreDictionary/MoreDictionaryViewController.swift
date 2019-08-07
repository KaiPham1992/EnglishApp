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
    @IBOutlet weak var tbvDictionary: UITableView!
    
	var presenter: MoreDictionaryPresenterProtocol?

    override func setUpViews() {
        showButtonBack = true
        customTitle = LocalizableKey.addDictionary.showLanguage
        super.setUpViews()
    }
    
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
        cell.setupCell(isDownloaded: data.isDownload, title: data.name&)
        cell.actionCell = {[weak self] (isDownloaded) in
            self?.processFile(isDownloaded: isDownloaded,item: data, indexPath: indexPath)
        }
        return cell
    }
    
    func processFile(isDownloaded: Bool,item: ItemDictionaryResponse,indexPath: IndexPath){
        if !isDownloaded {
            let link = BASE_URL + item.link_dictionary&
            ProgressView.shared.show()
            FileZipManager.shared.downLoadFile(link: link) {
                ProgressView.shared.hide()
                item.isDownload = true
                self.tableView.reloadData()
                RealmDBManager.share.addObject(value: item)
            }
        } else {
            ProgressView.shared.show()
            RealmDBManager.share.removeAllObject(type: WordEntity.self)
            RealmDBManager.share.removeAllObject(type: WordExplainEntity.self)
            RealmDBManager.share.removeObject(type: ItemDictionaryResponse.self,value: item.id)
            let newItem = ItemDictionaryResponse(id: item.id, name: item.name, link_dictionary: item.link_dictionary, isDownload: false)
            self.listData[indexPath.row] = newItem
            self.tableView.reloadData()
            ProgressView.shared.hide()
        }
    }
}

extension MoreDictionaryViewController : MoreDictionaryViewProtocol {
    func reloadDictionary(data: [ItemDictionaryResponse]){
        initLoadData(data: data)
    }
}

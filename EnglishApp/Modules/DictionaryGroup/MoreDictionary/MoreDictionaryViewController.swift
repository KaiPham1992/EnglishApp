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

class MoreDictionaryViewController: BaseViewController, MoreDictionaryViewProtocol {
    @IBOutlet weak var tbvDictionary: UITableView!
    
	var presenter: MoreDictionaryPresenterProtocol?

    override func setUpViews() {
        super.setUpViews()
        tbvDictionary.registerXibFile(MoreDictionaryCell.self)
        tbvDictionary.dataSource = self
        tbvDictionary.delegate = self
        print(Realm.Configuration.defaultConfiguration.fileURL)
    }
    
    override func setUpNavigation() {
        super.setUpNavigation()
        addBackToNavigation()
        setTitleNavigation(title: LocalizableKey.addDictionary.showLanguage)
    }
}

extension MoreDictionaryViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueTableCell(MoreDictionaryCell.self)
        if indexPath.row < 2 {
            cell.setupCell(isDownloaded: false, title: self.presenter?.getDictionaryForIndex(indexPath: indexPath) ?? "")
        } else {
            cell.setupCell(isDownloaded: true, title: self.presenter?.getDictionaryForIndex(indexPath: indexPath) ?? "")
        }
        return cell
    }
}

extension MoreDictionaryViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            ProgressView.shared.show()
            SQLHelper.shared.convertSQLiteToRealmWordEntity(appendingPathComponent: "sqliteWord.db",complete: {
                ProgressView.shared.hide()
            })
            
        }
        if indexPath.row == 1 {
            ProgressView.shared.show()
            SQLHelper.shared.convertSQLiteToRealmWordExplainEntity(appendingPathComponent: "sqliteWordExplain.db",complete: {
                ProgressView.shared.hide()
            })
        }
    }
}

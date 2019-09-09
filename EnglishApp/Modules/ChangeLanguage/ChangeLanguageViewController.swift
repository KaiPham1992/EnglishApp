//
//  ChangeLanguageViewController.swift
//  EnglishApp
//
//  Created Kai Pham on 6/2/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class ChangeLanguageViewController: BaseViewController, ChangeLanguageViewProtocol {

	var presenter: ChangeLanguagePresenterProtocol?
    @IBOutlet weak var tbLanguage: UITableView!
    
    var listLanguage = [LanguageEntity]() {
        didSet {
            tbLanguage.reloadData()
        }
    }
    
    override func setUpNavigation() {
        super.setUpNavigation()
        addBackToNavigation()
        setTitleNavigation(title: LocalizableKey.changeLanguage.showLanguage)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        tabBarController?.tabBar.isHidden = false
    }

	override func viewDidLoad() {
        super.viewDidLoad()
        configureTable()
        
        listLanguage = LanguageEntity.toArray()
        
        if LanguageHelper.currentAppleLanguage() == "en" {
            listLanguage[1].isSelected = true
        } else {
            listLanguage[0].isSelected = true
        }
    }

}


extension ChangeLanguageViewController: UITableViewDelegate, UITableViewDataSource {
    func configureTable() {
        tbLanguage.delegate = self
        tbLanguage.dataSource = self
        tbLanguage.registerXibFile(ChangeLanguageCell.self)
        tbLanguage.separatorStyle = .none
        
        tbLanguage.estimatedRowHeight = 55
        tbLanguage.rowHeight = UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(ChangeLanguageCell.self, for: indexPath)
        cell.language = self.listLanguage[indexPath.item]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listLanguage.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        listLanguage.forEach { language in
            language.isSelected = false
        }
        if indexPath.item == 0 {
            listLanguage[0].isSelected = true
            UserDefaultHelper.shared.appLanguage = LanguageType.vietname.rawValue
            LanguageHelper.setAppleLAnguageTo(lang: LanguageType.vietname)
        } else {
            listLanguage[1].isSelected = true
            UserDefaultHelper.shared.appLanguage = LanguageType.english.rawValue
            LanguageHelper.setAppleLAnguageTo(lang: LanguageType.english)
        }
        
        tbLanguage.reloadData()
        self.viewDidLoad()
        
        //-- change langguage for tabbar
        NotificationCenter.default.post(name: Notification.Name(rawValue: "Refresh"), object: nil)
    }
}

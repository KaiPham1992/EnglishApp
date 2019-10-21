//
//  MenuViewController.swift
//  EnglishApp
//
//  Created Kai Pham on 5/9/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

protocol MenuViewControllerDelegate: class {
    func controllerSelected(itemSelected: MenuItem)
}


class MenuViewController: UIViewController, MenuViewProtocol {
    @IBOutlet weak var tbMenu: UITableView!
    @IBOutlet weak var lbVersion: UILabel!
    @IBOutlet weak var header: HeaderUserView!

	var presenter: MenuPresenterProtocol?
    weak var delegate: MenuProtocol?
    weak var delegateController: MenuViewControllerDelegate?
    
    var listMenuItem = [MenuItem]() {
        didSet {
            tbMenu.reloadData()
        }
    }

	override func viewDidLoad() {
        super.viewDidLoad()
        configureTable()
        listMenuItem = MenuItem.toArray()
        setVersion()
        header.callbackGotoProfile = { [weak self] in
            self?.delegateController?.controllerSelected(itemSelected: MenuItem(imgIcon: AppImage.imgInfo, title: LocalizableKey.MenuInfo.showLanguage))
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        header.user = UserDefaultHelper.shared.loginUserInfo
        
        self.listMenuItem.forEach { item in
            item.isSelected = false
        }
        listMenuItem = MenuItem.toArray()
        tbMenu.reloadData()
    }
    
    private func setVersion() {
        if let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            lbVersion.text = "Version \(appVersion)"
        }
    }

}

extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    func configureTable() {
        tbMenu.delegate = self
        tbMenu.dataSource = self
        tbMenu.registerXibFile(MenuCell.self)
        tbMenu.separatorStyle = .none
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(MenuCell.self, for: indexPath)
        cell.menuItem = self.listMenuItem[indexPath.item]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listMenuItem.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let itemSelected = self.listMenuItem[indexPath.item]
        self.listMenuItem.forEach { item in
            item.isSelected = false
        }
        
        itemSelected.isSelected = true
        pushViewController(itemSelected: itemSelected)
        
        tbMenu.reloadData()
    }
    
    func pushViewController(itemSelected: MenuItem) {
        delegateController?.controllerSelected(itemSelected: itemSelected)
    }
    
}


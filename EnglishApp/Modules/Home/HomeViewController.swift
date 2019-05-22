//
//  HomeViewController.swift
//  EnglishApp
//
//  Created Kai Pham on 5/9/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class HomeViewController: BaseViewController, HomeViewProtocol {
    @IBOutlet weak var tbHome: UITableView!
    var presenter: HomePresenterProtocol?
    
    var listMenuItem = [MenuItem]() {
        didSet {
            tbHome.reloadData()
        }
    }
    
    let header: HeaderUserView = {
        let header = HeaderUserView()
        
        return header
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTable()
    }
    
    override func setUpViews() {
        super.setUpViews()
        
    }
    
    override func setUpNavigation() {
        super.setUpNavigation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addHeaderHome()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeHeaderHome()
    }
    
    func addHeaderHome() {
        guard let nav = self.navigationController?.navigationBar else { return }
        nav.addSubview(header)
        header.anchor(widthConstant: 240, heightConstant: 42)
        header.centerSuperview()
        //---
        
        addButtonToNavigation(image: AppImage.imgMenu, style: .left, action: #selector(btnMenuTapped))
        addButtonToNavigation(image: AppImage.imgNotification, style: .right, action: #selector(btnNotificationTapped))
    }
    
    func removeHeaderHome() {
        header.removeFromSuperview()
    }
    
    @objc func btnNotificationTapped() {
        PopUpHelper.shared.showLeaveHomeWork(completionNo: {
            print("No")
        }) {
            print("yes")
        }
    }
    
    @objc func btnMenuTapped() {
        showHideMenu()
    }
    
    func showHideMenu() {
        if let containerController = navigationController?.parent as? SideMenuViewController {
            containerController.toggleLeftPanel()
        }
    }
}


extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func configureTable() {
        tbHome.delegate = self
        tbHome.dataSource = self
        tbHome.registerXibFile(HomeActionCell.self)
        tbHome.registerXibFile(HomeHeaderCell.self)
        tbHome.registerXibFile(HomeRecentlyCell.self)
        tbHome.registerXibFile(HomeTitleCell.self)
        tbHome.separatorStyle = .none
        
        tbHome.estimatedRowHeight = 120
        tbHome.rowHeight = UITableView.automaticDimension
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if indexPath.item == 0 {
                let cell = tableView.dequeue(HomeHeaderCell.self, for: indexPath)
                
                return cell
            } else {
                let cell = tableView.dequeue(HomeActionCell.self, for: indexPath)
                cell.delegate = self
                return cell
            }
        } else {
            if indexPath.item == 0 {
                let cell = tableView.dequeue(HomeTitleCell.self, for: indexPath)
                
                return cell
            } else {
                let cell = tableView.dequeue(HomeRecentlyCell.self, for: indexPath)
                
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        } else {
            return 11
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return indexPath.item == 0 ? 222: 150
        } else {
            return indexPath.item == 0 ? 60: UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        let itemSelected = self.listMenuItem[indexPath.item]
        //        self.listMenuItem.forEach { item in
        //            item.isSelected = false
        //        }
        //
        //        itemSelected.isSelected = true
        ////        pushViewController(itemSelected: itemSelected)
        //
        //        tbHome.reloadData()
    }
}

extension HomeViewController: HomeActionCellDelegate {
    func btnDictionaryTapped() {
        self.push(controller: DictionaryRouter.createModule())
    }
    
    func btnStoreTapped() {
        self.push(controller: StoreViewController())
    }
    
    func btnMissionTapped() {
        self.push(controller: DailyMissionRouter.createModule())
    }
    
    func btnFindWorkTapped() {
        
    }
    
    
}

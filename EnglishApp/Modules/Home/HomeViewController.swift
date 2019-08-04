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
protocol HomeViewControllerDelegate: class {
    func showLefMenuTapped()
}

class HomeViewController: BaseViewController {
    @IBOutlet weak var tbHome: UITableView!
    
    var presenter: HomePresenterProtocol?
    var vcMenu:  MenuViewController!
    
    lazy var btnOver: UIButton = {
       let btn = UIButton()
        btn.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        btn.addTarget(self, action: #selector(hideMenu), for: .touchUpInside)
        return btn
    }()
    
    weak var delegate: HomeViewControllerDelegate?
    
    var listMenuItem = [MenuItem]() {
        didSet {
            tbHome.reloadData()
        }
    }
    
    let header: HeaderUserView = {
        let header = HeaderUserView()
        
        return header
    }()
    
    var listActivities = [Acitvity]() {
        didSet {
            tbHome.reloadData()
        }
    }
    
    var listTopThree = [UserEntity](){
        didSet {
            tbHome.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTable()
        presenter?.getHomeRecently()
        presenter?.getTopThree()
    }
    
    override func setUpViews() {
        super.setUpViews()
        vcMenu = MenuRouter.createModule()
        
        AppRouter.shared.rootNavigation = self.navigationController
        NotificationCenter.default.removeObserver(self)
        NotificationCenter.default.addObserver(self, selector: #selector(hideMenu), name: NSNotification.Name.init("HideMenu"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(testEntranceComplete), name: NSNotification.Name.init("TestEntranceComplete"), object: nil)
        
    }
    
    @objc func testEntranceComplete(){
        self.hideTestEntrance()
        PopUpHelper.shared.showError(message: "\(LocalizableKey.doneInputTest.showLanguage)") {
            
        }
        
    }
    
    override func setUpNavigation() {
        super.setUpNavigation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        setColorStatusBar()
        addHeaderHome()
        countNotification()
        // -- re init cell after change language
        reInitCell()
    }
    
    func reInitCell() {
        //-- action cell
        if let actionCell = self.tbHome.cellForRow(at: IndexPath(item: 1, section: 0)) as? HomeActionCell {
            actionCell.awakeFromNib()
        }
        //-- title recently cell
        if let titleCell = self.tbHome.cellForRow(at: IndexPath(item: 0, section: 1)) as? HomeTitleCell {
            titleCell.awakeFromNib()
        }
    }
    
    func countNotification() {
         self.addButtonNotificationNavigation(count: 0, action: #selector(self.btnNotificationTapped))
        Provider.shared.notificationAPIService.getNotification(offset: 0, success: { parentNotification in
            guard let total = parentNotification?.totalUnread else { return }
            UIApplication.shared.applicationIconBadgeNumber = total
            
            self.addButtonNotificationNavigation(count: total, action: #selector(self.btnNotificationTapped))
        }) { _ in
            
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeHeaderHome()
    }
    
    func addHeaderHome() {
        guard let nav = self.navigationController?.navigationBar else { return }
        nav.addSubview(header)
        header.anchor(widthConstant: 260, heightConstant: 42)
        header.centerSuperview()
        header.user = UserDefaultHelper.shared.loginUserInfo
        //---
        
        addButtonToNavigation(image: AppImage.imgMenu, style: .left, action: #selector(btnMenuTapped))
//        addButtonNotificationNavigation(count: 10, action: nil)
//        addButtonToNavigation(image: AppImage.imgNotification, style: .right, action: #selector(btnNotificationTapped))
    }
    
    func removeHeaderHome() {
        header.removeFromSuperview()
    }
    
    @objc func btnNotificationTapped() {
        self.push(controller: NotificationListRouter.createModule())
    }
    
    @objc func btnMenuTapped() {
        showMenu()
    }
    
    func didGetActivities(activities: [Acitvity]) {
        self.listActivities = activities
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
        tbHome.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if indexPath.item == 0 {
                let cell = tableView.dequeue(HomeHeaderCell.self, for: indexPath)
                cell.btnTestBegin.addTarget(self, action: #selector(btnTestBeginTapped), for: .touchUpInside)
                if let _ = UserDefaultHelper.shared.loginUserInfo?.is_entrance_test {
                    cell.isTestedEnstrane = true
                } else {
                    cell.isTestedEnstrane = false
                }
                print(self.listTopThree.count)
                cell.topThreeView.listTopThree = self.listTopThree
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
                cell.actity = self.listActivities[indexPath.item - 1]
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2//self.listTopThree.count
        } else {
            if self.listActivities.count == 0 {
                return 0
            } else {
                return self.listActivities.count + 1
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return indexPath.item == 0 ? UITableView.automaticDimension : 150
        } else {
            return indexPath.item == 0 ? 60: UITableView.automaticDimension
        }
    }
    
    @objc func btnTestBeginTapped() {
        let vc = NameExerciseRouter.createModule()
        vc.exerciseDelegate = self
        self.push(controller: vc)
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
extension HomeViewController : ExerciseDelegate {
    func confirmOutTestEntrance() {
        self.hideTestEntrance()
    }
    
    func hideTestEntrance(){
        if let cell = tbHome.cellForRow(at: IndexPath(row: 0, section: 0)) as? HomeHeaderCell{
            cell.isTestedEnstrane = true
            tbHome.beginUpdates()
            tbHome.endUpdates()
        }
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
        self.push(controller: FindRouter.createModule())
    }
    
}

extension HomeViewController: MenuViewControllerDelegate {
    func controllerSelected(itemSelected: MenuItem) {
        
        guard let itemIcon = itemSelected.imgIcon else { return }
        switch itemIcon {
        case AppImage.imgInfo:
            self.hideMenu()
            AppRouter.shared.pushTo(viewController: ProfileRouter.createModule())
            
            
        case AppImage.imgQA:
            self.hideMenu()
            AppRouter.shared.pushTo(viewController: QARouter.createModule())
            
        case AppImage.imgChangePass:
            self.hideMenu()
            AppRouter.shared.pushTo(viewController: ChangePasswordRouter.createModule())
            
        case AppImage.imgLanguage:
            self.hideMenu()
            AppRouter.shared.pushTo(viewController: ChangeLanguageRouter.createModule())
        case AppImage.imgSaved:
            self.hideMenu()
            AppRouter.shared.pushTo(viewController: SaveDictionaryRouter.createModule())
        case AppImage.imgTop:
            self.hideMenu()
            AppRouter.shared.pushTo(viewController: BXHRouter.createModule())
        case AppImage.imgHistoryCheck:
            self.hideMenu()
            AppRouter.shared.pushTo(viewController: HistoryExerciseRouter.createModule())
            
        case AppImage.imgPrivacy:
            self.hideMenu()
            AppRouter.shared.pushTo(viewController: WebViewController.initFromNib())
        case AppImage.imgLogout:
            PopUpHelper.shared.showLogout(completionNo: {
                self.logout()
            }) {
                
            }
        default:
            break
        }
    }
    
    func showMenu() {
        guard let window = UIApplication.shared.keyWindow else { return }
        window.addSubview(btnOver)
        btnOver.anchor(window.topAnchor, left: window.leftAnchor, bottom: window.bottomAnchor, right: window.rightAnchor, topConstant: -40, leftConstant: 0, bottomConstant: 0, rightConstant: 0)
        
        window.addSubview(vcMenu.view)
        vcMenu.viewWillAppear(true)
        vcMenu.delegateController = self
        vcMenu.view.frame = CGRect(x: -300, y: 0, width: 300, height: window.frame.height)
        
        UIView.animate(withDuration: 0.3) {
            self.vcMenu.view.frame = CGRect(x: 0, y: 0, width: 300, height: window.frame.height)
        }
    }
    
    @objc func hideMenu() {
        self.btnOver.removeFromSuperview()
        guard let window = UIApplication.shared.keyWindow else { return }
        UIView.animate(withDuration: 0.3, animations: {
            self.vcMenu.view.frame = CGRect(x: -300, y: 0, width: 300, height: window.frame.height)
            
        }) { _ in
            self.vcMenu.view.removeFromSuperview()
            
        }
        
        
    }
    
    func logout() {
        ProgressView.shared.show()
        Provider.shared.userAPIService.logout(success: { (_) in
            ProgressView.shared.hide()
            UserDefaultHelper.shared.clearUser()
            AppRouter.shared.openLogin()
        }) { (error) in
            ProgressView.shared.hide()
        }
    }
}
extension HomeViewController: HomeViewProtocol{
    func didGetTopThree(listTopThree: [UserEntity]) {
        self.listTopThree = listTopThree
    }
    
    func didGetTopThree(userInfo: UserEntity) {
    }
    
    func didGetTopThree(error: Error) {
        print(error.localizedDescription)
    }
}

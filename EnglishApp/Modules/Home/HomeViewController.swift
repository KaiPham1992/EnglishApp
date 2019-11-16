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
    
    weak var delegate: HomeViewControllerDelegate?
    
    var presenter: HomePresenterProtocol?
    var vcMenu:  MenuViewController!
    let frefresh = UIRefreshControl()
    var offset: Int = 0
    var isLoadmore = true
    var showProgressView = true
    var isCallViewDidload = false
    
    lazy var btnOver: UIButton = {
       let btn = UIButton()
        btn.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        btn.addTarget(self, action: #selector(hideMenu), for: .touchUpInside)
        return btn
    }()
    
    let header: HeaderUserView = {
        let header = HeaderUserView()
        return header
    }()
    
    var listActivities = [Acitvity]() {
        didSet {
            DispatchQueue.main.async {
                self.tbHome.reloadData()
            }
        }
    }
    
    var topThree = [UserEntity](){
        didSet {
            DispatchQueue.main.async {
                self.tbHome.reloadData()
            }
        }
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tbHome.tableFooterView = UIView()
        self.tbHome.tableFooterView?.isHidden = true
        setColorStatusBar()
        self.addHeaderHome()
        if !(UserDefaultHelper.shared.loginUserInfo?.email == emailDefault ||  (UserDefaultHelper.shared.loginUserInfo?.email == nil  && UserDefaultHelper.shared.loginUserInfo?.socialType == "normal")) && isCallViewDidload {
            self.countNotification()
            self.getProfile()
            self.getHomeSummary()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTable()
        if UserDefaultHelper.shared.loginUserInfo?.email == emailDefault ||  (UserDefaultHelper.shared.loginUserInfo?.email == nil  && (UserDefaultHelper.shared.loginUserInfo?.socialType == "normal" || UserDefaultHelper.shared.loginUserInfo?.socialType == nil)){
            self.loginUserDefault {
                PaymentHelper.shared.fetchAvailableProducts()
                self.getHomeRecently()
                self.countNotification()
                self.getHomeSummary()
                self.isCallViewDidload = true
            }
        } else {
            PaymentHelper.shared.fetchAvailableProducts()
            self.countNotification()
            self.getProfile()
            self.getHomeSummary()
            self.getHomeRecently()
            self.isCallViewDidload = true
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeHeaderHome()
    }
    
    func getHomeRecently() {
        if self.offset == 0 && showProgressView {
            ProgressView.shared.show()
        }
        presenter?.getHomeRecently(offset: self.offset)
    }
    
    func getHomeSummary() {
        presenter?.getHomeSummary()
    }
    
    func getProfile() {
        presenter?.getProfile()
    }
    
    override func setUpViews() {
        super.setUpViews()
        vcMenu = MenuRouter.createModule()
        AppRouter.shared.rootNavigation = self.navigationController
        NotificationCenter.default.removeObserver(self)
        NotificationCenter.default.addObserver(self, selector: #selector(hideMenu), name: NSNotification.Name.init("HideMenu"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(testEntranceComplete), name: NSNotification.Name.init("TestEntranceComplete"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateAvatar), name: NSNotification.Name.init("UpdateAvatar"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateProfile), name: NSNotification.Name.init("UpdateProfile"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(suggestionQuestion), name: NSNotification.Name.init("SuggestionQuestion"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(changeLanguage), name: NSNotification.Name.init("ChangeLanguage"), object: nil)
    }
    
    // MARK: Reset cell after change language
    @objc func changeLanguage() {
        if let homeHeaderCell = self.tbHome.cellForRow(at: IndexPath(item: 0, section: 0)) as? HomeHeaderCell {
            homeHeaderCell.awakeFromNib()
        }
        if let noDataCell = self.tbHome.cellForRow(at: IndexPath(row: 0, section: 2)) as? HomeNoResultCell {
            noDataCell.awakeFromNib()
        }
        if let actionCell = self.tbHome.cellForRow(at: IndexPath(item: 1, section: 0)) as? HomeActionCell {
            actionCell.awakeFromNib()
        }
        if let titleCell = self.tbHome.cellForRow(at: IndexPath(item: 0, section: 1)) as? HomeTitleCell {
            titleCell.awakeFromNib()
        }
        resetData()
    }
    
    // MARK: Refresh all data
    func resetData() {
        self.offset = 0
        self.isLoadmore = true
        self.showProgressView = false
        self.listActivities = []
        self.topThree = []
        getHomeRecently()
        getHomeSummary()
    }
    
    @objc func suggestionQuestion(notification: Notification) {
        if let isDiamond = notification.userInfo?["isDiamond"] as? Bool, let user = UserDefaultHelper.shared.loginUserInfo {
            if isDiamond {
                let diamond = user.amountDiamond ?? 0
                user.amountDiamond = diamond - 10
            } else {
                let honey = user.amountHoney ?? 0
                user.amountHoney = honey - 5
            }
            header.user = user
        }
    }
    
    @objc func testEntranceComplete(notification: Notification){
        self.hideTestEntrance()
        if let isOut = notification.userInfo?["isOut"] as? Bool, !isOut {
            PopUpHelper.shared.showReward(message: LocalizableKey.doneInputTest.showLanguage) {
                
            }
        }
    }
    
    @objc func updateProfile() {
        resetData()
    }
    
    @objc func updateAvatar() {
        resetData()
    }
    
    override func setUpNavigation() {
        super.setUpNavigation()
        setTitleNavigation(title: "")
    }
    
    
    
    private func loginUserDefault(complete : @escaping (() -> ())) {
        Provider.shared.userAPIService.login(email: emailDefault, password: passwordDefault.sha256(), success: { (user) in
            guard let user = user else { return }
            UserDefaultHelper.shared.saveUser(user: user)
            UserDefaultHelper.shared.userToken = user.jwt&
            complete()
        }) { (error) in }
    }
    
    func countNotification() {
        if UserDefaultHelper.shared.loginUserInfo?.email == emailDefault ||  (UserDefaultHelper.shared.loginUserInfo?.email == nil  && UserDefaultHelper.shared.loginUserInfo?.socialType == "normal") { return }
        self.addButtonNotificationNavigation(count: 0, action: #selector(self.btnNotificationTapped))
        Provider.shared.notificationAPIService.getNotification(offset: 0, success: { parentNotification in
            guard let total = parentNotification?.totalUnread else { return }
            UIApplication.shared.applicationIconBadgeNumber = total
            self.addButtonNotificationNavigation(count: total, action: #selector(self.btnNotificationTapped))
        }) { _ in }
    }
    
    func addHeaderHome() {
        guard let nav = self.navigationController?.navigationBar else { return }
        nav.addSubview(header)
        header.anchor(widthConstant: 220, heightConstant: 42)
        header.callbackGotoProfile = {[unowned self] in
            if UserDefaultHelper.shared.loginUserInfo?.email == emailDefault ||  (UserDefaultHelper.shared.loginUserInfo?.email == nil  && UserDefaultHelper.shared.loginUserInfo?.socialType == "normal") {
                let vc = LoginRouter.createModule()
                vc.callBackLoginSuccessed = {[unowned self] in
                    if let user = UserDefaultHelper.shared.loginUserInfo {
                        self.header.user = user
                    }
                    self.countNotification()
                }
                self.present(controller: vc, animated: true)
            } else {
                let vc = ProfileRouter.createModule()
                self.pushView(vc: vc)
            }
        }
        header.centerSuperview()
        header.user = UserDefaultHelper.shared.loginUserInfo
        addButtonToNavigation(image: AppImage.imgMenu, style: .left, action: #selector(btnMenuTapped))
    }
    
    func removeHeaderHome() {
        header.removeFromSuperview()
    }
    
    @objc func btnNotificationTapped() {
        let vc = NotificationListRouter.createModule()
        vc.hidesBottomBarWhenPushed = true
        self.push(controller: vc)
    }
    
    @objc func btnMenuTapped() {
        showMenu()
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
        tbHome.registerXibFile(HomeNoResultCell.self)
        tbHome.separatorStyle = .none
        
        tbHome.estimatedRowHeight = 120
        tbHome.rowHeight = UITableView.automaticDimension
        tbHome.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
        tbHome.refreshControl = frefresh
        tbHome.refreshControl?.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    
    @objc func refreshData() {
        resetData()
        frefresh.endRefreshing()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                let cell = tableView.dequeue(HomeHeaderCell.self, for: indexPath)
                cell.btnTestBegin.addTarget(self, action: #selector(btnTestBeginTapped), for: .touchUpInside)
                if let isEntranceTest = UserDefaultHelper.shared.loginUserInfo?.is_entrance_test, isEntranceTest == "1" {
                    cell.isTestedEnstrane = true
                } else {
                    cell.isTestedEnstrane = false
                }
                cell.topThreeView.listTopThree = self.topThree
                return cell
            } else {
                let cell = tableView.dequeue(HomeActionCell.self, for: indexPath)
                cell.selectionStyle = .none
                cell.delegate = self
                return cell
            }
        case 2:
            if self.listActivities.count == 0 {
                let cell = tableView.dequeue(HomeNoResultCell.self, for: indexPath)
                cell.showNoData()
                return cell
            } else {
                let cell = tableView.dequeue(HomeRecentlyCell.self, for: indexPath)
                cell.actity = self.listActivities[indexPath.row]
                return cell
            }
        case 1:
            let cell = tableView.dequeueTableCell(HomeTitleCell.self)
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        case 1:
            return 1
        case 2:
            let row = self.listActivities.count
            if row == 0 {
                return 1
            }
            return row
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return indexPath.row == 0 ? UITableView.automaticDimension : 160
        } else {
            return UITableView.automaticDimension
        }
    }
    
    @objc func btnTestBeginTapped() {
        if UserDefaultHelper.shared.loginUserInfo?.email == emailDefault ||  (UserDefaultHelper.shared.loginUserInfo?.email == nil  && UserDefaultHelper.shared.loginUserInfo?.socialType == "normal") {
            let vc = LoginRouter.createModule()
            vc.callBackLoginSuccessed = {[unowned self] in
//                self.addHeaderHome()
                if let user = UserDefaultHelper.shared.loginUserInfo {
                    self.header.user = user
                }
                self.countNotification()
            }
            self.present(controller: vc, animated: true)
        } else {
            self.gotoTestEntrance()
        }
    }
    
    private func gotoTestEntrance(){
        let vc = NameExerciseRouter.createModule(id: "", type: .entranceExercise)
        vc.hidesBottomBarWhenPushed = true
        vc.exerciseDelegate = self
        self.push(controller: vc)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section == 2 {
            if listActivities.count - 5 == indexPath.row && isLoadmore {
                self.offset += limit
                getHomeRecently()
                let spiner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
                spiner.startAnimating()
                spiner.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 44)
                self.tbHome.tableFooterView = spiner
                self.tbHome.tableFooterView?.isHidden = false
            } else {
                self.tbHome.tableFooterView?.isHidden = true
            }
        }
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
        let vc = DictionaryRouter.createModule()
        self.pushView(vc: vc)
    }
    
    func btnStoreTapped() {
        if UserDefaultHelper.shared.loginUserInfo?.email == emailDefault ||  (UserDefaultHelper.shared.loginUserInfo?.email == nil  && UserDefaultHelper.shared.loginUserInfo?.socialType == "normal") {
            let vc = LoginRouter.createModule()
            vc.callBackLoginSuccessed = {[unowned self] in
//                self.addHeaderHome()
                if let user = UserDefaultHelper.shared.loginUserInfo {
                    self.header.user = user
                }
                self.countNotification()
            }
            let nc = UINavigationController(rootViewController: vc)
            
            self.present(controller: nc, animated: true)
        } else {
            let vc = StoreViewController()
            self.pushView(vc: vc)
        }
    }
    
    func btnMissionTapped() {
        if UserDefaultHelper.shared.loginUserInfo?.email == emailDefault ||  (UserDefaultHelper.shared.loginUserInfo?.email == nil  && UserDefaultHelper.shared.loginUserInfo?.socialType == "normal") {
            let vc = LoginRouter.createModule()
            vc.callBackLoginSuccessed = {[unowned self] in
//                self.addHeaderHome()
                if let user = UserDefaultHelper.shared.loginUserInfo {
                    self.header.user = user
                }
                self.countNotification()
            }
            self.present(controller: vc, animated: true)
        } else {
            let vc = DailyMissonRouter.createModule()
            self.pushView(vc: vc)
        }
    }
    
    func btnFindWorkTapped() {
        if UserDefaultHelper.shared.loginUserInfo?.email == emailDefault ||  (UserDefaultHelper.shared.loginUserInfo?.email == nil  && UserDefaultHelper.shared.loginUserInfo?.socialType == "normal") {
            let vc = LoginRouter.createModule()
            vc.callBackLoginSuccessed = {[unowned self] in
//                self.addHeaderHome()
                if let user = UserDefaultHelper.shared.loginUserInfo {
                    self.header.user = user
                }
                self.countNotification()
            }
            self.present(controller: vc, animated: true)
        } else {
            let vc = FindRouter.createModule()
            self.pushView(vc: vc)
        }
    }
    
    private func pushView(vc: UIViewController) {
        vc.hidesBottomBarWhenPushed = true
        self.push(controller: vc)
    }
    
}

extension HomeViewController: MenuViewControllerDelegate {
    func controllerSelected(itemSelected: MenuItem) {
        guard let itemIcon = itemSelected.imgIcon else { return }
        if itemIcon == AppImage.imgPrivacy {
            self.hideMenu()
            AppRouter.shared.pushTo(viewController: WebViewController.initFromNib())
            return
        }
        if itemIcon == AppImage.imgLanguage {
            self.hideMenu()
            AppRouter.shared.pushTo(viewController: ChangeLanguageRouter.createModule())
            return
        }
        if itemIcon == AppImage.imgTop {
            self.hideMenu()
            AppRouter.shared.pushTo(viewController: BXHRouter.createModule())
            return
        }
        if UserDefaultHelper.shared.loginUserInfo?.email == emailDefault ||  (UserDefaultHelper.shared.loginUserInfo?.email == nil  && UserDefaultHelper.shared.loginUserInfo?.socialType == "normal") {
            self.hideMenu()
            let vc = LoginRouter.createModule()
            vc.callBackLoginSuccessed = {[unowned self] in
//                self.addHeaderHome()
                if let user = UserDefaultHelper.shared.loginUserInfo {
                    self.header.user = user
                }
                self.countNotification()
            }
            self.present(controller: vc, animated: true)
        } else {
            self.userDidLogin(itemSelected: itemSelected)
        }
    }
    
    private func userDidLogin(itemSelected: MenuItem) {
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
            self.hideMenu()
            PopUpHelper.shared.showLogout(completionNo: { [unowned self] in 
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
            UserDefaultHelper.shared.clearUser()
            self.navigationItem.rightBarButtonItem = nil
            Provider.shared.userAPIService.login(email: emailDefault, password: passwordDefault.sha256(), success: { (user) in
                ProgressView.shared.hide()
                guard let user = user else { return }
                UserDefaultHelper.shared.saveUser(user: user)
                UserDefaultHelper.shared.userToken = user.jwt&
                NotificationCenter.default.post(name: NSNotification.Name.init("LogoutSuccessed"), object: nil)
                self.header.user = user
                let vc = LoginRouter.createModule()
                vc.callBackLoginSuccessed = {[unowned self] in
                    self.getProfile()
                }
                self.present(controller: vc, animated: true)
            }) { (error) in
            }
        }) { (error) in
            ProgressView.shared.hide()
        }
    }
}
extension HomeViewController: HomeViewProtocol{
    
    func didGetHomeSummary(summaryInfo: CollectionUserEntity) {
        if let topThree = summaryInfo.leader_boards {
            self.topThree = topThree
        }
        let numberCompetition = summaryInfo.count_fight_test ?? 0
        if numberCompetition > 0 {
            NotificationCenter.default.post(name: NSNotification.Name.init("RecieveCompetition"), object: nil)
        } else {
            NotificationCenter.default.post(name: NSNotification.Name.init("NoCompetition"), object: nil)
        }
    }
    
    func didGetHomeRecently(activities: [Acitvity]) {
        ProgressView.shared.hide()
        if activities.count < 20 {
            self.isLoadmore = false
        }
        self.listActivities += activities
    }
    
    func didGetProfile(user: UserEntity) {
        UserDefaultHelper.shared.saveUser(user: user)
        self.header.user = user
    }
    
    func didGetError(error: Error) {
        print(error.localizedDescription)
    }
}

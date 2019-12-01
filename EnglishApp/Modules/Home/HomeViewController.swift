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
    @IBOutlet weak var topThreeView: TopThreeView!
    @IBOutlet weak var btnEntranceTest: UIButton!
    @IBOutlet weak var lbDictionary: UILabel!
    @IBOutlet weak var lbMission: UILabel!
    @IBOutlet weak var lbMember: UILabel!
    @IBOutlet weak var lbSearch: UILabel!
    @IBOutlet weak var lbRecentTitle: UILabel!
    @IBOutlet weak var heightEntranceTest: NSLayoutConstraint!
    
    weak var delegate: HomeViewControllerDelegate?
    var presenter: HomePresenterProtocol?
    var vcMenu:  MenuViewController!
    let frefresh = UIRefreshControl()
    var offset: Int = 0
    var isLoadmore = true
    var showProgressView = true
    
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
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tbHome.tableFooterView = UIView()
        self.tbHome.tableFooterView?.isHidden = true
        setColorStatusBar()
        self.addHeaderHome()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeHeaderHome()
    }
    
    override func setUpNavigation() {
        super.setUpNavigation()
        setTitleNavigation(title: "")
    }
    
    override func setUpViews() {
        super.setUpViews()
        NotificationCenter.default.removeObserver(self)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadViewDidload), name: NSNotification.Name("InvalidToken"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(testEntranceComplete), name: NSNotification.Name.init("TestEntranceComplete"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateProfile), name: NSNotification.Name.init("UpdateProfile"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(suggestionQuestion), name: NSNotification.Name.init("SuggestionQuestion"), object: nil)
        vcMenu = MenuRouter.createModule()
        AppRouter.shared.rootNavigation = self.navigationController
        configureTable()
        topThreeView.isUserInteractionEnabled = false
        setTitleText()
        // For entrance test
        if let isEntranceTest = UserDefaultHelper.shared.loginUserInfo?.is_entrance_test, isEntranceTest == "1" {
            heightEntranceTest.constant = 0
        } else {
            heightEntranceTest.constant = 42
        }
        if UserDefaultHelper.shared.loginUserInfo == nil {
            self.reloadViewDidload()
        } else {
            getInitialData()
        }
    }
    
    private func setTitleText() {
        lbDictionary.text = LocalizableKey.homeDictionary.showLanguage
        lbMission.text = LocalizableKey.homeMission.showLanguage
        lbMember.text = LocalizableKey.homeStore.showLanguage
        lbSearch.text = LocalizableKey.homeFindWork.showLanguage
        lbRecentTitle.attributedText = NSAttributedString(string: "\(LocalizableKey.actionRecently.showLanguage)")
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
            PopUpHelper.shared.showReward(message: LocalizableKey.doneInputTest.showLanguage) {}
        }
    }
    
    func addHeaderHome() {
        guard let nav = self.navigationController?.navigationBar else { return }
        nav.addSubview(header)
        header.anchor(widthConstant: 220, heightConstant: 42)
        header.callbackGotoProfile = {[unowned self] in
            if self.notLogedIn() {
                self.openLogin()
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
    
    @objc func reloadViewDidload() {
        self.loginUserDefault {
            self.getInitialData()
            self.header.user = UserDefaultHelper.shared.loginUserInfo
        }
    }
    
    @IBAction func btnDictionaryTapped() {
        let vc = DictionaryRouter.createModule()
        self.pushView(vc: vc)
    }
    
    @IBAction func btnMissionTapped() {
        if notLogedIn() {
            openLogin()
        } else {
            let vc = DailyMissonRouter.createModule()
            self.pushView(vc: vc)
        }
    }
    
    @IBAction func btnMemberTapped() {
        if notLogedIn() {
            openLogin()
        } else {
            let vc = StoreViewController()
            self.pushView(vc: vc)
        }
    }
    
    @IBAction func btnSearchTapped() {
        if notLogedIn() {
            openLogin()
        } else {
            let vc = FindRouter.createModule()
            self.pushView(vc: vc)
        }
    }
    
    @IBAction func btnTestTapped() {
        if notLogedIn() {
            openLogin()
        } else {
            self.gotoTestEntrance()
        }
    }
    
    @IBAction func topThreeTapped() {
        pushView(vc: BXHRouter.createModule())
    }
}
//MARK: - FOR CALL API
extension HomeViewController {
    // Initial data for the first time didLoad
    func getInitialData() {
        PaymentHelper.shared.fetchAvailableProducts()
        self.getHomeRecently()
        self.countNotification()
        self.getHomeSummary()
    }
    
    // Refresh all data
    func resetData() {
        self.offset = 0
        self.isLoadmore = true
        self.showProgressView = false
        self.listActivities = []
        getHomeRecently()
        getHomeSummary()
    }
    
    private func loginUserDefault(complete : @escaping (() -> ())) {
        Provider.shared.userAPIService.login(email: emailDefault, password: passwordDefault.sha256(), success: { (user) in
            guard let user = user else { return }
            UserDefaultHelper.shared.saveUser(user: user)
            UserDefaultHelper.shared.userToken = user.jwt&
            complete()
        }) { (error) in }
    }
    
    // For notification icon
    func countNotification() {
        if notLogedIn() { return }
        self.addButtonNotificationNavigation(count: 0, action: #selector(self.btnNotificationTapped))
        Provider.shared.notificationAPIService.getNotification(offset: 0, success: { parentNotification in
            guard let total = parentNotification?.totalUnread else { return }
            UIApplication.shared.applicationIconBadgeNumber = total
            self.addButtonNotificationNavigation(count: total, action: #selector(self.btnNotificationTapped))
        }) { _ in }
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
    
    @objc func updateProfile() {
        resetData()
    }
    
    @objc func btnTestBeginTapped() {
        if notLogedIn() {
            openLogin()
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
}

// MARK: - FOR TABLE VIEW
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func configureTable() {
        tbHome.delegate = self
        tbHome.dataSource = self
        tbHome.registerXibFile(HomeRecentlyCell.self)
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.listActivities.count == 0 {
            let cell = tableView.dequeue(HomeNoResultCell.self, for: indexPath)
            cell.showNoData()
            return cell
        } else {
            let cell = tableView.dequeue(HomeRecentlyCell.self, for: indexPath)
            cell.actity = self.listActivities[indexPath.row]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numRow = self.listActivities.count
        if numRow == 0 {
            return 1
        }
        return numRow
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
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

// MARK: - EXERCISE DELEGATE
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

extension HomeViewController {

    private func pushView(vc: UIViewController) {
        vc.hidesBottomBarWhenPushed = true
        self.push(controller: vc)
    }
    
    private func notLogedIn() -> Bool {
        if UserDefaultHelper.shared.loginUserInfo?.email == emailDefault ||  (UserDefaultHelper.shared.loginUserInfo?.email == nil  && UserDefaultHelper.shared.loginUserInfo?.socialType == "normal") {
            return true
        }
        return false
    }
    
    private func openLogin() {
        let vc = LoginRouter.createModule()
        vc.callBackLoginSuccessed = {[unowned self] in
        //self.addHeaderHome()
            if let user = UserDefaultHelper.shared.loginUserInfo {
                self.header.user = user
            }
                self.countNotification()
            }
        self.present(controller: vc, animated: true)
    }
    
}

// MARK: - MENU DELEGATE
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
        if notLogedIn() {
            openLogin()
            self.hideMenu()
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

// MARK: - FOR DID GET DATA FROM API
extension HomeViewController: HomeViewProtocol{
    
    func didGetHomeSummary(summaryInfo: CollectionUserEntity) {
        if let topThree = summaryInfo.leader_boards {
            self.topThreeView.listTopThree = topThree
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

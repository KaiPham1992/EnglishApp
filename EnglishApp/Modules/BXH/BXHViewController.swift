//
//  BXHViewController.swift
//  EnglishApp
//
//  Created Kai Pham on 6/2/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class BXHViewController: BaseViewController {

    @IBOutlet weak var tbBXH: UITableView!
    @IBOutlet weak var vUser: BXHView!
    @IBOutlet weak var lbRank: UILabel!
    @IBOutlet var btnOption: [UIButton]!
    @IBOutlet weak var viewOption: UIView!
    @IBOutlet weak var vRank: UIView!
    
    var refresh = UIRefreshControl()
    
	var presenter: BXHPresenterProtocol?
    var idUser = ""
    
    let arrayRank = ["\(LocalizableKey.BRONZE.showLanguage)",
        "\(LocalizableKey.SILVER.showLanguage)",
        "\(LocalizableKey.GOLD.showLanguage)",
        "\(LocalizableKey.PLATINUM.showLanguage)",
        "\(LocalizableKey.MASTER.showLanguage)",
        "\(LocalizableKey.TOAA.showLanguage)",
        ""]
    let listParam = ["BRONZE","SILVER","GOLD",
                     "PLATINUM","MASTER","TOAA",""]
    var index = 6
    
    var quarter = ""
    var year = ""
    var rank = ""
    var listQuaters = [Int]()
    var listYears = [Int]()
    
    var listLeaderBoard = LeaderBoardEntity(){
        didSet{
            tbBXH.reloadData()
        }
    }
    
	override func viewDidLoad() {
        super.viewDidLoad()
        ProgressView.shared.show()
        presenter?.getListLeaderBoard(quarter: "", year: "", rank: "")
    }
    
    override func setUpNavigation() {
        super.setUpNavigation()
        
        calculateQuaters()
        setTitleForFilterOption()
        addBackToNavigation()
        setTitleNavigation(title: LocalizableKey.bxh.showLanguage)
        addButtonToNavigation(image: AppImage.iconFilter, style: .right, action: #selector(btnFilterTapped))
    }
    override func setUpViews() {
        super.setUpViews()
        configureTable()
        configureViewOption()
        setUpLabelRank()
        displayData(isHidden: true)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideMenu))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    func displayData(isHidden: Bool) {
        tbBXH.isHidden = isHidden
        vUser.isHidden = isHidden
        vRank.isHidden = isHidden
    }
    
    func setUpLabelRank() {
        if arrayRank[index] == "" {
            lbRank.text = LocalizableKey.all.showLanguage
        } else if arrayRank[index] == "TOAA" {
            lbRank.text = "\(LocalizableKey.TheOneAboveAll.showLanguage)"
        } else {
            lbRank.text = arrayRank[index]
        }
        
    }

    func configureViewOption() {
        let shadowSize : CGFloat = 20.0
        let shadowPath = UIBezierPath(rect: CGRect(x: -shadowSize / 2,
                                                   y: -shadowSize / 2,
                                                   width: self.viewOption.frame.size.width + shadowSize,
                                                   height: self.viewOption.frame.size.height + shadowSize))
        self.viewOption.layer.masksToBounds = false
        self.viewOption.layer.shadowColor = UIColor.gray.cgColor
        self.viewOption.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.viewOption.layer.shadowOpacity = 0.2
        self.viewOption.layer.shadowPath = shadowPath.cgPath
    }
    override func btnBackTapped() {
        self.pop()
    }
    
    @objc func btnFilterTapped() {
        UIView.transition(with: self.viewOption, duration: 0.25, options: .transitionCrossDissolve, animations: {
            self.viewOption.isHidden = !self.viewOption.isHidden
        })
    }
    
    @objc func hideMenu() {
        if self.viewOption.isHidden == false {
            btnFilterTapped()
        }
    }
    
    @IBAction func btnOptionTapped(_ sender: UIButton) {
        //-- hide menu
        hideMenu()
        
        //-- handle selection
        switch sender {
        case btnOption[0]:
            handleSelectedButton(index: 0)
        case btnOption[1]:
            handleSelectedButton(index: 1)
        case btnOption[2]:
            handleSelectedButton(index: 2)
        case btnOption[3]:
            handleSelectedButton(index: 3)
        case btnOption[4]:
            handleSelectedButton(index: 4)
        case btnOption[5]:
            handleSelectedButton(index: 5)
        default:
            break
        }
    }
    
    func handleSelectedButton(index: Int) {
        setSelectedButton(index: index)
        self.quarter = self.listQuaters[index]&
        self.year = self.listYears[index]&
        presenter?.listUser.removeAll()
        presenter?.getListLeaderBoard(quarter: "\(self.listQuaters[index])", year: "\(self.listYears[index])", rank: self.rank)
    }
    
    func setSelectedButton(index: Int) {
        for i in 0 ... 5 {
            if i == index {
                btnOption[i].backgroundColor = UIColor.lightGray
            } else {
                btnOption[i].backgroundColor = .white
            }
            
        }
    }
    
    @IBAction func btnLeftTapped() {
        index += 1
        if index > 6 {
            index = 0
        }
        setUpLabelRank()
        self.rank = listParam[index]
        handleFilter()
    }
    
    @IBAction func btnRightTapped() {
        index -= 1
        if index < 0 {
            index = 6
        }
        setUpLabelRank()
        self.rank = listParam[index]
        handleFilter()
    }
    
    func handleFilter() {
        presenter?.canLoadMore = false
        presenter?.listUser.removeAll()
        ProgressView.shared.show()
        presenter?.getListLeaderBoard(quarter: quarter, year: year, rank: self.rank)
    }
    
}
//--- set up buttons filter
extension BXHViewController {
    func calculateQuaters() {
        let date = Date()
        let month = date.month
        var quater = (month - 1) / 3 + 1
        var year = date.year
        
        // -- current quater
        self.listQuaters.append(quater)
        self.listYears.append(year)
        
        // -- 5 previous quater
        for _ in 1 ... 5 {
            var previousQuater = quater - 1
            var previousYear = year
            if previousQuater < 1 {
                previousQuater = 4
                previousYear -= 1
            }
            self.listQuaters.append(previousQuater)
            self.listYears.append(previousYear)
            
            quater = previousQuater
            year = previousYear
        }
    }
    
    func setTitleForFilterOption() {
        for index in 0 ... 5 {
            btnOption[index].setTitle("\(LocalizableKey.quater.showLanguage) \(self.listQuaters[index])/\(self.listYears[index])", for: .normal)
        }
    }
    
}

extension BXHViewController: UITableViewDelegate, UITableViewDataSource {
    func configureTable() {
        tbBXH.delegate = self
        tbBXH.dataSource = self
        tbBXH.registerXibFile(BXHCell.self)
        tbBXH.registerXibFile(BXHTop3Cell.self)
        tbBXH.separatorStyle = .none
        
        tbBXH.estimatedRowHeight = 55
        tbBXH.rowHeight = UITableView.automaticDimension
        tbBXH.refreshControl = refresh
        tbBXH.refreshControl?.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    
    @objc func refreshData() {
        presenter?.listUser.removeAll()
        presenter?.getListLeaderBoard(quarter: self.quarter, year: self.year, rank: self.rank)
        tbBXH.refreshControl?.endRefreshing()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.item == 0 {
            let cell = tableView.dequeue(BXHTop3Cell.self, for: indexPath)
            if let topThree = listLeaderBoard.boards{
                cell.viewTopThree.listTopThree = topThree
            }
            
            return cell
        }
        
        let cell = tableView.dequeue(BXHCell.self, for: indexPath)
        if let user = presenter?.listUser, user.count > 0 {
            cell.viewBXH.number = indexPath.item + 3
            cell.viewBXH.user = user[indexPath.item + 2]
            if user[indexPath.item + 2].id& == self.idUser {
                cell.viewBXH.background.backgroundColor = AppColor.yellowFBEFC1
            } else {
                cell.viewBXH.background.backgroundColor = .white
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if presenter?.listUser.count ?? 0 <= 2 {
            return 1
        }
        return (presenter?.listUser.count ?? 0) - 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.item == 0 ? 150: 78 
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if presenter?.canLoadMore == true {
            if indexPath.row >= (presenter?.listUser.count ?? 0) - 2 {
                presenter?.loadMore(quarter: quarter, year: year, rank: listParam[index])
            }
        }
    }
}
extension BXHViewController: BXHViewProtocol{
    func didGetList(listLeaderBoard: LeaderBoardEntity) {
        displayData(isHidden: false)
        hideNoData()
        self.listLeaderBoard = listLeaderBoard
        
        guard let listUser = listLeaderBoard.boards else {return}
        if let userInfo = listLeaderBoard.user, userInfo.id != nil {

            var number = 0
            for index in 0 ... (listUser.count - 1) {
                let user = listUser[index]
                if user.id?.elementsEqual(userInfo.id&) == true {
                    number = index
                    break
                }
            }
            
            self.idUser = userInfo.id&
            self.vUser.number = number + 1
            self.vUser.user = userInfo
            
        }
    }
    
    func didLoadMore() {
        tbBXH.reloadData()
    }
    
    func didGetList(error: Error) {
        print(error.localizedDescription)
        tbBXH.isHidden = true
        showNoData()
    }

}

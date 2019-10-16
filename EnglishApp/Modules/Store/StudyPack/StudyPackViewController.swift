//
//  StudyPackViewController.swift
//  EnglishApp
//
//  Created Kai Pham on 5/20/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit
import XLPagerTabStrip

class StudyPackViewController: BaseViewController, StudyPackViewProtocol {

	var presenter: StudyPackPresenterProtocol?
    let refresh = UIRefreshControl()
    
    var package = [Inventories]() {
        didSet {
            DispatchQueue.main.async {
                self.tbBeePack.reloadData()
            }
        }
    }
    
    @IBOutlet weak var tbBeePack: UITableView!
    
    var collectionProduct = ProductCollectionEntity() {
        didSet {
            DispatchQueue.main.async {
                self.tbBeePack.isHidden = false
                self.tbBeePack.reloadData()
            }
        }
    }

	override func viewDidLoad() {
        super.viewDidLoad()
        configureTable()
        presenter?.getPackage()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            self.presenter?.getProduct()
        }
        
        tbBeePack.isHidden = true
    }
    
    func exchangeGift(id: String, type: String) {
        PopUpHelper.shared.showComfirmPopUp(message: "\(LocalizableKey.exchangeGiftTitle.showLanguage)", titleYes: "\(LocalizableKey.confirm.showLanguage)", titleNo: "\(LocalizableKey.cancel.showLanguage.uppercased())") {
            self.presenter?.exchangeGift(id: id, type: type)
        }
    }
}


extension StudyPackViewController: IndicatorInfoProvider{
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: LocalizableKey.studyPack.showLanguage)
    }
}

extension StudyPackViewController: UITableViewDelegate, UITableViewDataSource {
    func configureTable() {
        tbBeePack.delegate = self
        tbBeePack.dataSource = self
        tbBeePack.registerXibFile(StudyPackCell.self)
        tbBeePack.registerXibFile(ChangeGiftCell.self)
        tbBeePack.registerXibFile(ChangeGiftTitleCell.self)
        tbBeePack.registerXibFile(PackageCell.self)
        tbBeePack.registerXibFile(HomeTitleCell.self)
        tbBeePack.registerXibFile(HomeNoResultCell.self)
        
        tbBeePack.separatorStyle = .none
        
        tbBeePack.estimatedRowHeight = 55
        tbBeePack.rowHeight = UITableView.automaticDimension
        tbBeePack.refreshControl = refresh
        tbBeePack.refreshControl?.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    
    @objc func refreshData() {
        presenter?.lisPackage.removeAll()
        self.collectionProduct = ProductCollectionEntity()
        presenter?.getPackage()
        presenter?.getProduct()
        tbBeePack.refreshControl?.endRefreshing()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 1 {
            let cell = tableView.dequeue(StudyPackCell.self, for: indexPath)
            cell.vStudyPack.delegate = self
            cell.vStudyPack.getData(listProduct: collectionProduct.groupUpgrade)
            return cell
        } else if indexPath.section == 0 {
            if indexPath.item == 0 {
                let cell = tableView.dequeue(HomeTitleCell.self, for: indexPath)
                    cell.contentView.backgroundColor = AppColor.fafafaColor
                    cell.lbTitle.text = LocalizableKey.userPackage.showLanguage
                    return cell
            } else {
                let cell = tableView.dequeue(PackageCell.self, for: indexPath)
                cell.lbTitle.text = self.package[indexPath.row - 1].name
                let date = self.package[indexPath.row - 1].expiredTime?.toString(dateFormat: AppDateFormat.hhmmddmmyyy).replacingOccurrences(of: "-", with: "/")
                cell.lbTime.text = "\(LocalizableKey.dateExpire.showLanguage)" +  date&
                cell.backgroundColor = AppColor.fafafaColor
                return cell
            }
        } else {
            if indexPath.item == 0 {
                let cell = tableView.dequeue(ChangeGiftTitleCell.self, for: indexPath)
                    return cell
            } else {
                let cell = tableView.dequeue(ChangeGiftCell.self, for: indexPath)
                cell.delegate = self
                cell.product = self.collectionProduct.groupGift[indexPath.item - 1]
                cell.btnHoney.tag = indexPath.row - 1
                cell.btnDiamond.tag = indexPath.row - 1
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row >= ((presenter?.lisPackage.count ?? 0) - 5) {
            if presenter?.canLoadMore ?? false {
                presenter?.getPackage()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return 1
        } else if section == 0 {
            return package.count == 0 ? 0 : (package.count + 1)
        } else {
            return collectionProduct.groupGift.count + 1
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 {
            return 230
        } else if indexPath.section == 0 {
            if indexPath.item == 0 {
                return 35
            } else {
                return  55
            }
        } else {
            if indexPath.item == 0 {
                return 50
            } else {
                return  150
            }
        }
    }
}

extension StudyPackViewController: StudyPackViewDelegate {
    func btnDetailTapped(index: Int) {
        self.push(controller: StudyPackDetailRouter.createModule(product: self.collectionProduct.groupUpgrade[index]))
    }
    
}

extension StudyPackViewController{
    func didSendRedeem() {
        PopUpHelper.shared.showError(message: "\(LocalizableKey.redeemSuccess.showLanguage)") {
            
        }
    }
    
    func didExchangeGift() {
        PopUpHelper.shared.showError(message: "\(LocalizableKey.exchangeGiftSucess.showLanguage)") {
            //do nothing
        }
    }
    
    func didGetError(error: APIError) {
        PopUpHelper.shared.showError(message: error.message&) {
            //do nothing
        }
    }
    
    func didGetProduct(product: ProductCollectionEntity) {
        collectionProduct = product
        UserDefaultHelper.shared.collectionProduct = product
    }
    
    func didGetPackage(package: [Inventories]) {
        self.package = package
    }
    
}

// MARK: - ChangeGiftCellDelegate
extension StudyPackViewController: ChangeGiftCellDelegate {
    
    func btnDiamondTapped(index: Int) {
        if let id = self.collectionProduct.groupGift[index].id {
        exchangeGift(id: id, type: "DIAMOND")
        print(id)
        }
    }
    
    func btnHoneyTapped(index: Int) {
        if let id = self.collectionProduct.groupGift[index].id {
        exchangeGift(id: id, type: "HONEY")
        print(id)
        }
    }
}


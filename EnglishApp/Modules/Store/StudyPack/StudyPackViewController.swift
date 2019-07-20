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

class StudyPackViewController: UIViewController, StudyPackViewProtocol {

	var presenter: StudyPackPresenterProtocol?
    @IBOutlet weak var tbBeePack: UITableView!
    @IBOutlet weak var lbCode: UILabel!
    @IBOutlet weak var tfCode: UITextField!
    @IBOutlet weak var btnSend: UIButton!
    
    var collectionProduct = ProductCollectionEntity() {
        didSet {
            tbBeePack.reloadData()
        }
    }

	override func viewDidLoad() {
        super.viewDidLoad()
        configureTable()
        setUpView()
        presenter?.getProduct()
    }
    
    func didGetProduct(product: ProductCollectionEntity) {
        collectionProduct = product
        UserDefaultHelper.shared.collectionProduct = product
    }
    
    func setUpView(){
        lbCode.text = LocalizableKey.enterCode.showLanguage
        tfCode.placeholder = LocalizableKey.enterCode.showLanguage
        btnSend.setTitle(LocalizableKey.send.showLanguage, for: .normal)
    }
    
    @IBAction func btnSendTapped(){
        if let code = tfCode.text {
            presenter?.sendRedeem(code: code)
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
        
        tbBeePack.separatorStyle = .none
        
        tbBeePack.estimatedRowHeight = 55
        tbBeePack.rowHeight = UITableView.automaticDimension
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeue(StudyPackCell.self, for: indexPath)
            cell.vStudyPack.delegate = self
            cell.vStudyPack.getData(listProduct: collectionProduct.groupUpgrade)
            return cell
        } else {
            if indexPath.item == 0 {
                let cell = tableView.dequeue(ChangeGiftTitleCell.self, for: indexPath)
                
                return cell
            } else {
                let cell = tableView.dequeue(ChangeGiftCell.self, for: indexPath)
                cell.product = self.collectionProduct.groupGift[indexPath.item - 1]
                
                return cell
            }
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return collectionProduct.groupGift.count + 1
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 250
        } else {
            return indexPath.item == 0 ? 60: 124
        }
    }
}

extension StudyPackViewController: StudyPackViewDelegate {
    func btnDetailTapped(index: Int) {
        self.push(controller: StudyPackDetailRouter.createModule(product: self.collectionProduct.groupUpgrade[index]))
    }
    
}

extension StudyPackViewController{
    func didSendRedeem(data: QAEntity) {
        //
    }
    
    func didSendRedeem(error: Error) {
        //
    }
}

//
//  BeePackViewController.swift
//  EnglishApp
//
//  Created Kai Pham on 5/20/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit
import XLPagerTabStrip

class BeePackViewController: BaseViewController, BeePackViewProtocol {

    var presenter: BeePackPresenterProtocol?
    @IBOutlet weak var tbBeePack: UITableView!
    
    var listBeePack = [ProductEntity]() {
        didSet {
            
            tbBeePack.reloadData()
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTable()
//        listBeePack = BeePackEntity.toArray()
        listBeePack = UserDefaultHelper.shared.collectionProduct.groupHoney
    }
    
}

extension BeePackViewController: IndicatorInfoProvider{
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: LocalizableKey.beePack.showLanguage)
    }
}

extension BeePackViewController: UITableViewDelegate, UITableViewDataSource {
    func configureTable() {
        tbBeePack.delegate = self
        tbBeePack.dataSource = self
        tbBeePack.registerXibFile(BeePackCell.self)
        tbBeePack.separatorStyle = .none
        
        tbBeePack.estimatedRowHeight = 55
        tbBeePack.rowHeight = UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(BeePackCell.self, for: indexPath)
//        cell.item = self.listBeePack[indexPath.item]
        cell.item = self.listBeePack[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listBeePack.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 109
    }
}

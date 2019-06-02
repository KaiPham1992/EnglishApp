//
//  RequireUpgradeContent.swift
//  EnglishApp
//
//  Created by Kai Pham on 6/2/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

class RequireUpgradeContent: BaseViewXib {
    @IBOutlet weak var lbTitle: UILabel!
    
    @IBOutlet weak var btnNo: UIButton!
    @IBOutlet weak var btnYes: UIButton!
    
     @IBOutlet weak var tbUpGrade: UITableView!
    
    var listContent = [String]() {
        didSet {
            tbUpGrade.reloadData()
        }
    }
    
    override func setUpViews() {
        super.setUpViews()
        configureTable()
        listContent = [
            "Xem tất cả các bài giảng",
            "Xem tất cả các bài giảng",
            "Xem tất cả các bài giảng",
            "Xem tất cả các bài giảng",
            "Xem tất cả các bài giảng"
        ]
    }
}


extension RequireUpgradeContent: UITableViewDelegate, UITableViewDataSource {
    func configureTable() {
        tbUpGrade.delegate = self
        tbUpGrade.dataSource = self
        tbUpGrade.registerXibFile(RequireUpgradeCell.self)
        tbUpGrade.separatorStyle = .none
        
        tbUpGrade.estimatedRowHeight = 55
        tbUpGrade.rowHeight = UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(RequireUpgradeCell.self, for: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listContent.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
}

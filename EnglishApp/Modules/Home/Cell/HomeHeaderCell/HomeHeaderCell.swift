//
//  HomeHeaderCell.swift
//  EnglishApp
//
//  Created by Kai Pham on 5/18/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

class HomeHeaderCell: BaseTableCell {
    @IBOutlet weak var btnTestBegin: UIButton!
    @IBOutlet weak var topThreeView: TopThreeView!
    var isTestedEnstrane = false {
        didSet{
            self.setTestEnstrance()
        }
    }
    @IBOutlet weak var topTestEntrance: NSLayoutConstraint!
    @IBOutlet weak var heightButtonTestEntrance: NSLayoutConstraint!
    
    @IBAction func btnBXHTapped() {
        AppRouter.shared.pushTo(viewController: BXHRouter.createModule())
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    func setTestEnstrance(){
        if isTestedEnstrane {
            topTestEntrance.constant = 0
            heightButtonTestEntrance.constant = 0
            self.contentView.layoutIfNeeded()
        } else {
            topTestEntrance.constant = 16
            heightButtonTestEntrance.constant = 40
            self.contentView.layoutIfNeeded()
        }
    }
}

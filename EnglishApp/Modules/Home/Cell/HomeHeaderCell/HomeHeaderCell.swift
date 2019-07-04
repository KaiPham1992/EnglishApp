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
    
    @IBAction func btnBXHTapped() {
        AppRouter.shared.pushTo(viewController: BXHRouter.createModule())
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
}

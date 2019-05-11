//
//  HeaderUserView.swift
//  EnglishApp
//
//  Created by Kai Pham on 5/11/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

class HeaderUserView: BaseViewXib {
    @IBOutlet weak var imgIcon: UIImageView!
    
    override func setUpViews() {
        super.setUpViews()
        
        self.backgroundColor = AppColor.yellow
        
        imgIcon.setBorder(borderWidth: 1, borderColor: .white, cornerRadius: 21)
    }
    
    
}

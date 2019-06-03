//
//  ViewShowMore.swift
//  EnglishApp
//
//  Created by vinova on 6/3/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import UIKit

class ViewShowMore: BaseViewXib{
    @IBOutlet weak var lblText: UILabel!
    @IBOutlet weak var btnClose: UIButton!
    
    override func setUpViews() {
        super.setUpViews()
    }
    
    func setupContent(content: String){
        lblText.text = content
    }
    
    
}

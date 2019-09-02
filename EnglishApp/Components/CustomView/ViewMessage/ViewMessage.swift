//
//  ViewMessage.swift
//  EnglishApp
//
//  Created by vinova on 6/3/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import UIKit

class ViewMessage: BaseViewXib{
    @IBOutlet weak var lblNumber: UILabel!
    var action : (() -> Void)?
    @IBAction func clickView(_ sender: Any) {
        action?()
    }
    @IBOutlet weak var viewNumber: UIView!
    override func setUpViews() {
        super.setUpViews()
    }
    
    func setupNumber(number: Int){
        if number > 9 {
            lblNumber.text = "9+"
        } else {
            lblNumber.text = "\(number)"
            if number == 0 {
                viewNumber.isHidden = true
            }
        }
    }
}

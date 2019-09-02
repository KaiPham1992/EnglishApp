//
//  ConfirmPopUpView.swift
//  EnglishApp
//
//  Created by vinova on 6/11/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import UIKit

class ConfirmPopUpView: BaseViewXib{
    
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var btnYes: UIButton!
    @IBOutlet weak var btnNo: UIButton!
    var actionYes :(()->())?
    var actionNo : (()->())?
    
    @IBAction func clickYes(_ sender: Any) {
        actionYes?()
    }
    
    @IBAction func clickNo(_ sender: Any) {
        actionNo?()
    }
    
    override func setUpViews() {
        super.setUpViews()
    }
    
    func setupPopUp(message: String, titleYes: String = "Yes", titleNo: String = "No"){
        lblMessage.attributedText = NSAttributedString(string: message)
        btnNo.setTitle(titleNo, for: .normal)
        btnYes.setTitle(titleYes, for: .normal)
        
    }
}

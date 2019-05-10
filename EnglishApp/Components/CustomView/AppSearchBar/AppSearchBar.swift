//
//  AppSearchBar.swift
//  Ipos
//
//  Created by Kai Pham on 5/6/19.
//  Copyright © 2019 edward. All rights reserved.
//

import UIKit

class AppSearchBar: BaseViewXib {
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var tfInput: UITextField!
    @IBOutlet weak var vContain: UIView!
    @IBOutlet weak var btnSearch: UIButton!
    
    func setTitleAndPlaceHolder(title: String? = nil, placeHolder: String? = nil) {
        if title != nil {
            self.lbTitle.text = title
        }
        
        if placeHolder != nil {
            self.tfInput.placeholder = placeHolder
        }
    }
    
    override func setUpViews() {
        super.setUpViews()
        
//        tfInput.addTarget(self, action: #selector(textFieldDidChanged), for: UIControl.Event.editingChanged)
        vContain.setBorder(borderWidth: 1, borderColor: AppColor.d5d5d5Color, cornerRadius: 5)
        
//        btnSearch.isHidden = true
    }
    
    @IBAction func btnSearchTapped() {
//        tfInput.text = ""
//        btnSearch.isHidden = true
        
        print("btn Search Tapped")
    }
    
//    @objc func textFieldDidChanged(_ textField: UITextField) {
//        if !textField.text&.isEmpty {
//            btnSearch.isHidden = false
//        } else {
//            btnSearch.isHidden = true
//        }
//    }
}

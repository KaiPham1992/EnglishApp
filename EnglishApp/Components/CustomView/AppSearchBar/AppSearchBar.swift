//
//  AppSearchBar.swift
//  Ipos
//
//  Created by Kai Pham on 5/6/19.
//  Copyright © 2019 edward. All rights reserved.
//

import UIKit

class AppSearchBar: BaseViewXib {
    @IBOutlet weak var tfInput: UITextField!
    @IBOutlet weak var vContain: UIView!
    @IBOutlet weak var btnSearch: UIButton!
    var actionSearch : ((String) -> ())?
    var changedText : ((String)->())?
    
    func setTitleAndPlaceHolder(placeHolder: String? = nil) {
        if placeHolder != nil {
            self.tfInput.placeholder = placeHolder
        }
    }
    
    override func setUpViews() {
        super.setUpViews()
        tfInput.addTarget(self, action: #selector(actionChangeText), for: UIControl.Event.editingChanged)
    }
    
    @objc func actionChangeText() {
        changedText?(tfInput.text ?? "")
    }
    
    @IBAction func btnSearchTapped() {
        actionSearch?(tfInput.text ?? "")
    }
}

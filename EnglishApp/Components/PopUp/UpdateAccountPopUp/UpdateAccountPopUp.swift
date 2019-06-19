//
//  UpdateAccountPopUp.swift
//  EnglishApp
//
//  Created by vinova on 5/29/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import UIKit

class UpdateAccountPopup: BasePopUpView {
    let view : UpdateAccountView = {
        let view = UpdateAccountView()
        view.lblTitle.text = LocalizableKey.update_account.showLanguage
        view.btnConfirm.setTitle(LocalizableKey.confirm.showLanguage, for: .normal)
        return view
    }()
    override func setupView() {
        super.setupView()
        vContent.addSubview(view)
        view.fillSuperview()
        view.btnConfirm.addTarget(self, action: #selector(clickConfirm), for: .touchUpInside)
    }
    @objc func clickConfirm(){
        hidePopUp()
        completionYes?()
    }
    
    func showPopup(confirm: CompletionClosure?){
        self.completionYes = confirm
        self.showPopUp(height: 260)
    }
    
    func showPopup(message: String, confirm: CompletionClosure?){
         view.lblTitle.text = message
        self.completionYes = confirm
        self.showPopUp(height: 260)
    }
}

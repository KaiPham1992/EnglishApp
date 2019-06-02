//
//  RequireUpgradePopUp.swift
//  EnglishApp
//
//  Created by Kai Pham on 6/2/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

class RequireUpgradePopUp: BasePopUpView {
    
    let vYesNoContentView: RequireUpgradeContent = {
        let view = RequireUpgradeContent()
        
        return view
    }()
    
    override func setupView() {
        super.setupView()
        
        vContent.addSubview(vYesNoContentView)
        vYesNoContentView.fillSuperview()
        
        vYesNoContentView.btnYes.setTitle(LocalizableKey.btnUpGrade.showLanguage.uppercased(), for: .normal)
        vYesNoContentView.btnNo.setTitle(LocalizableKey.cancel.showLanguage.uppercased(), for: .normal)
        
        vYesNoContentView.btnNo.addTarget(self, action: #selector(btnNoTapped), for: .touchUpInside)
        vYesNoContentView.btnYes.addTarget(self, action: #selector(btnYesTapped), for: .touchUpInside)
    }
    
    func showPopUp(completionNo: CompletionClosure?, completionYes: CompletionClosure?) {
        vYesNoContentView.lbTitle.text = LocalizableKey.requireUpGrade.showLanguage
        self.completionNo = completionNo
        self.completionYes = completionYes
        
        super.showPopUp(height: 288)
    }
    
    @objc func btnNoTapped() {
        hidePopUp()
        completionNo?()
    }
    
    @objc func btnYesTapped() {
        hidePopUp()
        completionYes?()
    }
}

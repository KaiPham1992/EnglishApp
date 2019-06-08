//
//  ThanksReportPopUp.swift
//  EnglishApp
//
//  Created by Kai Pham on 5/20/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

class LevelUpPopUp: BasePopUpView {
    
    let thanksReportContent: LevelUpContent = {
        let view = LevelUpContent()
        
        return view
    }()
    
    var completionPackage: CompletionClosure?
    
    override func setupView() {
        super.setupView()
        
        vContent.addSubview(thanksReportContent)
        thanksReportContent.fillSuperview()
        thanksReportContent.btnYes.addTarget(self, action: #selector(btnYesTapped), for: .touchUpInside)
        thanksReportContent.btnPackage.addTarget(self, action: #selector(btnPackageTapped), for: .touchUpInside)
    }
    
    func showPopUp(completionYes: CompletionClosure?, completionPackage: CompletionClosure?) {
        self.completionYes = completionYes
        self.completionPackage = completionPackage
        
        super.showPopUp(height: 280)
    }
    
    @objc func btnPackageTapped() {
        hidePopUp()
        completionPackage?()
    }
    
    @objc func btnYesTapped() {
        hidePopUp()
        completionYes?()
    }
}

//
//  ConfirmPopUp.swift
//  EnglishApp
//
//  Created by vinova on 6/11/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import UIKit

class ConfirmPopUp: BasePopUpView{
    
    let view: ConfirmPopUpView = {
        let view = ConfirmPopUpView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func setupView() {
        super.setupView()
        vContent.addSubview(view)
        view.fillSuperview()
        view.actionYes = {
            self.hidePopUp()
            self.completionYes?()
        }
        view.actionNo = {
            self.hidePopUp()
            self.completionNo?()
        }
    }
    
    func showPopUp(message: String,titleYes: String,titleNo: String,complete: CompletionClosure?){
        self.completionYes = complete
        view.setupPopUp(message: message, titleYes: titleYes, titleNo: titleNo)
        self.showPopUp(height: 140)
    }
    
    func showPopUp(message: String, titleYes: String, titleNo: String, height: Int = 180, complete: CompletionClosure?, cancel: CompletionClosure?){
        self.completionYes = complete
        self.completionNo = cancel
        view.setupPopUp(message: message, titleYes: titleYes, titleNo: titleNo)
        self.showPopUp(height: CGFloat(height))
    }
}

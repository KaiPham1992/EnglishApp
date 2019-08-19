//
//  UpdateFeaturePopUp.swift
//  EnglishApp
//
//  Created by vinova on 6/12/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import UIKit


class UpdateFeaturePopUp: BasePopUpView {
    let view : UpdateFeatureView = {
        let view  = UpdateFeatureView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    override func setupView() {
        super.setupView()
        vContent.addSubview(view)
        view.fillSuperview()
        view.actionUpdate = {
            self.hidePopUp()
            self.completionYes?()
        }
        
        view.actionNo = {
            self.hidePopUp()
        }
    }
    
    func showPopUp(completeUpdate: CompletionClosure?, completeCancel: CompletionClosure?){
        self.completionYes = completeUpdate
        self.completionNo = completeCancel
        self.showPopUp(height: 200)
    }
}

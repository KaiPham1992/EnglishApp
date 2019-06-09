//
//  ReportSuccessedPopUp.swift
//  EnglishApp
//
//  Created by vinova on 6/9/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation


class ReportSuccessedPopUp: BasePopUpView {
    
    let view : ReportSuccessedView = {
        let view = ReportSuccessedView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func setupView() {
        super.setupView()
        self.vContent.addSubview(view)
        view.fillSuperview()
        view.complete = {
            self.hidePopUp()
            self.completionYes?()
        }
    }
    
    func showPopUp(complete: CompletionClosure?){
        self.completionYes = complete
        self.showPopUp(height: 190)
    }
}

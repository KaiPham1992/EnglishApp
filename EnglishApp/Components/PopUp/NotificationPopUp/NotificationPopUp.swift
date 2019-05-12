//
//  NotificationPopUp.swift
//  Ipos
//
//  Created by Kai Pham on 5/6/19.
//  Copyright © 2019 edward. All rights reserved.
//

import Foundation

class NotificationPopUp: BasePopUpView {
    let vNotification: NotificationContent = {
        let view = NotificationContent()
        
        return view
    }()
    
    override func setupView() {
        super.setupView()
        
        vContent.addSubview(vNotification)
        vNotification.fillSuperview()
        vNotification.btnOk.addTarget(self, action: #selector(btnOkTapped), for: .touchUpInside)
    }
    
    @objc func btnOkTapped() {
        hidePopUp()
        self.completionYes?()
    }
    
    func showPopUp(message: String, completion: CompletionClosure?) {
        self.completionYes = completion
        vNotification.lbTitle.text = message
        super.showPopUp(height: 250)
    }
}

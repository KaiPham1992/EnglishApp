//
//  PopUpHelper.swift
//  Ipos
//
//  Created by Kai Pham on 4/19/19.
//  Copyright © 2019 edward. All rights reserved.
//

import Foundation

class PopUpHelper {
    static let shared = PopUpHelper()
    
    func showYesNo(message: String, completionNo: CompletionClosure?, completionYes: CompletionClosure?) {
        let popUp = YesNoPopUp()
        popUp.showPopUp(message: message, completionNo: completionNo, completionYes: completionYes)
    }
    
    func showLogout(completionNo: CompletionClosure?, completionYes: CompletionClosure?) {
        let popUp = YesNoPopUp()
    popUp.vYesNoContentView.btnNo.setTitle(LocalizableKey.cancel.showLanguage.uppercased(), for: .normal)
    popUp.vYesNoContentView.btnYes.setTitle(LocalizableKey.agree.showLanguage.uppercased(), for: .normal)
        
        popUp.showPopUp(message: LocalizableKey.popUpLogout.showLanguage, completionNo: completionNo, completionYes: completionYes)
    }
    
    func showNotification(message: String, completionYes: CompletionClosure?) {
        let popUp = NotificationPopUp()
        popUp.showPopUp(message: message, completion: completionYes)
    }
    
}

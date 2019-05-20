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
    
    func showCreateGroup(completionNo: CompletionClosure?, completionYes: CompletionClosure?) {
        let popUp = CreateGroupPopUp()
        popUp.showPopUp(titlePopUp: LocalizableKey.createGroup.showLanguage,
                        titleInput: LocalizableKey.nameGroup.showLanguage,
                        placeHolderInput: LocalizableKey.enterNameGroup.showLanguage,
                        titleNo: LocalizableKey.cancel.showLanguage.uppercased(),
                        titleYes: LocalizableKey.createGroup.showLanguage.uppercased(),
                        completionNo: completionNo,
                        completionYes: completionYes)
    }
    
    func showLeaveGroup(completionNo: CompletionClosure?, completionYes: CompletionClosure?) {
        let popUp = YesNoPopUp()
        popUp.vYesNoContentView.btnNo.setTitle(LocalizableKey.verifyButton.showLanguage.uppercased(), for: .normal)
        popUp.vYesNoContentView.btnYes.setTitle(LocalizableKey.cancel.showLanguage.uppercased(), for: .normal)
        
        popUp.showPopUp(message: LocalizableKey.leaveTeamPopUp.showLanguage, completionNo: completionYes, completionYes: completionNo)
    }
    
    func showReport(completionNo: CompletionClosure?, completionYes: CompletionClosure?) {
        let popUp = CreateGroupPopUp()
        popUp.showPopUp(titlePopUp: LocalizableKey.createGroup.showLanguage,
                        titleInput: LocalizableKey.nameGroup.showLanguage,
                        placeHolderInput: LocalizableKey.enterNameGroup.showLanguage,
                        titleNo: LocalizableKey.cancel.showLanguage.uppercased(),
                        titleYes: LocalizableKey.createGroup.showLanguage.uppercased(),
                        completionNo: completionNo,
                        completionYes: completionYes)
    }
    
    func showThanks(completionYes: CompletionClosure?) {
        let popUp = ThanksReportPopUp()
        popUp.showPopUp(completionYes: completionYes)
    }
    
    func showNotEnoughtBee(completionNo: CompletionClosure?, completionYes: CompletionClosure?) {
        let popUp = YesNoPopUp()
        popUp.vYesNoContentView.btnNo.setTitle(LocalizableKey.cancel.showLanguage.uppercased(), for: .normal)
        popUp.vYesNoContentView.btnYes.setTitle(LocalizableKey.addBee.showLanguage.uppercased(), for: .normal)
        
        popUp.showPopUp(message: LocalizableKey.notEnoughBee.showLanguage, completionNo: completionNo, completionYes: completionYes)
    }
    
    func showNotEnoughtDiamon(completionNo: CompletionClosure?, completionYes: CompletionClosure?) {
        let popUp = YesNoPopUp()
        popUp.vYesNoContentView.btnNo.setTitle(LocalizableKey.cancel.showLanguage.uppercased(), for: .normal)
        popUp.vYesNoContentView.btnYes.setTitle(LocalizableKey.addDiamon.showLanguage.uppercased(), for: .normal)
        
        popUp.showPopUp(message: LocalizableKey.notEnoughDiamon.showLanguage, completionNo: completionNo, completionYes: completionYes)
    }
    
    func showLeaveHomeWork(completionNo: CompletionClosure?, completionYes: CompletionClosure?) {
        let popUp = YesNoPopUp()
        popUp.vYesNoContentView.btnNo.setTitle(LocalizableKey.verifyButton.showLanguage.uppercased(), for: .normal)
        popUp.vYesNoContentView.btnYes.setTitle(LocalizableKey.cancel.showLanguage.uppercased(), for: .normal)
        
        popUp.showPopUp(message: LocalizableKey.popleaveHomeWork.showLanguage, completionNo: completionYes, completionYes: completionNo)
    }
    
}

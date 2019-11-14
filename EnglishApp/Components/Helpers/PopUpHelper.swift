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
    
    func showUpdateFeature(completeUpdate: CompletionClosure?,completeCancel: CompletionClosure?){
        let popup = UpdateFeaturePopUp()
        popup.showPopUp(completeUpdate: completeUpdate, completeCancel: completeCancel)
    }
    
    func showComfirmPopUp(message: String,titleYes: String,titleNo: String,complete: CompletionClosure?){
        let popup = ConfirmPopUp()
        popup.showPopUp(message: message, titleYes: titleYes, titleNo: titleNo, complete: complete)
    }
    
    func showComfirmPopUp(message: String, titleYes: String, titleNo: String, height: Int = 180, complete: CompletionClosure?, cancel: CompletionClosure?){
        let popup = ConfirmPopUp()
        popup.showPopUp(message: message, titleYes: titleYes, titleNo: titleNo, height: height , complete: complete, cancel: cancel)
    }
    
    func showReportSuccessed(complete: CompletionClosure?){
        let popup = ReportSuccessedPopUp()
        popup.showPopUp(complete: complete)
    }
    
   
    func showReportQuestion(cancel: CompletionClosure?,report: CompletionMessage?){
        let popup = ReportQuestionPopUp()
        popup.showPopUp(cancel: cancel, report: report)
    }

    
    func showUpdateAccount(confirm: CompletionClosure?){
        let popup = UpdateAccountPopup()
        popup.showPopup(confirm: confirm)
    }
    
    
    func showLogout(completionNo: CompletionClosure?, completionYes: CompletionClosure?) {
        let popUp = YesNoPopUp()
        
        popUp.vYesNoContentView.btnNo.setTitle(LocalizableKey.confirm.showLanguage.uppercased(), for: .normal)
        popUp.vYesNoContentView.btnYes.setTitle(LocalizableKey.cancel.showLanguage.uppercased(), for: .normal)
        
        popUp.showPopUp(message: LocalizableKey.popUpLogout.showLanguage, completionNo: completionNo, completionYes: completionYes)
    }
    
    func showCreateGroup(completionNo: CompletionClosure?, completionYes: CompletionMessage?) {
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
    
    func showReport(completionNo: CompletionClosure?, completionYes: CompletionMessage?) {
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
    
    func showNotEnoughtDiamon(completionYes: CompletionClosure?) {
        let popUp = NotificationPopUp()
        popUp.setButtonTitle(title: LocalizableKey.cancel.showLanguage.uppercased())
        
        popUp.showPopUp(message: LocalizableKey.notEnoughDiamon.showLanguage, completion: completionYes)
    }
    
    func showLeaveHomeWork(completionNo: CompletionClosure?, completionYes: CompletionClosure?) {
        let popUp = YesNoPopUp()
        popUp.vYesNoContentView.btnNo.setTitle(LocalizableKey.verifyButton.showLanguage.uppercased(), for: .normal)
        popUp.vYesNoContentView.btnYes.setTitle(LocalizableKey.cancel.showLanguage.uppercased(), for: .normal)
        
        popUp.showPopUp(message: LocalizableKey.popleaveHomeWork.showLanguage, completionNo: completionYes, completionYes: completionNo)
    }
    
    func showReward(diamond: Int, completionYes: CompletionClosure?) {
        let popUp = RewardPopUp()
        popUp.showPopup(diamond: diamond, completionYes: completionYes)
    }
    
    func showReward(message: String, completionYes: CompletionClosure?) {
        let popUp = RewardPopUp()
        popUp.showPopup(message: message, completionYes: completionYes)
    }
    
    func showLevelUp(completionYes: CompletionClosure?, completionPackage: CompletionClosure?) {
        let popUp = LevelUpPopUp()
        popUp.showPopUp(completionYes: completionYes, completionPackage: completionPackage)
    }
    
    func showChangePasswordSuccess(completionYes: CompletionClosure?) {
        let popUp = UpdateAccountPopup()
        popUp.showPopup(message: LocalizableKey.changePassswordSuccess.showLanguage, confirm: completionYes)
    }
    
    func showSignUpSuccess(completionYes: CompletionClosure?) {
        let popUp = UpdateAccountPopup()
        popUp.showPopup(message: LocalizableKey.signUpSuccess.showLanguage, confirm: completionYes)
    }
    
    func showEditProfile(completionYes: CompletionClosure?) {
        let popUp = UpdateAccountPopup()
        popUp.showPopup(message: LocalizableKey.editProfileSuccess.showLanguage, confirm: completionYes)
    }
    
    func showNoInternet(completionYes: CompletionClosure?) {
        let popUp = NotificationPopUp()
        popUp.showPopUp(message: LocalizableKey.pleaseTurnOnInternet.showLanguage, completion: completionYes)
    }
    
    func showError(message: String, completionYes: CompletionClosure?) {
        let popUp = NotificationPopUp()
        popUp.showPopUp(message: message, completion: completionYes)
    }
    
    func showErrorDidNotRemoveView(message: String, completionYes: CompletionClosure?) {
        let popUp = NotificationPopUp()
        popUp.showPopUp(message: message, completion: completionYes)
    }
    
    func sentNewPassword(completionYes: CompletionClosure?) {
        let popUp = UpdateAccountPopup()
        popUp.showPopup(message: "SENT_NEW_PASSWORD".showLanguage, confirm: completionYes)
    }
    
    func showNoAllowGifPhoto(completionYes: CompletionClosure?) {
        let popUp = NotificationPopUp()
        popUp.setButtonTitle(title: LocalizableKey.cancel.showLanguage.uppercased())
        popUp.showPopUp(message: LocalizableKey.notAllowGifPhoto.showLanguage, completion: completionYes)
    }
    
}

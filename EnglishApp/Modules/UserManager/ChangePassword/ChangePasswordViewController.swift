//
//  ChangePasswordViewController.swift
//  EnglishApp
//
//  Created Kai Pham on 5/12/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class ChangePasswordViewController: BaseViewController {
    
    var presenter: ChangePasswordPresenterProtocol?
    @IBOutlet weak var vCurrenPass: AppTextField!
    @IBOutlet weak var vNewPass: AppTextField!
    @IBOutlet weak var VReNewPass: AppTextField!
    @IBOutlet weak var btnChange: UIButton!
    @IBOutlet weak var lbError: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setUpNavigation() {
        super.setUpNavigation()
        addBackToNavigation()
    }
    
    override func setTitleUI() {
        super.setTitleUI()
       
        setTitleNavigation(title: LocalizableKey.changePasssword.showLanguage)
        vCurrenPass.setTitleAndPlaceHolder(title: LocalizableKey.currentPassword.showLanguage, placeHolder: LocalizableKey.currentPasswordLogin.showLanguage)
        vCurrenPass.tfInput.isSecureTextEntry = true
        vNewPass.tfInput.isSecureTextEntry = true
        VReNewPass.tfInput.isSecureTextEntry = true
        
        vNewPass.setTitleAndPlaceHolder(title: LocalizableKey.newPassword.showLanguage, placeHolder: LocalizableKey.enterPassword.showLanguage)
        VReNewPass.setTitleAndPlaceHolder(title: LocalizableKey.reNewPassword.showLanguage, placeHolder: LocalizableKey.enterRePassword.showLanguage)
        btnChange.setTitle(LocalizableKey.changePasssword.showLanguage.uppercased(), for: .normal)
    }
    
    @IBAction func btnChangeTapped() {
        if validateInputData() {
            presenter?.changePassword(password: self.vCurrenPass.getText().sha256(), newPassword: self.vNewPass.getText().sha256())
        }
    }
}


extension ChangePasswordViewController {
    func validateInputData() -> Bool {
        
        if self.vCurrenPass.tfInput.text == "" && self.vNewPass.tfInput.text == "" && self.VReNewPass.tfInput.text == "" {
            hideError(isHidden: false, message: LocalizableKey.emptyLoginEmailPassword.showLanguage)
            return false
        }
        
        if self.vCurrenPass.getText() == "" {
            hideError(isHidden: false, message:  LocalizableKey.pleaseEnterCurrentPassword.showLanguage)
            return false
        }
        
        if self.vCurrenPass.tfInput.text&.count < 6 {
            hideError(isHidden: false, message:  LocalizableKey.invalidLoginPassword.showLanguage)
            return false
        }
        
        if self.vNewPass.getText() == "" {
            hideError(isHidden: false, message:  LocalizableKey.pleaseEnterNewPassword.showLanguage)
            return false
        }
        
        if self.vNewPass.tfInput.text&.count < 6 {
            hideError(isHidden: false, message:  LocalizableKey.invalidLoginPassword.showLanguage)
            return false
        }
        
        if self.VReNewPass.getText() == "" {
            hideError(isHidden: false, message:  LocalizableKey.pleaseEnterRePassword.showLanguage)
            return false
        }
        
        if self.vNewPass.tfInput.text& != self.VReNewPass.tfInput.text& {
            hideError(isHidden: false, message:  LocalizableKey.passwordDifference.showLanguage)
            return false
        }
        
        hideError()
        return true
    }
    
    func hideError(isHidden: Bool = true, message: String? = nil){
        lbError.isHidden = isHidden
        lbError.text = message ?? ""
    }
}


extension ChangePasswordViewController: ChangePasswordViewProtocol {
    func didChangePassword(data: BaseResponseString?) {
        
        PopUpHelper.shared.showChangePasswordSuccess(completionYes: {
            self.pop()
        })
    }
    
    func didChangePassword(error: APIError?) {
        guard let messageError = error?.message else { return }
        hideError(isHidden: false, message: messageError&.showLanguage)
    }
    
}

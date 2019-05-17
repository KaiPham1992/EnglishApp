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
//        vCurrenPass.tfInput.isSecureTextEntry = true
        vNewPass.tfInput.isSecureTextEntry = true
        VReNewPass.tfInput.isSecureTextEntry = true
        
        vNewPass.setTitleAndPlaceHolder(title: LocalizableKey.newPassword.showLanguage, placeHolder: "********")
        VReNewPass.setTitleAndPlaceHolder(title: LocalizableKey.reNewPassword.showLanguage, placeHolder: "********")
        btnChange.setTitle(LocalizableKey.changePasssword.showLanguage.uppercased(), for: .normal)
    }
    
    @IBAction func btnChangeTapped() {
        if validateInputData() {
            
        }
    }
}


extension ChangePasswordViewController {
    func validateInputData() -> Bool {
        
        if self.vCurrenPass.tfInput.text == "" || self.vNewPass.tfInput.text == "" || self.VReNewPass.tfInput.text == "" {
            hideError(isHidden: false, message: LocalizableKey.emptyLoginEmailPassword.showLanguage)
            return false
        }
        
        if self.vCurrenPass.tfInput.text&.count < 6 || self.vNewPass.tfInput.text&.count < 6 || self.VReNewPass.tfInput.text&.count < 6 {
            hideError(isHidden: false, message:  LocalizableKey.invalidLoginPassword.showLanguage)
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
        PopUpHelper.shared.showNotification(message: LocalizableKey.changePasswordSuccess.showLanguage) {
            self.pop()
        }
    }
    
    func didChangePassword(error: APIError?) {
        guard let messageError = error?.message else { return }
        if messageError == "INVALID_CURRENT_PASSWORD" {
            hideError(isHidden: false, message: messageError&.showLanguage)
        }
    }
    
}

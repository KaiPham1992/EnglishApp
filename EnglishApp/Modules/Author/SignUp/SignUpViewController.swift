//
//  SignUpViewController.swift
//  EnglishApp
//
//  Created Kai Pham on 5/11/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class SignUpViewController: BaseViewController {
    
    var presenter: SignUpPresenterProtocol?
    @IBOutlet weak var vDisplayName: AppTextField!
    @IBOutlet weak var vEmail: AppTextField!
    @IBOutlet weak var vPassword: AppTextField!
    @IBOutlet weak var vRePassword: AppTextField!
    @IBOutlet weak var tfCaptcha: UITextField!
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var lbStatus: UILabel!
    @IBOutlet weak var imgCaptcha: UIImageView!
    
    @IBOutlet weak var heightError: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.getCaptcha()
        
    }
    
    
    override func setTitleUI() {
        self.hideNavigation()
        setColorStatusBar(color: AppColor.yellowLogin)
        vDisplayName.setTitleAndPlaceHolder(title: LocalizableKey.DisplayName.showLanguage, placeHolder: LocalizableKey.enterDisplayName.showLanguage)
        vEmail.setTitleAndPlaceHolder(title: LocalizableKey.LoginEmail.showLanguage, placeHolder: LocalizableKey.LoginEmailPlaceHolder.showLanguage)
        
        vPassword.setTitleAndPlaceHolder(title: LocalizableKey.LoginPassword.showLanguage, placeHolder: LocalizableKey.enterPassword.showLanguage)
        vRePassword.setTitleAndPlaceHolder(title: LocalizableKey.reNewPassword.showLanguage, placeHolder: LocalizableKey.enterRePassword.showLanguage)
        btnSignUp.setTitle(LocalizableKey.LoginButtonSignUp.showLanguage, for: .normal)
        vPassword.tfInput.isSecureTextEntry = true
        vRePassword.tfInput.isSecureTextEntry = true
        
        tfCaptcha.placeholder = LocalizableKey.enterCaptcha.showLanguage
    }
    
    @IBAction func btnBackBlackTapped() {
        self.pop()
    }
    
    @IBAction func btnSignUpTapped() {
        dismissKeyBoard()
        heightError.constant = 0
        if validateInputData() {
            let param = SignUpParam(email: vEmail.getText(), password: vPassword.getText(), captcha: tfCaptcha.text&, displayName: vDisplayName.getText())
            
            presenter?.signUp(param: param)
        }
    }
    
    @IBAction func btnReloadCaptcha() {
        dismissKeyBoard()
        presenter?.getCaptcha()
    }
}

extension SignUpViewController {
    func validateInputData() -> Bool {
        if self.vDisplayName.tfInput.text == "" && self.vEmail.tfInput.text == "" && self.vPassword.tfInput.text == "" && self.vRePassword.tfInput.text == "" && self.tfCaptcha.text == "" {
            hideError(isHidden: false, message: LocalizableKey.emptyLoginEmailPassword.showLanguage)
            return false
        }

        if self.vDisplayName.tfInput.text == "" {
            hideError(isHidden: false, message: LocalizableKey.pleaseEnterDisplayName.showLanguage)
            return false
        }

        if self.vEmail.tfInput.text == "" {
            hideError(isHidden: false, message: LocalizableKey.pleaseEnterEmail.showLanguage)
            return false
        }

        if let email = self.vEmail.tfInput.text, email.isValidEmail() == false {
            hideError(isHidden: false, message:  LocalizableKey.invalidLoginEmail.showLanguage)
            return false
        }

        if self.vPassword.tfInput.text == "" {
            hideError(isHidden: false, message: LocalizableKey.pleaseEnterPassword.showLanguage)
            return false
        }

        if let password = self.vPassword.tfInput.text, password.count < 6 {
            hideError(isHidden: false, message:  LocalizableKey.invalidLoginPassword.showLanguage)
            return false
        }

        if self.vRePassword.tfInput.text == "" {
            hideError(isHidden: false, message: LocalizableKey.pleaseEnterRePassword.showLanguage)
            return false
        }

        if self.vPassword.tfInput.text& != self.vRePassword.tfInput.text& {
            hideError(isHidden: false, message:  LocalizableKey.passwordDifference.showLanguage)
            return false
        }

        if self.tfCaptcha.text == "" || self.tfCaptcha.text&.contains(" ") || self.tfCaptcha.text&.hasSpecialCharacters()   {
            hideError(isHidden: false, message:  LocalizableKey.emptyCapcha.showLanguage)
            return false
        }
        hideError()
        return true
    }
    
    func hideError(isHidden: Bool = true, message: String? = nil){
        lbStatus.isHidden = isHidden
        lbStatus.text = message ?? ""
        heightError.constant = 40
    }
}


extension SignUpViewController: SignUpViewProtocol {
   
    func successCaptcha(image: UIImage) {
        imgCaptcha.image = image
    }
    
    func signUpSuccess(user: UserEntity?) {
        PopUpHelper.shared.showSignUpSuccess {
            AppRouter.shared.openHome()
        }
    }
    
    func signUpError(error: APIError) {
        presenter?.getCaptcha()
        hideError(isHidden: false, message:  error.message&.showLanguage)
    }
}

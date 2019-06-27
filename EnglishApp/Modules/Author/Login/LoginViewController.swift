//
//  LoginViewController.swift
//  EnglishApp
//
//  Created Kai Pham on 5/9/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit
import CryptoSwift
import GoogleSignIn
import FBSDKLoginKit
import FBSDKCoreKit
import SystemConfiguration

enum LoginType {
    case gmail
    case facebook
    case normal
}


class LoginViewController: BaseViewController {
    
    var presenter: LoginPresenterProtocol?
    
    @IBOutlet weak var vEmail: AppTextField!
    @IBOutlet weak var vPassword: AppTextField!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var lbFbGmail: UILabel!
    @IBOutlet weak var lbForgot: UILabel!
    @IBOutlet weak var lbRegister: UILabel!
    @IBOutlet weak var lbError: UILabel!
    @IBOutlet weak var heightError: NSLayoutConstraint!
    
    
    var loginType = LoginType.normal
    var paramLogin: Any?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setUpViews() {
        super.setUpViews()
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
    }
    
    override func setTitleUI() {
        setColorStatusBar(color: .white)
        vEmail.setTitleAndPlaceHolder(title: LocalizableKey.LoginEmail.showLanguage, placeHolder: LocalizableKey.LoginEmailPlaceHolder.showLanguage)
        
        vPassword.setTitleAndPlaceHolder(title: LocalizableKey.LoginPassword.showLanguage, placeHolder: LocalizableKey.enterPassword.showLanguage)
        vPassword.tfInput.isSecureTextEntry = true 
        
        btnLogin.setTitle(LocalizableKey.LoginButtonLogin.showLanguage.uppercased(), for: .normal)
        lbFbGmail.text = LocalizableKey.FBorGmail.showLanguage
        lbForgot.text = LocalizableKey.ForgotPass.showLanguage
        
        let attr = NSMutableAttributedString()
        let attr1 = LocalizableKey.NotYetAccount.showLanguage.toAttributedString(color: AppColor.color48_48_48, font: AppFont.fontRegular12)
        let attr2 = " \(LocalizableKey.Register.showLanguage)".toAttributedString(color: AppColor.color255_211_17, font: AppFont.fontRegular12, isUnderLine: true)
        attr.append(attr1)
        attr.append(attr2)
        lbRegister.attributedText = attr
        
        lbError.text = ""
    }
    
    override func setUpNavigation() {
        super.setUpNavigation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.hideNavigation()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.showNavigation()
    }
    
    @IBAction func btnLoginTapped() {
        heightError.constant = 0
        dismissKeyBoard()
        if validateInputData() {
            presenter?.login(email: vEmail.tfInput.text&, password: vPassword.tfInput.text&)
        }
    }
    
    @IBAction func btnForgotPassTapped() {
        self.push(controller: ForgotPasswordRouter.createModule())
    }
    
    @IBAction func btnRegisterTapped() {
        self.push(controller: SignUpRouter.createModule())
    }
    
    @IBAction func btnLoginGmail() {
        self.view.endEditing(true)
        if !Utils.isConnectedToInternet() {
            PopUpHelper.shared.showNoInternet {
            }
            return
        }
        
        GIDSignIn.sharedInstance().signOut()
        GIDSignIn.sharedInstance().signIn()
    }
    
    @IBAction func btnLoginFacebook() {
        self.view.endEditing(true)
        if !Utils.isConnectedToInternet() {
            PopUpHelper.shared.showNoInternet {
            }
            return
        }
        
        self.FBlogin()
    }
}

extension LoginViewController {
    func validateInputData() -> Bool {
        
        if self.vEmail.tfInput.text == "" && self.vPassword.tfInput.text == "" {
            hideError(isHidden: false, message: LocalizableKey.emptyLoginEmailPassword.showLanguage)
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
        hideError()
        return true
    }
    
    func hideError(isHidden: Bool = true, message: String? = nil){
        lbError.isHidden = isHidden
        lbError.text = message ?? ""
        heightError.constant = lbError.isHidden ? 0 : 40
    }
}


extension LoginViewController: LoginViewProtocol {
    func didLogin(user: UserEntity?) {
        AppRouter.shared.openHome()
    }
    
    func didError(error: APIError?) {
        guard let message = error?.message else { return }
        UserDefaultHelper.shared.clearUser()
        hideError(isHidden: false, message:  message.showLanguage)
    }
}

//
//  EditProfileViewController.swift
//  EnglishApp
//
//  Created Kai Pham on 5/12/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class EditProfileViewController: BaseViewController {

	var presenter: EditProfilePresenterProtocol?
    @IBOutlet weak var vEmail: AppTextField!
    @IBOutlet weak var vDisplayName: AppTextField!
    @IBOutlet weak var vLocation: AppDropDown!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var lbError: UILabel!

	override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setUpNavigation() {
        super.setUpNavigation()
        addBackToNavigation()
        
        showProfile()
        getNational()
        
    }
    
    func getNational() {
        ProgressView.shared.show()
        Provider.shared.commonAPIService.getNationals(success: { nationals in
            ProgressView.shared.hide()
            self.vLocation.listItem = nationals
        }) { _ in
            ProgressView.shared.hide()
        }
    }
    
    func showProfile() {
        guard let user = UserDefaultHelper.shared.loginUserInfo else { return }
        vDisplayName.tfInput.text = user.nameShowUI
        vEmail.tfInput.text = user.email
        vLocation.tfInput.text = user.national
        
        imgAvatar.sd_setImage(with: user.urlAvatar, placeholderImage: AppImage.avatarDefault)
    }

    override func setTitleUI() {
        super.setTitleUI()
        lbError.text = ""
        vDisplayName.setTitleAndPlaceHolder(title: LocalizableKey.DisplayName.showLanguage)
        vEmail.setTitleAndPlaceHolder(title: LocalizableKey.LoginEmail.showLanguage)
        vLocation.setTitleAndPlaceHolder(title: LocalizableKey.Location.showLanguage)
        
        setTitleNavigation(title: LocalizableKey.EditProfile.showLanguage)
        btnSave.setTitle(LocalizableKey.titleSave.showLanguage, for: .normal)
        imgAvatar.setBorder(borderWidth: 4, borderColor: AppColor.yellow, cornerRadius: 50)
        vEmail.tfInput.isEnabled = false
        vEmail.tfInput.textColor = vEmail.tfInput.textColor!.withAlphaComponent(0.5)
    }
    
    @IBAction func btnSavedTapped() {
        
        if vDisplayName.getText().isEmpty {
            hideError(isHidden: false, message: LocalizableKey.enterDisplayName.showLanguage)
            return 
        }
        
        var param: UpdateProfileParam!
        if let national = self.vLocation.selectedItem as? NationalEntity {
            param = UpdateProfileParam(nationalId: Int(national.id&), fullName: vDisplayName.getText())
        } else {
            param = UpdateProfileParam(nationalId: nil, fullName: vDisplayName.getText())
        }
        presenter?.updateProfile(userInfo: param)
    }
    
    @IBAction func btnAvatarTapped() {
        SelectPhotoCanCropPopUp.shared.showCropPicker(controller: self) { image in
            guard let _iamge = image else { return }
            self.imgAvatar.image = _iamge
            self.presenter?.updateAvatar(image: _iamge)
        }
    }
    
    func hideError(isHidden: Bool = true, message: String? = nil){
        lbError.isHidden = isHidden
        lbError.text = message ?? ""
    }
}

extension EditProfileViewController: EditProfileViewProtocol {
    func didErrorUpdateProfile(error: APIError?) {
        guard let message = error?.message else { return }
        hideError(isHidden: false, message: message.showLanguage)
    }
    
    func didSuccessUpdateProfile(user: UserEntity?) {
        PopUpHelper.shared.showEditProfile {
            self.pop()
        }
    }
}


extension EditProfileViewController {
    func logout() {
        ProgressView.shared.show()
        Provider.shared.userAPIService.logout(success: { (_) in
            ProgressView.shared.hide()
            UserDefaultHelper.shared.clearUser()
            AppRouter.shared.openLogin()
        }) { (error) in
            ProgressView.shared.hide()
        }
    }
}

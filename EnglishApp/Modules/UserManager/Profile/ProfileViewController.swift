//
//  ProfileViewController.swift
//  EnglishApp
//
//  Created Kai Pham on 5/12/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class ProfileViewController: BaseViewController {

	var presenter: ProfilePresenterProtocol?
    @IBOutlet weak var lbBee: UILabel!
    @IBOutlet weak var lbDiamon: UILabel!
    
    @IBOutlet weak var lbTitleBee: UILabel!
    @IBOutlet weak var lbTitleDiamon: UILabel!
    
    @IBOutlet weak var vDisplayName: AppTextField!
    @IBOutlet weak var vEmail: AppTextField!
    @IBOutlet weak var vLocation: AppTextField!
    @IBOutlet weak var imgAvatar: UIImageView!
    
    @IBOutlet weak var lbFullName: UILabel!
    @IBOutlet weak var lbLevel: UILabel!
    @IBOutlet weak var lbPoint: UILabel!

	override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.getProfile()
    }
    
    override func setUpNavigation() {
        super.setUpNavigation()
        
        hideTabbar()
        
        addBackToNavigation()
        addButtonToNavigation(image: AppImage.imgEditProfile, style: .right, action: #selector(btnEditTapped))
        
    }
    
    override func btnBackTapped() {
        showTabbar()
        self.pop()
    }
    
    @objc func btnEditTapped() {
        self.push(controller: EditProfileRouter.createModule())
    }
    
    override func setTitleUI() {
        super.setTitleUI()
        setTitleNavigation(title: LocalizableKey.TitleProfile.showLanguage)
        vDisplayName.setTitleAndPlaceHolder(title: LocalizableKey.DisplayName.showLanguage)
        vEmail.setTitleAndPlaceHolder(title: LocalizableKey.LoginEmail.showLanguage)
        vLocation.setTitleAndPlaceHolder(title: LocalizableKey.Location.showLanguage)
        
        imgAvatar.setBorder(borderWidth: 2, borderColor: AppColor.yellow, cornerRadius: 30)
        lbTitleBee.text = LocalizableKey.titleBee.showLanguage
        lbTitleDiamon.text = LocalizableKey.titleDiamon.showLanguage
        
        vDisplayName.tfInput.isEnabled = false
        vEmail.tfInput.isEnabled = false
        vLocation.tfInput.isEnabled = false
    }
    
    @IBAction func btnBeeTapped() {
        self.push(controller: HistoryBeeRouter.createModule())
    }
    
    @IBAction func btnDiamonTapped() {
        self.push(controller: HistoryBeeRouter.createModule())
    }
}

extension ProfileViewController: ProfileViewProtocol {
    func didGetProfile(user: UserEntity) {
        vDisplayName.tfInput.text = user.displayName
        vEmail.tfInput.text = user.email
        vLocation.tfInput.text = user.national
        lbFullName.text = user.fullName
        lbLevel.text = user.rankName
        lbBee.text = user.amountDiamond*.description
        lbDiamon.text = user.amountHoney*.description
        lbPoint.text = "\(user.amountPoint*.description) \(LocalizableKey.point.showLanguage)"
        imgAvatar.sd_setImage(with: user.urlAvatar, placeholderImage: AppImage.imgPlaceHolder)
        
        UserDefaultHelper.shared.saveUser(user: user)
    }
}

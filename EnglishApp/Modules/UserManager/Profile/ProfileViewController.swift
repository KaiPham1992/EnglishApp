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

class ProfileViewController: BaseViewController, ProfileViewProtocol {

	var presenter: ProfilePresenterProtocol?
    @IBOutlet weak var lbBee: UILabel!
    @IBOutlet weak var lbDiamon: UILabel!
    
    @IBOutlet weak var lbTitleBee: UILabel!
    @IBOutlet weak var lbTitleDiamon: UILabel!
    
    @IBOutlet weak var vDisplayName: AppTextField!
    @IBOutlet weak var vEmail: AppTextField!
    @IBOutlet weak var vLocation: AppTextField!
    @IBOutlet weak var vCode: AppTextField!
    @IBOutlet weak var imgAvatar: UIImageView!

	override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setUpNavigation() {
        super.setUpNavigation()
        
        addBackToNavigation()
        addButtonToNavigation(image: AppImage.imgEditProfile, style: .right, action: #selector(btnEditTapped))
        
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
        vCode.setTitleAndPlaceHolder(title: LocalizableKey.CodeNumber.showLanguage)
        imgAvatar.setBorder(borderWidth: 2, borderColor: AppColor.yellow, cornerRadius: 30)
        lbTitleBee.text = LocalizableKey.titleBee.showLanguage
        lbTitleDiamon.text = LocalizableKey.titleBee.showLanguage
    }

}

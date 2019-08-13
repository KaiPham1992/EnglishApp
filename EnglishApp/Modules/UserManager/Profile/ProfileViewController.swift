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
//    @IBOutlet weak var imgRank: UIImageView!
    
    @IBOutlet weak var lbFullName: UILabel!
    @IBOutlet weak var lbLevel: UILabel!
    @IBOutlet weak var lbPoint: UILabel!

	override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
        
//        imgAvatar.setBorder(borderWidth: 2, borderColor: AppColor.yellow, cornerRadius: 30)
//        imgRank.setBorder(borderWidth: 2, borderColor: .white, cornerRadius: 11)
        
        lbTitleBee.text = LocalizableKey.titleBee.showLanguage
        lbTitleDiamon.text = LocalizableKey.titleDiamon.showLanguage
        
        vDisplayName.tfInput.isEnabled = false
        vEmail.tfInput.isEnabled = false
        vLocation.tfInput.isEnabled = false
    }
    
    @IBAction func btnBeeTapped() {
        self.push(controller: HistoryBeeRouter.createModule(wallet_type: 3))
    }
    
    @IBAction func btnDiamonTapped() {
        self.push(controller: HistoryBeeRouter.createModule(wallet_type: 1))
    }
}

extension ProfileViewController: ProfileViewProtocol {
    func didGetProfile(user: UserEntity) {
        vDisplayName.lbPlaceHolder.text = user.nameShowUI
        vEmail.lbPlaceHolder.text = user.email
        vLocation.lbPlaceHolder.text = user.national
        lbFullName.text = user.fullName
        lbLevel.text = user.rankName
        lbBee.text = user.amountHoney*.description + " \(LocalizableKey.boxHoney.showLanguage)"
        lbDiamon.text = user.amountDiamond*.description + " \(LocalizableKey.point.showLanguage)"
        lbPoint.text = "\(user.rankPoint*.description) \(LocalizableKey.point.showLanguage)"
        imgAvatar.sd_setImage(with: user.urlRank, placeholderImage: AppImage.avatarDefault)
        
        UserDefaultHelper.shared.saveUser(user: user)
    }
}

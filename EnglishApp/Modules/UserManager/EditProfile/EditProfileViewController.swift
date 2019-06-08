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

class EditProfileViewController: BaseViewController, EditProfileViewProtocol {

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
        
        //--
        vLocation.listItem = [
            TagEntity(name: "Viet Nam 0"),
            TagEntity(name: "Viet Nam 1"),
            TagEntity(name: "Viet Nam 2")
        ]
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
        
        vEmail.tfInput.text = "ngocduong2310@gmail.com"
        vEmail.tfInput.isEnabled = false
        vEmail.tfInput.textColor = vEmail.tfInput.textColor!.withAlphaComponent(0.5)
    }
    
    @IBAction func btnSavedTapped() {
        self.push(controller: PreviewProfileRouter.createModule())
    }
}

//
//  HomeActionCell.swift
//  EnglishApp
//
//  Created by Kai Pham on 5/18/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit
protocol HomeActionCellDelegate: class {
    func btnDictionaryTapped()
    func btnStoreTapped()
    func btnMissionTapped()
    func btnFindWorkTapped()
}

class HomeActionCell: UITableViewCell {
    @IBOutlet weak var vDictionnary: ButtonHomeView!
    @IBOutlet weak var vStore: ButtonHomeView!
    @IBOutlet weak var vMission: ButtonHomeView!
    @IBOutlet weak var vFindWork: ButtonHomeView!
    
    weak var delegate: HomeActionCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        
        vDictionnary.setImageAndTitle(image: AppImage.imgDictionary, title: LocalizableKey.homeDictionary.showLanguage)
        vStore.setImageAndTitle(image: AppImage.imgStore, title: LocalizableKey.homeStore.showLanguage)
        vMission.setImageAndTitle(image: AppImage.imgMission, title: LocalizableKey.homeMission.showLanguage)
        vFindWork.setImageAndTitle(image: AppImage.imgMission, title: LocalizableKey.homeFindWork.showLanguage)
        
        vDictionnary.btnAction.tag = 2001
        vStore.btnAction.tag = 2002
        vMission.btnAction.tag = 2003
        vFindWork.btnAction.tag = 2004
        
        vDictionnary.btnAction.addTarget(self, action: #selector(btnActionTapped), for: .touchUpInside)
        vStore.btnAction.addTarget(self, action: #selector(btnActionTapped), for: .touchUpInside)
        vMission.btnAction.addTarget(self, action: #selector(btnActionTapped), for: .touchUpInside)
        vFindWork.btnAction.addTarget(self, action: #selector(btnActionTapped), for: .touchUpInside)
        
    }
    
    @objc func btnActionTapped(sender: UIButton) {
        switch sender.tag {
        case 2001:
            delegate?.btnDictionaryTapped()
        case 2002:
            delegate?.btnStoreTapped()
        case 2003:
            delegate?.btnMissionTapped()
        case 2004:
            delegate?.btnFindWorkTapped()
        default:
            break
        }
    }
}

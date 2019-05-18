//
//  HomeActionCell.swift
//  EnglishApp
//
//  Created by Kai Pham on 5/18/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

class HomeActionCell: UITableViewCell {
    @IBOutlet weak var vDictionnary: ButtonHomeView!
    @IBOutlet weak var vStore: ButtonHomeView!
    @IBOutlet weak var vMission: ButtonHomeView!
    @IBOutlet weak var vFindWork: ButtonHomeView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        vDictionnary.setImageAndTitle(image: AppImage.imgDictionary, title: LocalizableKey.homeDictionary.showLanguage)
        vStore.setImageAndTitle(image: AppImage.imgStore, title: LocalizableKey.homeStore.showLanguage)
        vMission.setImageAndTitle(image: AppImage.imgMission, title: LocalizableKey.homeMission.showLanguage)
        vFindWork.setImageAndTitle(image: AppImage.imgMission, title: LocalizableKey.homeFindWork.showLanguage)
        
    }
}

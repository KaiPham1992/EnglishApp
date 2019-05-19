//
//  ButtonHomeView.swift
//  EnglishApp
//
//  Created by Kai Pham on 5/18/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

class ButtonHomeView: BaseViewXib {
    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var btnAction: UIButton!
    override func setUpViews() {
        super.setUpViews()
    }
    
    func setImageAndTitle(image: UIImage, title: String) {
        self.imgIcon.image = image
        self.lbTitle.text = title
    }
}

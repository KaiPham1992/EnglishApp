//
//  InfoPackView.swift
//  EnglishApp
//
//  Created by Kai Pham on 5/21/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

class InfoPackView: BaseViewXib {
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var imgIcon: UIImageView!
    
    func setTitleImage(title: String, image: UIImage) {
        self.lbTitle.text = title
        self.imgIcon.image = image
    }
    
}

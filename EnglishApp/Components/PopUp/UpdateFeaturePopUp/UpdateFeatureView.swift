//
//  UpdateFeatureView.swift
//  EnglishApp
//
//  Created by vinova on 6/12/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import UIKit

class UpdateFeatureView: BaseViewXib{
    
    var actionUpdate : (()->())?
    var actionNo: (()->())?
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var vVideo: ViewFeature!
    @IBOutlet weak var vSlide: ViewFeature!
    @IBOutlet weak var vLorem: ViewFeature!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnUpdate: UIButton!
    
    @IBAction func clickCancel(_ sender: Any) {
        self.actionNo?()
    }
    
    @IBAction func clickUpdate(_ sender: Any) {
        self.actionUpdate?()
    }
    
    override func setUpViews() {
        super.setUpViews()
        vVideo.setupTitle(title: "Xem tất cả bài giảng")
        vSlide.setupTitle(title: "Xem tất cả bài giảng")
        vLorem.setupTitle(title: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.")
        btnCancel.setTitle(LocalizableKey.cancel.showLanguage.uppercased(), for: .normal)
        btnUpdate.setTitle(LocalizableKey.update.showLanguage.uppercased(), for: .normal)
    }
}

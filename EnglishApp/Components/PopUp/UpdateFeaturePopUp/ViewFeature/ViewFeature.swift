//
//  ViewFeature.swift
//  EnglishApp
//
//  Created by vinova on 6/12/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import UIKit

class ViewFeature: BaseViewXib{
    @IBOutlet weak var lblTitle: UILabel!
    
    func setupTitle(title: String){
        lblTitle.text = title
    }
    
}

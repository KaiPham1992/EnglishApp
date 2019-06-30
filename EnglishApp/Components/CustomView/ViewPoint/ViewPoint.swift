//
//  ViewPoint.swift
//  EnglishApp
//
//  Created by vinova on 5/23/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import UIKit

class ViewPoint: BaseViewXib {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblNumber: UILabel!
    
    func setupNumber(number: String){
        lblNumber.text = number
    }
    
}

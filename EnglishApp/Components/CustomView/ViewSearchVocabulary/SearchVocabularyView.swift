//
//  SearchVocabularyView.swift
//  EnglishApp
//
//  Created by vinova on 6/2/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import UIKit

class SearchVocabularyView: BaseViewXib{
    @IBOutlet weak var lblTitle: UILabel!
    override func setUpViews() {
        super.setUpViews()
    }
    
    func setTitle(title: String){
        lblTitle.text = title
    }
}

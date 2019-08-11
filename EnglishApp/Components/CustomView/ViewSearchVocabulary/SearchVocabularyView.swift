//
//  SearchVocabularyView.swift
//  EnglishApp
//
//  Created by vinova on 6/2/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import UIKit

class SearchVocabularyView: BaseViewXib {
    
    @IBOutlet weak var lblDetail: UILabel!
    @IBOutlet weak var btnVolume: UIButton!
    @IBOutlet weak var lblVolume: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnDetail: UIButton!
    var word: WordExplainEntity?
    
    @IBAction func seeDetail(_ sender: Any) {
        if let _word = word {
            actionSeeDetailWord?(_word)
        }
    }
    
    var actionSeeDetailWord : ((_ word : WordExplainEntity) -> ())?
    
    override func setUpViews() {
        super.setUpViews()
    }
    
    func setTitle(word: WordExplainEntity){
        self.word = word
        lblTitle.text = word.word
        lblDetail.text = word.explain
    }
}

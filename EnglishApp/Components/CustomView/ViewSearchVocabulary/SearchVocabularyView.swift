//
//  SearchVocabularyView.swift
//  EnglishApp
//
//  Created by vinova on 6/2/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import UIKit
import AVKit
import AVFoundation

class SearchVocabularyView: BaseViewXib {
    
    @IBOutlet weak var lblDetail: UILabel!
    @IBOutlet weak var btnVolume: UIButton!
    @IBOutlet weak var lblVolume: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnDetail: UIButton!
    
    private var player : AVPlayer?
    
    var word: WordExplainEntity?
    
    @IBAction func clickVolume(_ sender: Any) {
        if let _word = word, let url = URL(string: _word.link_audio) {
            let playerItem = AVPlayerItem(url: url)
            player = AVPlayer(playerItem: playerItem)
            player?.play()
        }
    }
    
    @IBAction func seeDetail(_ sender: Any) {
        if let _word = word {
            actionSeeDetailWord?(_word)
        }
    }
    
    var actionSeeDetailWord : ((_ word : WordExplainEntity) -> ())?
    var actionClickVolume: ((_ word : WordExplainEntity) -> ())?
    
    override func setUpViews() {
        super.setUpViews()
    }
    
    func setTitle(word: WordExplainEntity){
        if word.link_audio == "" {
            btnVolume.isHidden = true
        } else {
            btnVolume.isHidden = false
        }
        self.word = word
        lblTitle.text = word.word
        lblDetail.attributedText = word.explain.htmlToAttributedString
    }
}

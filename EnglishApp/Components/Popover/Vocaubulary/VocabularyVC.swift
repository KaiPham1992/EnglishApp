//
//  VocabularyVC.swift
//  EnglishApp
//
//  Created by Steve on 11/16/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class VocabularyVC: UIViewController {
    
    @IBOutlet weak var widthVolume: NSLayoutConstraint!
    @IBOutlet weak var lblDetail: UILabel!
    @IBOutlet weak var btnVolume: UIButton!
    @IBOutlet weak var lblVolume: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnDetail: UIButton!
    
    private var player : AVPlayer?
    
    var word: WordExplainEntity!
    
    @IBAction func clickVolume(_ sender: Any) {
        if let _word = word, let url = URL(string: _word.link_audio) {
            let playerItem = AVPlayerItem(url: url)
            player = AVPlayer(playerItem: playerItem)
            player?.play()
        }
    }
    
    @IBAction func seeDetail(_ sender: Any) {
        if let _word = word {
            self.dismiss()
            actionSeeDetailWord?(_word)
        }
    }
    
    var actionSeeDetailWord : ((_ word : WordExplainEntity) -> ())?
//    var actionClickVolume: ((_ word : WordExplainEntity) -> ())?
    
    func setTitle(word: WordExplainEntity){
        self.word = word
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnDetail.setTitle(LocalizableKey.see_detail.showLanguage, for: .normal)
        if word.link_audio == "" {
            widthVolume.constant = 0
        } else {
            widthVolume.constant = 24
        }
        lblTitle.text = word.word
        lblDetail.attributedText = word.explain.htmlToAttributedString
    }
}

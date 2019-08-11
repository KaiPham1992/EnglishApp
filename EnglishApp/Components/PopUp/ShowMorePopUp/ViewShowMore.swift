//
//  ViewShowMore.swift
//  EnglishApp
//
//  Created by vinova on 6/3/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import UIKit
import Popover



class ViewShowMore: BaseViewXib{
    
   weak var delegate: ShowMoreQuestionDelegate?
    
    let popover = Popover()
    
    @IBOutlet weak var tvText: UITextView!
    @IBOutlet weak var btnClose: UIButton!
    var text = ""
    
    override func setUpViews() {
        super.setUpViews()
        tvText.textContainerInset = UIEdgeInsets.zero
        tvText.textContainer.lineFragmentPadding = 0
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tap.numberOfTapsRequired = 2
        tvText.addGestureRecognizer(tap)
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer){
        let content = sender.view as! UITextView
        let layoutManager = content.layoutManager
        var location = sender.location(in: content)
        
        location.x -= content.contentInset.left
        location.y -= content.contentInset.top
        
        print(location.x)
        print(location.y)
        let characterIndex  = layoutManager.characterIndex(for: location, in: content.textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        if characterIndex < content.textStorage.length {
            print("Your character is at index: \(characterIndex)")
            let myRange = NSRange(location: characterIndex, length: 1)
            let subString = (content.attributedText.string as NSString).substring(with: myRange)
            print("character at index: \(subString)")
            let attributeName = "tapped" //make sure this matches the name in viewDidLoad()
            let attributeValue = content.attributedText!.attribute(NSAttributedString.Key("tapped"), at: characterIndex, effectiveRange: nil) as? String
            if let value = attributeValue {
                self.text = value
//                setupPopOver(x: sender.location(in: content).x, y: sender.location(in: content).y + AppFont.fontRegular14.lineHeight / 2, title: value)
                print("You tapped on \(attributeName) and the value is: \(value)")
            }
        }
    }
    
    func setupPopOver(x:CGFloat, y: CGFloat,word: WordExplainEntity){
        popover.removeFromSuperview()
        let point = tvText.convert(CGPoint(x: x, y: y), to: self)
        let aView = SearchVocabularyView(frame: CGRect(x: 0, y: 0, width: 200, height: 85))
//        aView.btnDetail.addTarget(self, action: #selector(clickDetail), for: .touchUpInside)
        aView.actionSeeDetailWord = {[unowned self] (word) in
            self.gotoDetailVocabulary(word: word)
        }
//        aView.setTitle(word: word)
        popover.blackOverlayColor = .clear
        popover.popoverColor = .white
        popover.addShadow(ofColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.25), opacity: 1)
        popover.layer.cornerRadius = 5
        popover.show(aView, point: point, inView: self)
    }
    
    func gotoDetailVocabulary(word: WordExplainEntity) {
        
    }
    
    @objc func clickDetail(){
        popover.removeFromSuperview()
        delegate?.showMoreDoubleText(text: self.text)
    }
    
    func setupContent(content: String){
        tvText.text = content
    }
    func setupContentAttributed(attributed: NSMutableAttributedString){
        tvText.attributedText = attributed
    }
}

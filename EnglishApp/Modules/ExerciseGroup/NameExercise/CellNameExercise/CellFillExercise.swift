//
//  CellFillExercise.swift
//  EnglishApp
//
//  Created by vinova on 6/24/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit
import Popover

class CellFillExercise: UICollectionViewCell {

    @IBOutlet weak var heightStackView: NSLayoutConstraint!
    @IBOutlet weak var stvFillQuestion: UIStackView!
    @IBOutlet weak var tvContent: UITextView!
    let popover = Popover()
    
    weak var delegate: CellExerciseDelegate?
    var attributed: NSMutableAttributedString?
    var numberLine: Int = 0
    //for competition
    var listAnswerCompetition : [SubmitAnswerEntity] = []
    //for exercise
    var listAnswer : [QuestionChoiceResultParam] = []
    
    private var listViewAnswer : [ViewFillQuestion] = []
    var indexPath: IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    func setupView(){
        tvContent.textContainerInset = UIEdgeInsets.zero
        tvContent.textContainer.lineFragmentPadding = 0
    }
    
    func setupCell(data: QuestionEntity){
        DispatchQueue.main.async {
            self.detectQuestion(text: data.content_extend&)
            self.setFillCell(numberView: data.answers?.count ?? 0)
        }
    }
    
    func detectQuestion(text: String){
        let  textArray = text.htmlToString.components(separatedBy: " ")
        let attributedText = NSMutableAttributedString()
        for word in textArray {
            let attributed = NSMutableAttributedString(string: word + " ")
            let range = NSRange(location: 0, length: word.count)
            let myCustomAttributed = [ NSAttributedString.Key.init(rawValue: "tapped"):word, NSAttributedString.Key.font : AppFont.fontRegular14] as [NSAttributedString.Key : Any]
            attributed.addAttributes(myCustomAttributed, range: range)
            attributedText.append(attributed)
        }
        self.attributed = attributedText
        self.tvContent.attributedText = attributedText
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
        tap.numberOfTapsRequired = 2
        self.tvContent.addGestureRecognizer(tap)
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
            let attributeName = "tapped"
            let attributeValue = content.attributedText!.attribute(NSAttributedString.Key("tapped"), at: characterIndex, effectiveRange: nil) as? String
            if let value = attributeValue {
                delegate?.searchVocabulary(word: value.standString(),position: CGPoint(x: sender.location(in: content).x, y: sender.location(in: content).y + AppFont.fontRegular14.lineHeight / 2),index: self.indexPath ?? IndexPath(row: 0, section: 0 ))
                print("You tapped on \(attributeName) and the value is: \(value)")
            }
        }
    }
    
    func setupPopOver(x:CGFloat, y: CGFloat,word: WordExplainEntity){
        DispatchQueue.main.async {
            self.popover.removeFromSuperview()
            let point = self.tvContent.convert(CGPoint(x: x, y: y), to: self.contentView)
            let aView = SearchVocabularyView(frame: CGRect(x: 0, y: 0, width: 200, height: 85))
//            aView.btnDetail.addTarget(self, action: #selector(self.clickDetail), for: .touchUpInside)
            aView.actionSeeDetailWord = {[weak self] (word) in
                self?.gotoDetailVocabulary(word: word)
            }
            aView.setTitle(word: word)
            self.popover.blackOverlayColor = .clear
            self.popover.popoverColor = .white
            self.popover.addShadow(ofColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.25), opacity: 1)
            self.popover.layer.cornerRadius = 5
            self.popover.show(aView, point: point, inView: self.contentView)
        }
    }
    
    func gotoDetailVocabulary(word: WordExplainEntity){
        delegate?.showDetailVocubulary(word: word)
    }
    
    func setFillCell(numberView: Int){
        if stvFillQuestion.subviews.count == 0 {
            for index in 1...numberView {
                let view = ViewFillQuestion()
                view.setupTag(tag: index)
                if listAnswer.count > 0 {
                    view.content = listAnswer[index-1].value ?? ""
                }
                if listAnswerCompetition.count > 0 {
                    view.content = listAnswerCompetition[index-1].value
                }
                self.stvFillQuestion.addArrangedSubview(view)
                self.listViewAnswer.append(view)
                view.delegate = self
            }
            self.heightStackView.constant = CGFloat(40 * numberView)
        }
    }
}
extension CellFillExercise : TextViewChangeHeightDelegate {
    func textChanged(text: String, index: Int) {
        //for exercise
        if listAnswer.count > 0 {
            self.listAnswer[index - 1].value = text
        }
        //for competition
        if listAnswerCompetition.count > 0 {
            self.listAnswerCompetition[index - 1].value = text
        }
    }
    
    func distanceChange(distance: CGFloat) {
        self.heightStackView.constant += distance
    }
}

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

    @IBOutlet weak var heightAudio: NSLayoutConstraint!
    @IBOutlet weak var imgAudio: UIImageView!
    @IBOutlet weak var heightStackView: NSLayoutConstraint!
    @IBOutlet weak var stvFillQuestion: UIStackView!
    @IBOutlet weak var tvContent: UITextView!
    let popover = Popover()
    var type : TypeDoExercise = .entranceExercise
    weak var delegate: CellExerciseDelegate?
    var attributed: NSMutableAttributedString?
    var numberLine: Int = 0
    //for competition
    var listAnswerCompetition : [SubmitAnswerEntity] = []
    //for exercise
    var listAnswer : [QuestionChoiceResultParam] = []
    
    var indexPath: IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    func setupView(){
        imgAudio.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(clickAudio)))
        tvContent.textContainerInset = UIEdgeInsets.zero
        tvContent.textContainer.lineFragmentPadding = 0
    }
    
    @objc func clickAudio(){
        delegate?.clickAudio(indexPath: self.indexPath ?? IndexPath(row: 0, section: 0))
    }
    
    func setupCell(data: QuestionEntity){
        DispatchQueue.main.async {
            if data.checkHaveAudio() {
                self.heightAudio.constant = 60
            } else {
                self.heightAudio.constant = 0
            }
            self.layoutIfNeeded()
            self.detectQuestion(contextQuestion: data.content_extend&)
            self.setFillCell(numberView: data.answers?.count ?? 0)
        }
    }
    
    func detectQuestion(contextQuestion: String){
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 5
        let attributes = [NSAttributedString.Key.paragraphStyle : style, NSAttributedString.Key.font: AppFont.fontRegular14]
        tvContent.attributedText = NSAttributedString(string: contextQuestion.htmlToString, attributes: attributes)
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tap.numberOfTapsRequired = 2
        tvContent.addGestureRecognizer(tap)
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer){
        let point = sender.location(in: tvContent)
        if let detectedWord = getWordAtPosition(point){
            if type != .entranceExercise && type != .competition {
                delegate?.searchVocabulary(word: detectedWord,position: point, index: self.indexPath ?? IndexPath(row: 0, section: 0 ))
            }
        }
    }
    
    private func getWordAtPosition(_ point: CGPoint) -> String?{
        if let textPosition = tvContent.closestPosition(to: point) {
            if let range = tvContent.tokenizer.rangeEnclosingPosition(textPosition, with: .word, inDirection: UITextDirection(rawValue: 1)) {
                return tvContent.text(in: range)
            }
        }
        return nil
    }
    
    func setupPopOver(x:CGFloat, y: CGFloat,word: WordExplainEntity){
        DispatchQueue.main.async {
            self.popover.removeFromSuperview()
            let point = self.tvContent.convert(CGPoint(x: x, y: y), to: self.contentView)
            let aView = SearchVocabularyView(frame: CGRect(x: 0, y: 0, width: 200, height: 85))
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
//        if stvFillQuestion.subviews.count == 0 && numberView > 0 {
//            for index in 1...numberView {
//                let view = ViewFillQuestion()
//                view.setupTag(tag: index)
//                if listAnswer.count > 0 {
//                    view.content = listAnswer[index-1].value ?? ""
//                }
//                if listAnswerCompetition.count > 0 {
//                    view.content = listAnswerCompetition[index-1].value
//                }
//                self.stvFillQuestion.addArrangedSubview(view)
//                self.listViewAnswer.append(view)
//                view.delegate = self
//            }
//            self.heightStackView.constant = CGFloat(40 * numberView)
//        }
    }
}
//extension CellFillExercise : TextViewChangeHeightDelegate {
//    func textChanged(text: String, index: Int) {
//        //for exercise
//        if listAnswer.count > 0 {
//            self.listAnswer[index - 1].value = text
//        }
//        //for competition
//        if listAnswerCompetition.count > 0 {
//            self.listAnswerCompetition[index - 1].value = text
//        }
//    }
//    
//    func distanceChange(distance: CGFloat) {
//        self.heightStackView.constant += distance
//    }
//}

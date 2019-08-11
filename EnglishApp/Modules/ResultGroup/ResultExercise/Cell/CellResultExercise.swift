//
//  CellResultExercise.swift
//  EnglishApp
//
//  Created by vinova on 6/25/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit
import Popover

class CellResultExercise: UICollectionViewCell {
    
    weak var delegate: CellExerciseDelegate?
    @IBOutlet weak var tvContent: UITextView!
    @IBOutlet weak var vQuestion: UIView!
    @IBOutlet weak var tbvResultQuestion: UITableView!
    @IBOutlet weak var heightTableView: NSLayoutConstraint!
    var attributed: NSMutableAttributedString?
    var indexPath: IndexPath?
    var dataCell: QuestionResultEntity?{
        didSet{
            detectQuestion()
            tbvResultQuestion.reloadData()
        }
    }
    
    var actionExplainExericse : ((_ questionId: Int,_ answerId: Int) -> ())?
    var actionRelatedGrammar : ((_ questionId: Int,_ answerId: Int) -> ())?
    var actionReportQuestion : ((_ questionId: Int,_ answerId: Int) -> ())?
    var numberLine: Int = 0
    let popover = Popover()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    func setupView(){
        tvContent.textContainerInset = UIEdgeInsets.zero
        tvContent.textContainer.lineFragmentPadding = 0
        tbvResultQuestion.registerXibFile(CellResultFillQuestion.self)
        tbvResultQuestion.registerXibFile(CellResultChoice.self)
        tbvResultQuestion.dataSource = self
        tbvResultQuestion.delegate = self
        detectQuestion()
    }
    
    func detectQuestion(){
        let question = dataCell?.content?.htmlToString ?? ""
        let  textArray = question.components(separatedBy: " ")
        let attributedText = NSMutableAttributedString()
        for word in textArray {
            let attributed = NSMutableAttributedString(string: word + " ")
            let range = NSRange(location: 0, length: word.count)
            let myCustomAttributed = [ NSAttributedString.Key.init(rawValue: "tapped"):word, NSAttributedString.Key.font : AppFont.fontRegular14] as [NSAttributedString.Key : Any]
            attributed.addAttributes(myCustomAttributed, range: range)
            attributedText.append(attributed)
        }
        self.attributed = attributedText
        tvContent.attributedText = attributedText
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tap.numberOfTapsRequired = 2
        tvContent.addGestureRecognizer(tap)
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
}
extension CellResultExercise : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
extension CellResultExercise: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataCell?.answers?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let type = dataCell?.answers?.first?.type else {
            return UITableViewCell()
        }
        if type == "1" {
            let cell = tableView.dequeue(CellResultChoice.self, for: indexPath)
            cell.indexPath = indexPath
            cell.actionExplainQuestion = {[weak self] (index)in
                self?.actionExplainQuestion(indexAnswer: index)
            }
            cell.actionRelatedGrammar = {[weak self] (index) in
                self?.actionRelatedGrammar(indexAnswer: index)
            }
            cell.actionReportQuestion = {[weak self] (index)in
                self?.actionReportQuestion(indexAnswer:index)
            }
            if let answer = dataCell?.answers?[indexPath.row] {
                cell.setupCell(answer: answer)
            }
            heightTableView.constant = tbvResultQuestion.contentSize.height
            return cell
        }
        let cell = tableView.dequeue(CellResultFillQuestion.self, for: indexPath)
        cell.indexPath = indexPath
        cell.actionExplainQuestion = {[weak self] (index)in
            self?.actionExplainQuestion(indexAnswer: index)
        }
        cell.actionRelatedGrammar = {[weak self] (index) in
            self?.actionRelatedGrammar(indexAnswer: index)
        }
        cell.actionReportQuestion = {[weak self] (index)in
            self?.actionReportQuestion(indexAnswer:index)
        }
        if let answer = dataCell?.answers?[indexPath.row] {
            cell.setupCell(answer: answer)
        }
        heightTableView.constant = tbvResultQuestion.contentSize.height
        return cell
    }
    
    func actionExplainQuestion(indexAnswer: IndexPath){
        self.actionExplainExericse?(Int(self.dataCell?.question_id ?? "0") ?? 0, Int(self.dataCell?.answers?[indexAnswer.row]._id ?? "0") ?? 0)
    }
    
    func actionReportQuestion(indexAnswer: IndexPath){
        self.actionReportQuestion?(Int(self.dataCell?.question_id ?? "0") ?? 0, Int(self.dataCell?.answers?[indexAnswer.row]._id ?? "0") ?? 0)
    }
    
    func actionRelatedGrammar(indexAnswer: IndexPath){
        self.actionRelatedGrammar?(Int(self.dataCell?.question_id ?? "0") ?? 0, Int(self.dataCell?.answers?[indexAnswer.row]._id ?? "0") ?? 0)
    }
}

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
        tvContent.attributedText = dataCell?.content?.htmlToAttributedString
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tap.numberOfTapsRequired = 2
        tvContent.addGestureRecognizer(tap)
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer){
        let point = sender.location(in: tvContent)
        if let detectedWord = getWordAtPosition(point){
            delegate?.searchVocabulary(word: detectedWord,position: point, index: self.indexPath ?? IndexPath(row: 0, section: 0 ))
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

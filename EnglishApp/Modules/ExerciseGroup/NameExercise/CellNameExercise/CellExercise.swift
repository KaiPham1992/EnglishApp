//
//  CellExercise.swift
//  EnglishApp
//
//  Created by vinova on 6/3/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit
import Popover

protocol CellExerciseDelegate: class {
    func showDetailVocubulary(word: WordExplainEntity)
    func suggestQuestion(id: String,indexPath: IndexPath,indexQuestion: IndexPath)
    func searchVocabulary(word: String,position: CGPoint,index: IndexPath)
}

class CellExercise: UICollectionViewCell {
    
    @IBOutlet weak var heightTableView: NSLayoutConstraint!
    weak var delegate: CellExerciseDelegate?
    @IBOutlet weak var tvContent: UITextView!
    @IBOutlet weak var vQuestion: UIView!
    @IBOutlet weak var tbvNameExercise: UITableView!
    var type : TypeDoExercise = .entranceExercise
    
    var attributed: NSMutableAttributedString?
    var indexPath: IndexPath?
    
    var answer: [ChildQuestionEntity] = []
    var numberLine: Int = 0
    let popover = Popover()
    //for exercise
    var listAnswer : [QuestionChoiceResultParam] = []
    //for competition
    var listAnswerCompetition : [SubmitAnswerEntity] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    func setupView(){
        tvContent.textContainerInset = UIEdgeInsets.zero
        tvContent.textContainer.lineFragmentPadding = 0
        tbvNameExercise.registerXibFile(CellQuestion.self)
        tbvNameExercise.dataSource = self
        tbvNameExercise.delegate = self
    }
    
    func setupCell(dataCell: QuestionEntity){
        DispatchQueue.main.async {
            self.detectQuestion(contextQuestion: dataCell.content_extend&,type : self.type)
            self.answer = dataCell.answers ?? []
            self.tbvNameExercise.reloadData()
        }
    }
    
    func detectQuestion(contextQuestion: String,type : TypeDoExercise){
        tvContent.attributedText = contextQuestion.htmlToAttributedString
        if type != .entranceExercise || type != .competition {
            let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
            tap.numberOfTapsRequired = 2
            tvContent.addGestureRecognizer(tap)
        }
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
        popover.removeFromSuperview()
        let point = tvContent.convert(CGPoint(x: x, y: y), to: self.contentView)
        let aView = SearchVocabularyView(frame: CGRect(x: 0, y: 0, width: 200, height: 85))
        aView.actionSeeDetailWord = {[weak self] (word) in
            self?.gotoDetailVocabulary(word: word)
        }
        aView.setTitle(word: word)
        popover.blackOverlayColor = .clear
        popover.popoverColor = .white
        popover.addShadow(ofColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.25), opacity: 1)
        popover.layer.cornerRadius = 5
        popover.show(aView, point: point, inView: self.contentView)
    }
    
    func gotoDetailVocabulary(word: WordExplainEntity){
        delegate?.showDetailVocubulary(word: word)
    }
}
extension CellExercise : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
extension CellExercise: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.answer.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(CellQuestion.self, for: indexPath)
        cell.indexPath = indexPath
        //for exercise
        if listAnswer.count > 0  {
            cell.answer = listAnswer[indexPath.row].value ?? ""
        }
        //for competition
        if listAnswerCompetition.count > 0 {
            cell.answer = listAnswerCompetition[indexPath.row].value
        }
        
        //show hide button suggesstion
        
        let isShowButtonSuggesstion = self.type != .entranceExercise && self.type != .competition ? true : false
        cell.setupButtonSuggestion(isShow: isShowButtonSuggesstion)
        
        if let listAnswer = self.getDataSource(indexPath: indexPath), let option = self.getIdOption(indexPath: indexPath){
            cell.idOption = option
            cell.dataSource = listAnswer
        }
        cell.delegate = self
        heightTableView.constant = tbvNameExercise.contentSize.height
        return cell
    }
    
    func getDataSource(indexPath: IndexPath) -> [String]? {
        return self.answer[indexPath.row].options.map{$0.value}.compactMap{$0}
    }
    func getIdOption(indexPath: IndexPath) -> [Int]?{
        return self.answer[indexPath.row].options.map{Int($0._id ?? "0")}.compactMap{$0}
    }
    
    func changeDataSource(index: IndexPath, data: [ChildQuestionEntity]){
        self.answer = data
        if let cell = tbvNameExercise.cellForRow(at: index) as? CellQuestion{
            cell.dataSource = self.getDataSource(indexPath: index) ?? []
        }
    }
}

extension CellExercise : ClickQuestionDelegate{
    func suggestQuestion(index: IndexPath) {
        if let _id = answer[index.row]._id {
            delegate?.suggestQuestion(id: _id, indexPath: self.indexPath ?? IndexPath(row: 0, section: 0),indexQuestion: index)
        }
    }
    
    func changeAnswer(idAnswer: Int,valueAnswer: String, indexPath: IndexPath?) {
        if let _indexPath = indexPath {
            if listAnswer.count > 0 {
                self.listAnswer[_indexPath.row].option_id = idAnswer
                self.listAnswer[_indexPath.row].value = valueAnswer
            }
            if listAnswerCompetition.count > 0 {
                self.listAnswerCompetition[_indexPath.row].option_id = idAnswer
                self.listAnswerCompetition[_indexPath.row].value = valueAnswer
            }
        }
    }
}


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
    func changeAnswer(idAnswer: Int,valueAnswer: String, indexPathRow: IndexPath, indexPath: IndexPath)
    func clickAudio(indexPath: IndexPath)
}

class CellExercise: UICollectionViewCell {
    
    @IBOutlet weak var imgAudio: UIImageView!
    @IBOutlet weak var heightTableView: NSLayoutConstraint!
    weak var delegate: CellExerciseDelegate?
    @IBOutlet weak var tvContent: UITextView!
    @IBOutlet weak var vQuestion: UIView!
    @IBOutlet weak var tbvNameExercise: UITableView!
    var type : TypeDoExercise = .entranceExercise
    
    @IBOutlet weak var heightAudio: NSLayoutConstraint!
    var attributed: NSMutableAttributedString?
    var indexPath: IndexPath?
    var numberLine: Int = 0
    let popover = Popover()
    var listIdOption : [[Int]] = []
    var listDataSource : [[String]] = []
    //for exercise
    var listAnswer : [QuestionChoiceResultParam] = []
    //for competition
    var listAnswerCompetition : [SubmitAnswerEntity] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    override func prepareForReuse() {
        if let tab = tvContent.gestureRecognizers, let item = tab.first {
            tvContent.removeGestureRecognizer(item)
        }
    }
    
    func setupView(){
        imgAudio.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(clickAudio)))
        tvContent.textContainerInset = UIEdgeInsets.zero
        tvContent.textContainer.lineFragmentPadding = 0
        tbvNameExercise.registerXibFile(CellQuestion.self)
        tbvNameExercise.dataSource = self
        tbvNameExercise.delegate = self
    }
    
    @objc func clickAudio(){
        delegate?.clickAudio(indexPath: self.indexPath ?? IndexPath(row: 0, section: 0))
    }
    
    func setupCell(dataCell: QuestionEntity){
        DispatchQueue.main.async {
            if dataCell.checkHaveAudio() {
                self.heightAudio.constant = 60
            } else {
                self.heightAudio.constant = 0
            }
            self.layoutIfNeeded()
            self.detectQuestion(contextQuestion: dataCell.content_extend&,type : self.type)
//            self.answer = dataCell.answers ?? []
            self.tbvNameExercise.reloadData()
        }
    }
    
    func detectQuestion(contextQuestion: String,type : TypeDoExercise){
        tvContent.attributedText = NSAttributedString(string:  contextQuestion.htmlToString, attributes: [NSAttributedString.Key.font: AppFont.fontRegular14])
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
        if listAnswerCompetition.count > 0 {
            return listAnswerCompetition.count
        }
        return listAnswer.count
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
        cell.idOption = listIdOption[indexPath.row]
        cell.dataSource = listDataSource[indexPath.row]
        cell.delegate = self
        heightTableView.constant = tbvNameExercise.contentSize.height
        return cell
    }
    
    func changeDataSource(index: IndexPath, data: [ChildQuestionEntity]){
//        self.answer = data
        self.listIdOption[index.row] = data[index.row].options.map{Int($0._id ?? "0") ?? 0}
        self.listDataSource[index.row] = data[index.row].options.map{$0.value ?? ""}
        if let cell = tbvNameExercise.cellForRow(at: index) as? CellQuestion{
            cell.dataSource = listDataSource[index.row]
            cell.idOption = listIdOption[index.row]
//            cell.dataSource = self.getDataSource(indexPath: index) ?? []
        }
    }
}

extension CellExercise : ClickQuestionDelegate{
    func suggestQuestion(index: IndexPath) {
        if let _id = listAnswer[index.row].question_id {
            delegate?.suggestQuestion(id: String(_id), indexPath: self.indexPath ?? IndexPath(row: 0, section: 0),indexQuestion: index)
        }
    }
    
    func changeAnswer(index: Int, indexPath: IndexPath?) {
        if let _indexPath = indexPath {
             self.delegate?.changeAnswer(idAnswer: listIdOption[_indexPath.row][index], valueAnswer: listDataSource[_indexPath.row][index], indexPathRow: _indexPath, indexPath: self.indexPath ?? IndexPath(row: 0, section: 0))
        }
    }
}



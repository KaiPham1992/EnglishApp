//
//  CellExercise.swift
//  EnglishApp
//
//  Created by vinova on 6/3/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit
//import Popover

protocol CellExerciseDelegate: class {
//    func showDetailVocubulary(word: WordExplainEntity)
    func suggestQuestion(id: String, indexPath: IndexPath, indexQuestion: IndexPath)
    func searchVocabulary(word: String, position: CGPoint, index: IndexPath)
    func changeAnswer(idAnswer: Int?, valueAnswer: String?, indexPathRow: IndexPath, indexPath: IndexPath)
    func clickAudio(indexPath: IndexPath)
}

class CellExercise: UICollectionViewCell {
    
    @IBOutlet weak var imgAudio: UIImageView!
    weak var delegate: CellExerciseDelegate?
    @IBOutlet weak var tvContent: UITextView!
    @IBOutlet weak var vAudio: UIView!
    @IBOutlet weak var tbvNameExercise: UITableView!
    var type : TypeDoExercise = .entranceExercise
    var typeQuestion = "2"
    
    var attributed: NSMutableAttributedString?
    var indexPath: IndexPath?
    var numberLine: Int = 0
    //for exercise
    var listAnswer : [QuestionChoiceResultParam] = []
    //for competition
    var listAnswerCompetition : [SubmitAnswerEntity] = []
    
    var callbackShowPopup : ((_ fromView: UIView, _ rect: CGPoint, _ word: WordExplainEntity) -> ())?
    
    var questionEntity: QuestionEntity? {
        didSet {
            if (self.questionEntity?.checkHaveAudio() ?? false) {
                self.vAudio.isHidden = false
            } else {
                self.vAudio.isHidden = true
            }
            self.layoutIfNeeded()
            self.detectQuestion(contextQuestion: self.questionEntity?.content_extend ?? "", type : self.type)
            DispatchQueue.main.async {
                self.tbvNameExercise.reloadData()
            }
        }
    }
    
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
        tbvNameExercise.registerXibFile(CellChoiceQuestionExercise.self)
        tbvNameExercise.registerXibFile(CellFillQuestionExercise.self)
        tbvNameExercise.dataSource = self
        tbvNameExercise.delegate = self
    }
    
    @objc func clickAudio(){
        delegate?.clickAudio(indexPath: self.indexPath ?? IndexPath(row: 0, section: 0))
    }
    
    func detectQuestion(contextQuestion: String, type : TypeDoExercise){
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
//        popover.removeFromSuperview()
        callbackShowPopup?(self.contentView, tvContent.convert(CGPoint(x: x, y: y), to: self.contentView), word)
//        let aView = SearchVocabularyView(frame: CGRect(x: 0, y: 0, width: 200, height: 85))
//        aView.actionSeeDetailWord = {[weak self] (word) in
//            self?.gotoDetailVocabulary(word: word)
//        }
//        aView.setTitle(word: word)
//        popover.blackOverlayColor = .clear
//        popover.popoverColor = .white
//        popover.addShadow(ofColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.25), opacity: 1)
//        popover.layer.cornerRadius = 5
//        popover.show(aView, point: point, inView: self.contentView)
    }
    
//    func gotoDetailVocabulary(word: WordExplainEntity){
//        delegate?.showDetailVocubulary(word: word)
//    }
}
extension CellExercise : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
extension CellExercise: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return questionEntity?.answers?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return typeQuestion == "2" ? 1 : (questionEntity?.answers?[section].options.count ?? 0)
    }
    //show UI answer
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //type answer rewirte
        if typeQuestion == "2" {
            let answer = listAnswer[indexPath.section].value ?? ""
            let cell = tableView.dequeue(CellFillQuestionExercise.self, for: indexPath)
            cell.setupCell(text: answer)
            cell.callbackChangeHeight = {[weak self] in
                //update height tableview when user enter input > width textview.
                self?.updateHeightCell()
            }
            cell.callbackChangeText = {[weak self] (text: String) in
                self?.userChangeFillAnswer(indexPath: indexPath, text: text)
            }
            return cell
        }
        //type answer listeninng
        if let answer = questionEntity?.answers?[indexPath.section].options[indexPath.row] {
            let cell = tableView.dequeue(CellChoiceQuestionExercise.self, for: indexPath)
            cell.indexPath = indexPath
            //isChoice -> to check user choice answer.
            cell.setupView(isChoice: answer.isChoice, content: (answer.value ?? "") + ". " + (answer._id ?? ""))
            cell.callbackSelectAnswer = {[weak self] (index) in
                self?.userChangeChoiceAnswer(indexPath: index)
            }
            return cell
        }
//        cell.indexPath = indexPath
//        //for exercise
//        if listAnswer.count > 0  {
//            cell.answer = listAnswer[indexPath.row].value ?? ""
//        }
//        //for competition
//        if listAnswerCompetition.count > 0 {
//            cell.answer = listAnswerCompetition[indexPath.row].value
//        }
        return UITableViewCell()
    }
    
    func userChangeFillAnswer(indexPath: IndexPath, text: String) {
        if type == .competition {
            self.listAnswerCompetition[indexPath.section].value = text
        } else {
            self.listAnswer[indexPath.section].value = text
        }
    }
    
    func userChangeChoiceAnswer(indexPath: IndexPath){
        if let options = questionEntity?.answers?[indexPath.section].options {
            var listIndex : [IndexPath] = []
            if let firstIndex = options.firstIndex(where: {$0.isChoice}), firstIndex != indexPath.row {
                options[firstIndex].isChoice = false
                listIndex.append(IndexPath(row: firstIndex, section: indexPath.section))
            }
            options[indexPath.row].isChoice = !options[indexPath.row].isChoice
//            if options[indexPath.row].isChoice {
//                self.delegate?.changeAnswer(idAnswer: Int(options[indexPath.row]._id ?? "0"), valueAnswer: options[indexPath.row].value, indexPathRow: indexPath, indexPath: self.indexPath ?? IndexPath(row: 0, section: 0))
//
//            } else {
//                self.delegate?.changeAnswer(idAnswer: nil, valueAnswer: options[indexPath.row].value , indexPathRow: indexPath, indexPath: self.indexPath ?? IndexPath(row: 0, section: 0))
//            }
            if type == .competition {
//                self.listAnswerCompetition[indexPath.section].value = options[indexPath.row].value ?? ""
                self.listAnswerCompetition[indexPath.section].option_id = options[indexPath.row].isChoice ? Int(options[indexPath.row]._id ?? "0") ?? 0 : 0
            } else {
//                self.listAnswer[indexPath.section].value = options[indexPath.row].value ?? ""
                self.listAnswer[indexPath.section].option_id = options[indexPath.row].isChoice ? Int(options[indexPath.row]._id ?? "0") ?? 0 : nil
                
            }
            listIndex.append(indexPath)
            self.tbvNameExercise.reloadRows(at: listIndex, with: .automatic)
        }
    }
    
    private func updateHeightCell(){
        tbvNameExercise.beginUpdates()
        tbvNameExercise.endUpdates()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView.init()
        let headerView = ViewHeaderQuestionExercise()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerView)
        headerView.fillToView(view: view)
        headerView.setupSuggestButton(isShow: self.type != .entranceExercise && self.type != .competition && self.typeQuestion != "2" ? true : false)
        //show UI question
        headerView.setupCell(index: section + 1, content: questionEntity?.answers?[section]._id ?? "")
        headerView.callbackSugestionQuestion = {[weak self] in
            self?.suggestionQuestion(section: section)
        }
        return view
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func suggestionQuestion(section: Int) {
        if let _id = listAnswer[section].question_id {
            delegate?.suggestQuestion(id: String(_id), indexPath: self.indexPath ?? IndexPath(row: 0, section: 0), indexQuestion: IndexPath(row: 0, section: section))
        }
    }
    
    func changeDataSource(index: IndexPath){
        self.tbvNameExercise.reloadSections(IndexSet(integer: index.section), with: .automatic)
    }
}



//
//  CellExercise.swift
//  EnglishApp
//
//  Created by vinova on 6/3/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

protocol CellExerciseDelegate: class {
    func suggestQuestion(id: String, indexPath: IndexPath, indexQuestion: IndexPath)
    func searchVocabulary(word: String, position: CGPoint, index: IndexPath)
    func clickAudio(indexPath: IndexPath)
}

class CellExercise: UICollectionViewCell {
    
    @IBAction func clickAudio(_ sender: Any) {
        delegate?.clickAudio(indexPath: self.indexPath ?? IndexPath(row: 0, section: 0))
    }
    weak var delegate: CellExerciseDelegate?
    @IBOutlet weak var tvContent: UITextView!
    @IBOutlet weak var vAudio: UIView!
    @IBOutlet weak var tbvNameExercise: UITableView!
    var type : TypeDoExercise = .entranceExercise
    
    var indexPath: IndexPath?
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
        tvContent.contentInset = UIEdgeInsets.init(top: 10, left: 10, bottom: 80, right: 10)
        tbvNameExercise.registerXibFile(CellChoiceQuestionExercise.self)
        tbvNameExercise.registerXibFile(CellFillQuestionExercise.self)
        tbvNameExercise.dataSource = self
        tbvNameExercise.delegate = self
    }
    
    func detectQuestion(contextQuestion: String, type : TypeDoExercise){
        tvContent.attributedText = contextQuestion.attributedString()
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
        callbackShowPopup?(self.contentView, tvContent.convert(CGPoint(x: x, y: y), to: self.contentView), word)
    }
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
        return ((questionEntity?.answers?[section].type ?? "") == "2") ? 1 : (questionEntity?.answers?[section].options.count ?? 0)
    }
    //show UI answer
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //type answer rewirte
        if (questionEntity?.answers?[indexPath.section].type ?? "") == "2" {
            let cell = tableView.dequeue(CellFillQuestionExercise.self, for: indexPath)
            if listAnswer.count > 0 {
                let answer = listAnswer[indexPath.section].value ?? ""
                cell.setupCell(text: answer)
            }
            if listAnswerCompetition.count > 0 {
                let answer = listAnswerCompetition[indexPath.section].value
                cell.setupCell(text: answer)
            }
            cell.callbackChangeHeight = {[weak self] in
                //update height tableview when user enter input > width textview.
                guard let self = self else {return}
                self.updateHeightCell()
            }
            cell.callbackChangeText = {[weak self] (text: String) in
                guard let self = self else {return}
                self.userChangeFillAnswer(indexPath: indexPath, text: text)
            }
            return cell
        }
        //type answer listeninng
        if let answer = questionEntity?.answers?[indexPath.section].options[indexPath.row] {
            let cell = tableView.dequeue(CellChoiceQuestionExercise.self, for: indexPath)
            cell.indexPath = indexPath
            //isChoice -> to check user choice answer.
            cell.setupView(isChoice: answer.isChoice, content: (answer.value ?? "") + ". " + (answer.content ?? ""))
            cell.callbackSelectAnswer = {[weak self] (index) in
                guard let self = self else {return}
                self.userChangeChoiceAnswer(indexPath: index)
            }
            return cell
        }
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
            if let firstIndex = options.firstIndex(where: {$0.isChoice}), firstIndex != indexPath.row {
                options[firstIndex].isChoice = false
                if let cellChoice = tbvNameExercise.cellForRow(at: IndexPath(row: firstIndex, section: indexPath.section)) as? CellChoiceQuestionExercise {
                    cellChoice.setupView(isChoice: options[firstIndex].isChoice)
                }
            }
            options[indexPath.row].isChoice = !options[indexPath.row].isChoice
            if let cellChoice = tbvNameExercise.cellForRow(at: indexPath) as? CellChoiceQuestionExercise {
                cellChoice.setupView(isChoice: options[indexPath.row].isChoice)
            }
            if type == .competition {
                self.listAnswerCompetition[indexPath.section].option_id = options[indexPath.row].isChoice ? Int(options[indexPath.row]._id ?? "0") ?? 0 : 0
            } else {
                self.listAnswer[indexPath.section].option_id = options[indexPath.row].isChoice ? Int(options[indexPath.row]._id ?? "0") ?? 0 : nil
            }
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
        headerView.setupSuggestButton(isShow: self.type != .entranceExercise && self.type != .competition && (questionEntity?.answers?[section].type ?? "") == "1" ? true : false)
        //show UI question
        headerView.setupCell(index: section + 1, content: questionEntity?.answers?[section].content ?? "")
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



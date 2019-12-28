//
//  CellResultExercise.swift
//  EnglishApp
//
//  Created by vinova on 6/25/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit
//import Popover

class CellResultExercise: UICollectionViewCell {
    
    weak var delegate: CellExerciseDelegate?

    @IBOutlet weak var tbvResultQuestion: UITableView!
    var attributed: NSMutableAttributedString?
    var indexPath: IndexPath!
    
    @IBOutlet weak var tvContent: UITextView!
    @IBOutlet weak var vAudio: UIView!
    
    @IBAction func clickAudio(_ sender: Any) {
        delegate?.clickAudio(indexPath: self.indexPath)
    }
    
    var questionEntity: QuestionResultEntity?{
        didSet{
            if (self.questionEntity?.checkHaveAudio() ?? false) {
                self.vAudio.isHidden = false
            } else {
                self.vAudio.isHidden = true
            }
            self.layoutIfNeeded()
            detectQuestion()
            self.setContentQuestion()
            tbvResultQuestion.reloadData()
        }
    }
    
    var callbackShowPopup : ((_ fromView: UIView, _ rect: CGPoint, _ word: WordExplainEntity) -> ())?
    var actionExplainExericse : ((_ questionId: Int) -> ())?
    var actionRelatedGrammar : ((_ questionId: Int) -> ())?
    
    var numberLine: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        if let tab = tvContent.gestureRecognizers, let item = tab.first {
            tvContent.removeGestureRecognizer(item)
        }
    }
    
    func setupView(){
        tvContent.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 100, right: 0)
        tbvResultQuestion.registerXibFile(CellResultFillQuestion.self)
        tbvResultQuestion.registerXibFile(CellResultChoice.self)
        tbvResultQuestion.dataSource = self
        tbvResultQuestion.delegate = self
    }
    
    func setContentQuestion() {
        tvContent.attributedText = questionEntity?.content?.attributedString()
    }
    
    func detectQuestion(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tap.numberOfTapsRequired = 2
        tvContent.addGestureRecognizer(tap)
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer){
        let point = sender.location(in: tvContent)
        if let detectedWord = getWordAtPosition(point){
            delegate?.searchVocabulary(word: detectedWord, position: point, index: self.indexPath)
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
extension CellResultExercise : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
extension CellResultExercise: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return questionEntity?.answers?.count ?? 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let type = questionEntity?.answers?.first?.type else {
            return 0
        }
        return type == "1" ? (questionEntity?.answers?[section].options.count ?? 0) : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let type = questionEntity?.answers?.first?.type else {
            return UITableViewCell()
        }
        let value = questionEntity?.answers?[indexPath.section].value ?? ""
        let status = questionEntity?.answers?[indexPath.section].status ?? ""
        if type == "1" {
            let cell = tableView.dequeue(CellResultChoice.self, for: indexPath)
            cell.indexPath = indexPath
            if let option = questionEntity?.answers?[indexPath.section].options[indexPath.row]{
                cell.setupCell(option: option, status: status, value: value)
            }
            return cell
        }
        let cell = tableView.dequeue(CellResultFillQuestion.self, for: indexPath)
        cell.indexPath = indexPath
        if let answer = questionEntity?.answers?[indexPath.section] {
            cell.setupCell(answer: answer)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView.init()
        let headerView = ViewHeaderResultExercise()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerView)
        headerView.fillToView(view: view)
        //show UI question
        headerView.setupCell(index: section + 1, content: questionEntity?.answers?[section].content_extend ?? "")
        headerView.callbackExplainQuestion = {[weak self] (section) in
            self?.actionExplainQuestion(section: section)
        }
        headerView.callbackRelatedGrammar = {[weak self] (section) in
            self?.actionRelatedGrammar(section: section)
        }
        headerView.callbackDoubleTap = {[weak self] (word, point) in
            let newPoint = headerView.convert(point, to: self?.contentView)
            self?.delegate?.searchVocabulary(word: word, position: newPoint, index: self?.indexPath ?? IndexPath(row: 0, section: 0 ))
        }
        return view
    }
       
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
       
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func actionExplainQuestion(section: Int){
        self.actionExplainExericse?(Int(self.questionEntity?.answers?[section].question_details_id ?? "0") ?? 0)
    }
    
    func actionRelatedGrammar(section: Int){
        self.actionRelatedGrammar?(Int(self.questionEntity?.answers?[section].question_details_id ?? "0") ?? 0)
    }
}

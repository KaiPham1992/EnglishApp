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

    @IBOutlet weak var tbvResultQuestion: UITableView!
    var attributed: NSMutableAttributedString?
    var indexPath: IndexPath?
    
    @IBOutlet weak var tvContent: UITextView!
    @IBOutlet weak var vAudio: UIView!
    
    var questionEntity: QuestionResultEntity?{
        didSet{
            if (self.questionEntity?.checkHaveAudio() ?? false) {
                self.vAudio.isHidden = false
            } else {
                self.vAudio.isHidden = true
            }
            self.layoutIfNeeded()
            self.setContentQuestion()
            tbvResultQuestion.reloadData()
        }
    }
    
    var actionExplainExericse : ((_ questionId: Int,_ answerId: Int) -> ())?
    var actionRelatedGrammar : ((_ questionId: Int,_ answerId: Int) -> ())?
    
    var numberLine: Int = 0
    let popover = Popover()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    func setupView(){
        tbvResultQuestion.registerXibFile(CellResultFillQuestion.self)
        tbvResultQuestion.registerXibFile(CellResultChoice.self)
        tbvResultQuestion.dataSource = self
        tbvResultQuestion.delegate = self
        detectQuestion()
    }
    
    func setContentQuestion() {
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 5
        let attributes = [NSAttributedString.Key.paragraphStyle : style, NSAttributedString.Key.font: AppFont.fontRegular14]
        tvContent.attributedText = NSAttributedString(string: questionEntity?.content?.htmlToString ?? "", attributes: attributes)
    }
    
    func detectQuestion(){
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
        return questionEntity?.answers?.count ?? 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let type = questionEntity?.answers?.first?.type else {
            return 0
        }
        return type == "1" ? 4 : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let type = questionEntity?.answers?.first?.type else {
            return UITableViewCell()
        }
        if type == "1" {
            let cell = tableView.dequeue(CellResultChoice.self, for: indexPath)
            cell.indexPath = indexPath
            if let answer = questionEntity?.answers?[indexPath.section] {
                cell.setupCell(answer: answer)
            }
            return cell
        }
        
        let cell = tableView.dequeue(CellResultFillQuestion.self, for: indexPath)
        cell.indexPath = indexPath
        if let answer = questionEntity?.answers?[indexPath.row] {
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
        headerView.setupCell(index: section + 1, content: questionEntity?.answers?[section]._id ?? "")
        headerView.callbackExplainQuestion = {[weak self] (section) in
            self?.actionExplainQuestion(section: section)
        }
        headerView.callbackRelatedGrammar = {[weak self] (section) in
            self?.actionRelatedGrammar(section: section)
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
        self.actionExplainExericse?(Int(self.questionEntity?.question_id ?? "0") ?? 0, Int(self.questionEntity?.answers?[section]._id ?? "0") ?? 0)
    }
    
    func actionRelatedGrammar(section: Int){
        self.actionRelatedGrammar?(Int(self.questionEntity?.question_id ?? "0") ?? 0, Int(self.questionEntity?.answers?[section].question_details_id ?? "0") ?? 0)
    }
}

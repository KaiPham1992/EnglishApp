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
    
    @IBOutlet weak var tvContent: TextViewHandleTap!
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
            self.setContentQuestion()
            tbvResultQuestion.reloadData()
        }
    }

    var actionExplainExericse : ((_ questionId: Int) -> ())?
    var actionRelatedGrammar : ((_ questionId: Int) -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        tvContent.contentOffset = CGPoint(x: 0, y: 0)
    }

    func setupView(){
//        tvContent.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 50, right: 0)
        tbvResultQuestion.registerXibFile(CellResultFillQuestion.self)
        tbvResultQuestion.registerXibFile(CellResultChoice.self)
        tbvResultQuestion.dataSource = self
        tbvResultQuestion.delegate = self
        tvContent.callbackDoubleTap = {[weak self] (position, word) in
            guard let self = self else {return}
            let newPoint = self.tvContent.convert(position, to: self)
            self.delegate?.searchVocabulary(word: word, position: newPoint, index: self.indexPath ?? IndexPath(row: 0, section: 0 ))
        }
    }
    
    func setContentQuestion() {
        tvContent.attributedText = questionEntity?.content?.attributedString()
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
        let type = questionEntity?.answers?[section].type ?? "1"
        return type == "2" ? 1 : (questionEntity?.answers?[section].options.count ?? 0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let type = questionEntity?.answers?[indexPath.section].type ?? "1"
        let value = questionEntity?.answers?[indexPath.section].value ?? ""
        let status = questionEntity?.answers?[indexPath.section].status ?? ""
        if type == "1" {
            let cell = tableView.dequeue(CellResultChoice.self, for: indexPath)
            cell.indexPath = indexPath
            if let option = questionEntity?.answers?[indexPath.section].options[indexPath.row]{
                cell.setupCell(option: option, status: status, value: value)
            }
            
            cell.callbackDoubleTap = {[weak self] (word, position) in
                let newPoint = cell.convert(position, to: self)
                self?.delegate?.searchVocabulary(word: word, position: newPoint, index: self?.indexPath ?? IndexPath(row: 0, section: 0 ))
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
            let newPoint = headerView.convert(point, to: self)
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

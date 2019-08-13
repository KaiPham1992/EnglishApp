//
//  NameExerciseViewController.swift
//  EnglishApp
//
//  Created vinova on 5/23/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit
import Popover

protocol ExerciseDelegate: class {
    func confirmOutTestEntrance()
}

enum TypeDoExercise : Int {
    case createExercise = 5
    case levelExercise = 7
    case practiceExercise = 3
    case assignExercise = 6
    case dailyMissonExercise = 2
    case entranceExercise = 1
    case competition = 100
}

class NameExerciseViewController: BaseViewController {

	var presenter: NameExercisePresenterProtocol?
    weak var exerciseDelegate: ExerciseDelegate?

    @IBAction func clickNext(_ sender: Any) {
        if self.currentIndex + 1 > numberQuestion {
            if let _param = self.paramSubmit {
                _param.total_time = self.listAnswerQuestion.map{$0.time}.getSum()
                self.presenter?.submitExercise(param: _param)
            }
        } else {
            self.currentIndex += 1
            lblIndexQuestion.text = "\(self.currentIndex)/\(numberQuestion)"
            clvQuestion.scrollToItem(at: IndexPath(row: self.currentIndex - 1, section: 0), at: .right, animated: false)
        }
    }
    var numberQuestion : Int = 0
    var currentTime : Int = 0
    var listAnswerQuestion : [QuestionSubmitParam] = []
    var idExercise : String = ""
    var paramSubmit : SubmitExerciseParam?
    
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var lblIndexQuestion: UILabel!
    @IBOutlet weak var clvQuestion: UICollectionView!
    @IBOutlet weak var vCountTime: ViewTime!
    var typeExercise: TypeDoExercise = .createExercise
    
    var currentIndex = 1 {
        didSet{
            if self.currentIndex == numberQuestion {
                btnNext.setTitle(LocalizableKey.time_end.showLanguage, for: .normal)
            } else {
                btnNext.setTitle(LocalizableKey.next.showLanguage.uppercased(), for: .normal)
            }
        }
    }
    
    var isEnd : Bool = false{
        didSet {
            vCountTime.stopTimer()
            if self.currentIndex < numberQuestion {
                self.currentIndex = numberQuestion
                lblIndexQuestion.text = "\(self.currentIndex)/\(numberQuestion)"
                clvQuestion.scrollToItem(at: IndexPath(row: self.currentIndex - 1, section: 0), at: .right, animated: false)
            }
            self.disableUserInteractionCell()
        }
    }
    
    override func setUpViews() {
        super.setUpViews()
        btnNext.setTitle(LocalizableKey.next.showLanguage.uppercased(), for: .normal)
        clvQuestion.registerXibCell(CellFillExercise.self)
        clvQuestion.registerXibCell(CellExercise.self)
        clvQuestion.delegate = self
        clvQuestion.dataSource = self
        vCountTime.delegate = self
        self.presenter?.type = self.typeExercise
        
        switch typeExercise {
        case .dailyMissonExercise:
            self.presenter?.getDailyMisson()
        case .entranceExercise:
            self.presenter?.getViewEntranceTest()
        default:
             self.presenter?.getViewExercise(id: self.idExercise)
        }
    }
    
    override func setUpNavigation() {
        super.setUpNavigation()
        self.tabBarController?.tabBar.isHidden = true
        addBackToNavigation()
        addButtonToNavigation(image: UIImage(named:"Material_Icons_white_chevron_left_Copy") ?? UIImage(), style: .right, action: #selector(deleteExercise))
    }
    
    func disableUserInteractionCell(){
        clvQuestion.isUserInteractionEnabled = false
    }
    
    @objc func deleteExercise(){
        if !isEnd {
            PopUpHelper.shared.showComfirmPopUp(message: LocalizableKey.popleaveHomeWork.showLanguage, titleYes: LocalizableKey.confirm.showLanguage.uppercased(), titleNo: LocalizableKey.cancel.showLanguage.uppercased(), complete: { [unowned self] in
                self.confirmOutExercise()
            })
        }
    }
    
    override func btnBackTapped() {
        if self.currentIndex == 1 {
            PopUpHelper.shared.showComfirmPopUp(message: LocalizableKey.popleaveHomeWork.showLanguage, titleYes: LocalizableKey.confirm.showLanguage.uppercased(), titleNo: LocalizableKey.cancel.showLanguage.uppercased(), complete: { [unowned self] in
               self.confirmOutExercise()
            })
        } else {
            if !isEnd {
                self.currentIndex -= 1
                lblIndexQuestion.text = "\(self.currentIndex)/\(numberQuestion)"
                clvQuestion.scrollToItem(at: IndexPath(row: self.currentIndex - 1, section: 0), at: .left, animated: false)
            }
        }
    }
    
    func confirmOutExercise(){
        self.presenter?.exitExercise(id: Int(self.presenter?.exerciseEntity?._id ?? "0") ?? 0)
    }
}

extension NameExerciseViewController :NameExerciseViewProtocol{
    func suggestQuestionError() {
        let errorMessage = self.presenter?.error?.message&
        var message = "Không đủ mật ong vui lòng nạp thêm."
        if errorMessage == "NOT_ENOUGH_DIAMOND"{
            message = "Không đủ kim cương vui lòng nạp thêm."
        }
        PopUpHelper.shared.showError(message: message) {
            
        }
    }
    func suggesQuestionSuccessed(indexPath: IndexPath, indexQuestion: IndexPath) {
        if let cell = clvQuestion.cellForItem(at: indexPath) as? CellExercise, let dataCell =  self.presenter?.getQuestion(indexPath: indexPath){
            cell.changeDataSource(index: indexQuestion, data: dataCell.answers ?? [])
        }
    }
    
    func reloadView() {
        DispatchQueue.global().async {
            self.numberQuestion = self.presenter?.exerciseEntity?.questions?.count ?? 0
            self.currentTime = self.presenter?.exerciseEntity?.total_times ?? 0
            self.paramSubmit = SubmitExerciseParam(exercise_id: Int(self.presenter?.exerciseEntity?._id ?? "0") ?? 0)
            if let questions = self.presenter?.exerciseEntity?.questions {
                for item in questions {
                    let answer = item.answers?.map{QuestionChoiceResultParam(question_id: Int($0._id&) ?? 0)} ?? []
                    let questionSubmitParam = QuestionSubmitParam(_id: Int(item._id ?? "0") ?? 0)
                    questionSubmitParam.answer = answer
                    self.listAnswerQuestion.append(questionSubmitParam)
                }
                self.paramSubmit?.questions = self.listAnswerQuestion
            }
            DispatchQueue.main.async {
                self.setTitleNavigation(title: self.presenter?.exerciseEntity?.name ?? "")
                self.lblIndexQuestion.text = "1/\(self.numberQuestion)"
                self.vCountTime.setupTimeStartNow(min: self.currentTime)
                self.clvQuestion.reloadData()
                ProgressView.shared.hide()
            }
        }
    }
    
    func getExerciseFailed(error: APIError) {
        PopUpHelper.shared.showError(message: error.message&) {
        }
    }
    func exitSuccessed() {
        self.exerciseDelegate?.confirmOutTestEntrance()
    }
    
    func searchVocabularySuccessed(wordEntity: WordExplainEntity, position: CGPoint,index: IndexPath) {
        if let cell = self.clvQuestion.cellForItem(at: index) as? CellFillExercise{
            cell.setupPopOver(x: position.x, y: position.y, word: wordEntity)
        }
        
        if let cell = self.clvQuestion.cellForItem(at: index) as? CellExercise{
            cell.setupPopOver(x: position.x, y: position.y, word: wordEntity)
        }
    }
}
extension NameExerciseViewController : UICollectionViewDelegate{
    
}
extension NameExerciseViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.00009
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.clvQuestion.frame.width, height: self.clvQuestion.frame.height)
    }
}
extension NameExerciseViewController: UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return self.numberQuestion
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let data = self.presenter?.getQuestion(indexPath: indexPath){
            let type = data.answers?.first?.type ?? ""
            if type == "" || type == "2"{
                let cell =  collectionView.dequeueCell(CellFillExercise.self, indexPath: indexPath)
                cell.type = self.typeExercise
                cell.setupCell(data: data)
                cell.indexPath = indexPath
                cell.listAnswer = listAnswerQuestion[indexPath.row].answer ?? []
                return cell
            }
            let cell = collectionView.dequeueCell(CellExercise.self, indexPath: indexPath)
            cell.type = self.typeExercise
            cell.indexPath = indexPath
            cell.listAnswer = listAnswerQuestion[indexPath.row].answer ?? []
            cell.delegate = self
            cell.setupCell(dataCell: data)
            return cell
        }
        return UICollectionViewCell()
    }
}

extension NameExerciseViewController : CellExerciseDelegate{
    
    
    func showDetailVocubulary(word: WordExplainEntity) {
        self.presenter?.gotoDetailVocabulary(word: word)
    }

    func suggestQuestion(id: String, indexPath: IndexPath, indexQuestion: IndexPath) {
        PopUpHelper.shared.showSuggesstionResult(diamond: {
            self.presenter?.suggestQuestion(id: id,indexPath: indexPath, indexQuestion: indexQuestion, isDiamond: true)
        }) {
            self.presenter?.suggestQuestion(id: id,indexPath: indexPath, indexQuestion: indexQuestion,isDiamond: false)
        }
    }
    
    func searchVocabulary(word: String, position: CGPoint,index: IndexPath) {
        self.presenter?.searchVocabulary(word: word, position: position, index: index)
    }
}

extension NameExerciseViewController : TimeDelegate{
    func changeTime() {
        self.listAnswerQuestion[self.currentIndex - 1].time += 1 
    }
    
    func startTime() {
        btnNext.isUserInteractionEnabled = true
        clvQuestion.isHidden = false
    }
    
    func endTime() {
        self.isEnd = true
    }
    
    func pauseTime() {
        btnNext.isUserInteractionEnabled = false
        clvQuestion.isHidden = true
    }
}

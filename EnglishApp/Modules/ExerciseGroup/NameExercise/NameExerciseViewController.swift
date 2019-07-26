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
}

class NameExerciseViewController: BaseViewController {

	var presenter: NameExercisePresenterProtocol?
    weak var exerciseDelegate: ExerciseDelegate?

    @IBAction func clickNext(_ sender: Any) {
//        arrTime[self.currentIndex - 1] = vCountTime.getCurrentTime()
        vCountTime.stopTimer()
        if let param = self.addDataCell(indexPath: IndexPath(row: self.currentIndex - 1, section: 0)) {
            self.listAnswerQuestion[self.currentIndex - 1].answer = param
        }
        if self.currentIndex + 1 > numberQuestion {
            self.paramSubmit?.questions = listAnswerQuestion
            if let _param = self.paramSubmit {
                self.presenter?.submitExercise(param: _param)
            }
        } else {
            self.currentIndex += 1
            lblIndexQuestion.text = "\(self.currentIndex)/\(numberQuestion)"
            clvQuestion.scrollToItem(at: IndexPath(row: self.currentIndex - 1, section: 0), at: .right, animated: false)
//            vCountTime.setupTimeStartNow(min: arrTime[self.currentIndex - 1])
        }
    }
    
    var paramSubmit : SubmitExerciseParam?
    
    func addDataCell(indexPath: IndexPath) -> [QuestionChoiceResultParam]? {
        if let cell = clvQuestion.cellForItem(at: indexPath) as? CellExercise {
            return cell.listAnswer
        }
        if let cell = clvQuestion.cellForItem(at: indexPath) as? CellFillExercise {
            return cell.listAnswer
        }
        return nil
    }
    
    var numberQuestion : Int = 0
    var currentTime : Int = 0
    
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var lblIndexQuestion: UILabel!
    @IBOutlet weak var clvQuestion: UICollectionView!
    @IBOutlet weak var vCountTime: ViewTime!
    var typeExercise: TypeDoExercise = .createExercise
    
//    var arrTime : [Int] = []
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
//            self.arrTime[self.currentIndex] = 0
            vCountTime.stopTimer()
            if self.currentIndex < numberQuestion {
                self.currentIndex = numberQuestion
                lblIndexQuestion.text = "\(self.currentIndex)/\(numberQuestion)"
                clvQuestion.scrollToItem(at: IndexPath(row: self.currentIndex - 1, section: 0), at: .right, animated: false)
//                vCountTime.setupTimeStartNow(min: arrTime[self.currentIndex - 1])
            } else {
//                self.presenter?.gotoResult()
            }
            self.disableUserInteractionCell()
        }
    }
    
    var listAnswerQuestion : [QuestionSubmitParam] = []
    var idExercise : String = ""
    
    override func setUpViews() {
        super.setUpViews()
//        clvQuestion.isHidden = true
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
//            arrTime[self.currentIndex-1] = vCountTime.getCurrentTime()
            if !isEnd {
                self.currentIndex -= 1
                lblIndexQuestion.text = "\(self.currentIndex)/\(numberQuestion)"
                clvQuestion.scrollToItem(at: IndexPath(row: self.currentIndex - 1, section: 0), at: .left, animated: false)
            }
            
//            vCountTime.setupTimeStartNow(min: arrTime[self.currentIndex-1])
        }
    }
    
    func confirmOutExercise(){
        self.presenter?.exitExercise(id: self.presenter?.getIDExercise() ?? 0)
    }
}

extension NameExerciseViewController :NameExerciseViewProtocol{
    func suggesQuestionSuccessed(indexPath: IndexPath, indexQuestion: IndexPath) {
        if let cell = clvQuestion.cellForItem(at: indexPath) as? CellExercise, let dataCell =  self.presenter?.getQuestion(indexPath: indexPath){
            cell.changeDataSource(index: indexQuestion, data: dataCell.answers ?? [])
        }
    }
    
    func reloadView() {
        setTitleNavigation(title: self.presenter?.getNameExercise() ?? "")
        self.numberQuestion = self.presenter?.getNumber() ?? 0
        self.currentTime = self.presenter?.getAllTime() ?? 0
//          self.currentTime = 10
//        self.arrTime = self.presenter?.getAllTime() ?? []
        lblIndexQuestion.text = "1/\(numberQuestion)"
        if let _listIdQuestion = self.presenter?.getAllIdAndTimeQuestion() {
            self.listAnswerQuestion = _listIdQuestion.map{QuestionSubmitParam(_id: $0,time: $1)}
        }
        if let _id = self.presenter?.getIDExercise(), let _totalTime = self.presenter?.getTotalTime() {
            paramSubmit = SubmitExerciseParam(exercise_id: _id, total_time: _totalTime)
        }
//        vCountTime.setupTime(min: self.arrTime[0])
        vCountTime.setupTimeStartNow(min: self.currentTime)
        clvQuestion.reloadData()
    }
    
    func getExerciseFailed(error: APIError) {
        PopUpHelper.shared.showError(message: error.message&) {
        }
    }
    func exitSuccessed() {
        self.exerciseDelegate?.confirmOutTestEntrance()
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
         return self.presenter?.getNumber() ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let data = self.presenter?.getQuestion(indexPath: indexPath){
            let type = data.answers?.first?.type ?? ""
            if type == "" || type == "2"{
                let cell =  collectionView.dequeueCell(CellFillExercise.self, indexPath: indexPath)
                cell.setupCell(data: data)
                return cell
            }
            let cell = collectionView.dequeueCell(CellExercise.self, indexPath: indexPath)
            cell.indexPath = indexPath
            cell.delegate = self
            cell.setupCell(dataCell: data)
            return cell
        }
        return UICollectionViewCell()
    }
}

extension NameExerciseViewController : CellExerciseDelegate{
    func suggestQuestion(id: String, indexPath: IndexPath, indexQuestion: IndexPath) {
        PopUpHelper.shared.showSuggesstionResult(diamond: {
            self.presenter?.suggestQuestion(id: id,indexPath: indexPath, indexQuestion: indexQuestion)
        }) {
            self.presenter?.suggestQuestion(id: id,indexPath: indexPath, indexQuestion: indexQuestion)
        }
    }
    
    func showDetailVocubulary(text: String) {
        self.presenter?.gotoDetailVocabulary()
    }
}

extension NameExerciseViewController : TimeDelegate{
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

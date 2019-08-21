//
//  FightViewController.swift
//  EnglishApp
//
//  Created Steve on 8/10/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit
import Popover

class FightViewController: BaseViewController {
    
    var presenter: FightPresenterProtocol?

    @IBOutlet weak var lblPointTeam: UILabel!
    @IBOutlet weak var lblRankTeam: UILabel!
    @IBOutlet weak var heightViewRank: NSLayoutConstraint!
    @IBOutlet weak var clvRankTeam: UICollectionView!
    @IBOutlet weak var lblTitleRank: UILabel!
    
    @IBAction func clickNext(_ sender: Any) {
        if self.currentIndex == numberQuestion {
            isOut = true
        }
        self.submit()
    }
    
    var numberQuestion : Int = 0
    var currentTime : Int = 0
    var listParamSubmit : [SubmitCompetitionQuestionResponse] = []
    var completion_id : Int = 0
    var team_id : Int = 0
    var isOut = false
    
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var lblIndexQuestion: UILabel!
    @IBOutlet weak var clvQuestion: UICollectionView!
    @IBOutlet weak var vCountTime: ViewTime!
    
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
            self.submit()
        }
    }
    
    override func setUpViews() {
        super.setUpViews()
        lblTitleRank.text = LocalizableKey.rank_of_competition.showLanguage
        btnNext.setTitle(LocalizableKey.next.showLanguage.uppercased(), for: .normal)
        clvQuestion.registerXibCell(CellFillExercise.self)
        clvQuestion.registerXibCell(CellExercise.self)
        clvQuestion.delegate = self
        clvQuestion.dataSource = self
        clvRankTeam.registerXibCell(CellRankTeam.self)
        clvRankTeam.delegate = self
        clvRankTeam.dataSource = self
        vCountTime.disableClick = true
        vCountTime.delegate = self
        self.presenter?.getViewFightCompetition(id: String(self.completion_id))
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
//        if !isEnd {
        PopUpHelper.shared.showComfirmPopUp(message: LocalizableKey.popleaveHomeWork.showLanguage, titleYes: LocalizableKey.confirm.showLanguage.uppercased(), titleNo: LocalizableKey.cancel.showLanguage.uppercased(), complete: { [unowned self] in
            self.submit()
            self.notifyOutCompetition()
//                self.confirmOutExercise()
        })
//        }
    }
    
    private func submit() {
        if listParamSubmit.count > 0 {
            self.presenter?.submitAnswer(param: self.listParamSubmit[self.currentIndex - 1])
        }
    }
    
    private func notifyOutCompetition() {
        NotificationCenter.default.post(name: NSNotification.Name("LeaveCompetition"), object: nil, userInfo: nil)
    }
    
    override func btnBackTapped() {
//        if isEnd {
//            PopUpHelper.shared.showComfirmPopUp(message: LocalizableKey.popleaveHomeWork.showLanguage, titleYes: LocalizableKey.confirm.showLanguage.uppercased(), titleNo: LocalizableKey.cancel.showLanguage.uppercased(), complete: { [unowned self] in
//                self.submit()
//                self.notifyOutCompetition()
//            })
//        }
    }
    
    func confirmOutExercise(){
        self.presenter?.exitExercise(id: Int(self.presenter?.exerciseEntity?._id ?? "0") ?? 0)
    }
}

extension FightViewController :FightViewProtocol{
    func submitCompetitionSuccessed() {
        if !isOut {
            DispatchQueue.global().async {
                self.currentIndex += 1
                var teamRank: Int = 0
                var teamInfor : RankTeamEntity?
                for (index,infor) in (self.presenter?.listRank ?? []).enumerated() {
                    if let teamId = Int(infor.team_id ?? "0"), teamId == self.team_id {
                        teamRank = index + 1
                        teamInfor = infor
                    }
                }
                DispatchQueue.main.async {
                    if self.currentIndex <= self.numberQuestion && !self.isEnd {
                        self.lblIndexQuestion.text = "\(self.currentIndex)/\(self.numberQuestion)"
                        self.clvQuestion.scrollToItem(at: IndexPath(row: self.currentIndex - 1, section: 0), at: .right, animated: false)
                        self.clvRankTeam.reloadData()
                        self.lblPointTeam.text = "\(teamInfor?.total_score ?? "0") " + LocalizableKey.point.showLanguage
                        self.lblRankTeam.text = LocalizableKey.rank.showLanguage + " \(teamRank)"
                    } else {
                        //go to result -> tranform id.
                        
                        
                    }
                }
            }
        } else {
            self.push(controller: ResultCompetitionRouter.createModule(idCompetition: String(completion_id)))
        }
    }
    
    func exitSuccessed() {
        
    }
    
    func suggestQuestionError() {
        
    }
    
    func suggesQuestionSuccessed(indexPath: IndexPath, indexQuestion: IndexPath) {
        if let cell = clvQuestion.cellForItem(at: indexPath) as? CellExercise, let dataCell =  self.presenter?.exerciseEntity?.questions?[indexPath.row]{
            cell.changeDataSource(index: indexQuestion, data: dataCell.answers ?? [])
        }
    }
    
    func reloadView() {
        DispatchQueue.global().async {
            self.numberQuestion = self.presenter?.exerciseEntity?.questions?.count ?? 0
            self.currentTime = self.presenter?.exerciseEntity?.total_times ?? 0
            if let questions = self.presenter?.exerciseEntity?.questions {
                for item in questions {
                    let object = SubmitCompetitionQuestionResponse(competition_id: self.completion_id, team_id: self.team_id)
                    let submitQuestion : SubmitQuestionEntity = SubmitQuestionEntity()
                    submitQuestion.question_id = Int(item._id ?? "0") ?? 0
                    submitQuestion.sequence = Int(item.sequence ?? "0") ?? 0
                    let listAnswerSubmit = item.answers?.map{SubmitAnswerEntity(question_details_id: Int($0._id ?? "0") ?? 0)} ?? []
                    submitQuestion.answers = listAnswerSubmit
                    object.questions = submitQuestion
                    self.listParamSubmit.append(object)
                }
            }
            DispatchQueue.main.async {
                self.lblIndexQuestion.text = "1/\(self.numberQuestion)"
                self.setTitleNavigation(title: self.presenter?.exerciseEntity?.name ?? "")
                self.vCountTime.setupTimeStartNow(min: self.currentTime)
                self.clvQuestion.reloadData()
                ProgressView.shared.hideLoadingCompetition()
            }
        }
    }
    
    func getExerciseFailed(error: APIError) {
        PopUpHelper.shared.showError(message: error.message&) {
        }
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

extension FightViewController : UICollectionViewDelegate{
}

extension FightViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.00009
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == clvQuestion {
            return CGSize(width: self.clvQuestion.frame.width, height: self.clvQuestion.frame.height)
        }
        if collectionView == clvRankTeam {
            return CGSize(width: 150, height: clvRankTeam.frame.height)
        }
        return CGSize(width: 0, height: 0)
    }
}

extension FightViewController: UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == clvQuestion {
            return self.presenter?.exerciseEntity?.questions?.count ?? 0
        }
        
        if collectionView == clvRankTeam {
            let row = self.presenter?.listRank.count ?? 0
            if row == 0 {
                heightViewRank.constant = 0
            } else {
                heightViewRank.constant = 80
            }
            return row
        }
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == clvQuestion {
            if let data = self.presenter?.exerciseEntity?.questions?[indexPath.row]{
                let type = data.answers?.first?.type ?? ""
                if type == "" || type == "2"{
                    let cell =  collectionView.dequeueCell(CellFillExercise.self, indexPath: indexPath)
                    cell.type = .competition
                    cell.indexPath = indexPath
                    cell.listAnswerCompetition = self.listParamSubmit[indexPath.row].questions?.answers ?? []
                    cell.setupCell(data: data)
                    cell.delegate = self
                    return cell
                }
                let cell = collectionView.dequeueCell(CellExercise.self, indexPath: indexPath)
                cell.indexPath = indexPath
                cell.type = .competition
                cell.listIdOption = (data.answers ?? []).map{$0.options.map{Int($0._id ?? "0") ?? 0}}
                cell.listDataSource = (data.answers ?? []).map{$0.options.map{$0.value ?? ""}}
                cell.listAnswerCompetition = self.listParamSubmit[indexPath.row].questions?.answers ?? []
                cell.setupCell(dataCell: data)
                cell.delegate = self
                return cell
            }
        }
        
        if collectionView == clvRankTeam {
            let cell = collectionView.dequeueCell(CellRankTeam.self, indexPath: indexPath)
            if let dataCell = self.presenter?.listRank[indexPath.row]{
                cell.setupCell(dataCell: dataCell)
            }
            return cell
        }
        
        return UICollectionViewCell()
    }
}

extension FightViewController : CellExerciseDelegate{
    
    
    func changeAnswer(idAnswer: Int, valueAnswer: String, indexPathRow: IndexPath, indexPath: IndexPath) {
        self.listParamSubmit[indexPath.row].questions?.answers[indexPathRow.row].option_id = idAnswer
        self.listParamSubmit[indexPath.row].questions?.answers[indexPathRow.row].value = valueAnswer
    }
    
    func showDetailVocubulary(word: WordExplainEntity) {
//        self.presenter?.gotoDetailVocabulary(word: word)
    }
    
    func searchVocabulary(word: String, position: CGPoint, index: IndexPath) {
        self.presenter?.searchVocabulary(word: word, position: position, index: index)
    }
    
    func suggestQuestion(id: String, indexPath: IndexPath, indexQuestion: IndexPath) {
    }
}

extension FightViewController : TimeDelegate{
    func changeTime() {
        if listParamSubmit.count > 0 {
            self.listParamSubmit[self.currentIndex - 1].time += 1
        }
    }
    
    func startTime() {
        btnNext.isUserInteractionEnabled = true
        clvQuestion.isHidden = false
    }
    
    func endTime() {
        self.isEnd = true
    }
    
    func pauseTime() {
//        btnNext.isUserInteractionEnabled = false
//        clvQuestion.isHidden = true
    }
}

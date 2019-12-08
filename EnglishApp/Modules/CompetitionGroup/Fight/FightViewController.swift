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
//import Popover
import AVKit
import AVFoundation

class FightViewController: BaseViewController {
    
    var presenter: FightPresenterProtocol?

    @IBOutlet weak var viewRank: UIView!
    @IBOutlet weak var imgMyTeam: UIImageView!
    @IBOutlet weak var lblPointTeam: UILabel!
    @IBOutlet weak var lblRankTeam: UILabel!
    @IBOutlet weak var heightViewRank: NSLayoutConstraint!
    @IBOutlet weak var clvRankTeam: UICollectionView!
    @IBOutlet weak var lblTitleRank: UILabel!
    
    @IBAction func clickNext(_ sender: Any) {
        if player != nil {
            player?.pause()
            player = nil
        }
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
    var startDate : Date = Date()
    var fightFinished : (() -> ())?
    var endDateCompetition: Date?
    var player : AVPlayer?
    var playerItem : AVPlayerItem?
    var isReapeat = false
    
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var lblIndexQuestion: UILabel!
    @IBOutlet weak var clvQuestion: UICollectionView!
    @IBOutlet weak var vCountTime: ViewTime!
    
    var currentIndex = 1 {
        didSet{
            if self.currentIndex == numberQuestion {
                btnNext.setTitle(LocalizableKey.time_end.showLanguage.uppercased(), for: .normal)
            } else {
                btnNext.setTitle(LocalizableKey.next.showLanguage.uppercased(), for: .normal)
            }
        }
    }
    
    var isEnd : Bool = false {
        didSet {
            btnNext.setTitle(LocalizableKey.time_end.showLanguage.uppercased(), for: .normal)
            vCountTime.stopTimer()
            self.submit()
        }
    }
    
    override func setUpViews() {
        super.setUpViews()
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player, queue: .main) { [weak self] _ in
            self?.playerItem?.seek(to: CMTime.zero, completionHandler: nil)
            self?.isReapeat = true
        }
        lblTitleRank.text = LocalizableKey.rank_of_competition.showLanguage
        btnNext.setTitle(LocalizableKey.next.showLanguage.uppercased(), for: .normal)
//        clvQuestion.registerXibCell(CellFillExercise.self)
        clvQuestion.registerXibCell(CellExercise.self)
        clvQuestion.delegate = self
        clvQuestion.dataSource = self
        clvRankTeam.registerXibCell(CellRankTeam.self)
        clvRankTeam.delegate = self
        clvRankTeam.dataSource = self
        vCountTime.disableClick = true
        vCountTime.delegate = self
        self.presenter?.getViewFightCompetition(id: String(self.completion_id))
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(true)
        if player != nil {
            player?.pause()
            player = nil
        }
    }
    
    override func setUpNavigation() {
        super.setUpNavigation()
        addBackToNavigation()
        addButtonToNavigation(image: UIImage(named:"Material_Icons_white_chevron_left_Copy") ?? UIImage(), style: .right, action: #selector(deleteExercise))
    }
    
    func disableUserInteractionCell(){
        clvQuestion.isUserInteractionEnabled = false
    }
    
    @objc func deleteExercise(){
//        if !isEnd {
        PopUpHelper.shared.showComfirmPopUp(message: LocalizableKey.popleaveHomeWork.showLanguage, titleYes: LocalizableKey.confirm.showLanguage.uppercased(), titleNo: LocalizableKey.cancel.showLanguage.uppercased(), complete: { [unowned self] in
            self.isOut = true
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
        fightFinished?()
    }
    
    override func btnBackTapped() {
    }
    
    func confirmOutExercise(){
        self.presenter?.exitExercise(id: Int(self.presenter?.exerciseEntity?._id ?? "0") ?? 0)
    }
}

extension FightViewController :FightViewProtocol{
    func submitCompetitionSuccessed() {
        if !isOut {
            DispatchQueue.global().async {
                var teamRank: Int = 0
                var teamInfor : RankTeamEntity?
                for (index,infor) in (self.presenter?.listRank ?? []).enumerated() {
                    if let teamId = Int(infor.team_id ?? "0"), teamId == self.team_id {
                        teamRank = index + 1
                        teamInfor = infor
                    }
                }
                DispatchQueue.main.async {
                    self.currentIndex += 1
                    if self.currentIndex <= self.numberQuestion && !self.isEnd {
                        self.lblPointTeam.attributedText = NSAttributedString(string: "\(teamInfor?.total_score ?? "0") " + LocalizableKey.point.showLanguage)
                        self.lblRankTeam.attributedText = NSAttributedString(string: LocalizableKey.rank.showLanguage + " \(teamRank)")
                        self.lblIndexQuestion.attributedText = NSAttributedString(string: "\(self.currentIndex)/\(self.numberQuestion)")
                        self.imgMyTeam.sd_setImage(with: URL(string: BASE_URL_IMAGE + (teamInfor?.img_src ?? "")), placeholderImage: #imageLiteral(resourceName: "ic_avatar_default") , completed: nil)
                        self.clvQuestion.scrollToItem(at: IndexPath(row: self.currentIndex - 1, section: 0), at: .right, animated: false)
                        if self.viewRank.isHidden  {
                            self.viewRank.isHidden = false
                            //update height collection view height.
                            self.clvQuestion.collectionViewLayout.invalidateLayout()
                        }
                        self.clvRankTeam.reloadData()
                    }
                }
            }
        } else {
            self.fightFinished?()
            self.push(controller: ResultGroupRouter.createModule(idCompetition: String(completion_id), idExercise: self.presenter?.exerciseEntity?._id ?? "0", isHistory: false, endDate: self.endDateCompetition ?? Date()))
        }
    }
    
    func submitFailed() {
        if isEnd {
            self.fightFinished?()
            self.push(controller: ResultGroupRouter.createModule(idCompetition: String(completion_id), idExercise: self.presenter?.exerciseEntity?._id ?? "0", isHistory: false, endDate: self.endDateCompetition ?? Date()))
        } else {
            let message = self.presenter?.error?.message
            if message == LocalizableKey.fight_is_done.showLanguage.uppercased() {
                self.fightFinished?()
                self.push(controller: ResultGroupRouter.createModule(idCompetition: String(completion_id), idExercise: self.presenter?.exerciseEntity?._id ?? "0", isHistory: false, endDate: self.endDateCompetition ?? Date()))
            }
        }
    }
    
    func exitSuccessed() {
        
    }
    //use for exercise
    func suggestQuestionError() {
        
    }
    //use for exercise
    func suggesQuestionSuccessed(indexPath: IndexPath, indexQuestion: IndexPath) {
//        if let cell = clvQuestion.cellForItem(at: indexPath) as? CellExercise {
//            cell.changeDataSource(index: indexQuestion)
//        }
    }
    
    func reloadView() {
        DispatchQueue.global().async {
            self.numberQuestion = self.presenter?.exerciseEntity?.questions?.count ?? 0
            self.currentTime = self.presenter?.exerciseEntity?.total_times ?? 0
            let currentStartTime = Date().timeIntervalSince1970
            let startTime = self.startDate.timeIntervalSince1970
            let distanceTime = Int(currentStartTime - startTime)
            if distanceTime >= self.currentTime {
                DispatchQueue.main.async {
                    self.view.isHidden = true
                    PopUpHelper.shared.showErrorDidNotRemoveView(message: LocalizableKey.competition_end.showLanguage, completionYes: {
                        self.pop(animated: true)
                    })
                }
            } else {
                self.currentTime = self.currentTime - distanceTime
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
    }
    
    func getExerciseFailed(error: APIError) {
        let message = error.message ?? ""
        switch message {
        case LocalizableKey.exercise_is_doing.showLanguage.uppercased():
            PopUpHelper.shared.showErrorDidNotRemoveView(message: LocalizableKey.fight_is_doing.showLanguage) {[unowned self] in
                self.navigationController?.popViewController(animated: true)
            }
        default:
            PopUpHelper.shared.showErrorDidNotRemoveView(message: message.convertFormatString()) { [unowned self] in
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    //use for exercise
    func searchVocabularySuccessed(wordEntity: WordExplainEntity, position: CGPoint,index: IndexPath) {
//        if let cell = self.clvQuestion.cellForItem(at: index) as? CellFillExercise{
//            cell.setupPopOver(x: position.x, y: position.y, word: wordEntity)
//        }
//
//        if let cell = self.clvQuestion.cellForItem(at: index) as? CellExercise{
//            cell.setupPopOver(x: position.x, y: position.y, word: wordEntity)
//        }
    }
    
    func fightDone() {
        PopUpHelper.shared.showErrorDidNotRemoveView(message: LocalizableKey.fight_is_done.showLanguage) {[unowned self] in
            self.navigationController?.popViewController(animated: true)
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
            return CGSize(width: 130, height: clvRankTeam.frame.height)
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
            return row
        }
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == clvQuestion {
            if let data = self.presenter?.exerciseEntity?.questions?[indexPath.row]{
                let cell = collectionView.dequeueCell(CellExercise.self, indexPath: indexPath)
                cell.indexPath = indexPath
                cell.type = .competition
                cell.listAnswerCompetition = self.listParamSubmit[indexPath.row].questions?.answers ?? []
                cell.questionEntity = data
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

extension FightViewController : CellExerciseDelegate {
    //use for exercise
    func showDetailVocubulary(word: WordExplainEntity) {
        
    }
    //use for exercise
    func suggestQuestion(id: String, indexPath: IndexPath, indexQuestion: IndexPath) {
        
    }
    //use for exercise
    func searchVocabulary(word: String, position: CGPoint, index: IndexPath) {
        
    }
    
    func clickAudio(indexPath: IndexPath) {
        var numberClick = self.presenter?.exerciseEntity?.questions?[indexPath.row].numberClick ?? 0
        numberClick += 1
        self.presenter?.exerciseEntity?.questions?[indexPath.row].numberClick = numberClick
        
        if let linkAudio = self.presenter?.exerciseEntity?.questions?[indexPath.row].link_audio, let url = URL(string: BASE_URL + linkAudio) {
            if numberClick == 1 {
                self.playerItem = AVPlayerItem(url: url)
                player = AVPlayer(playerItem: playerItem)
                player?.play()
            } else {
                if player != nil {
                    if self.isReapeat {
                        player?.play()
                        self.isReapeat = false
                    } else {
                        if numberClick % 2 == 0 {
                            player?.pause()
                        } else {
                            player?.play()
                        }
                    }
                }
            }
        }
    }
}

extension FightViewController : TimeDelegate{
    func changeTime() {
        if listParamSubmit.count > 0 {
            self.listParamSubmit[self.currentIndex - 1].time += 1000
        }
    }
    
    func startTime() {
    }
    
    func endTime() {
        self.isOut = true
        self.isEnd = true
        if player != nil {
            player?.pause()
            player = nil
        }
    }
    
    func pauseTime() {
    }
}

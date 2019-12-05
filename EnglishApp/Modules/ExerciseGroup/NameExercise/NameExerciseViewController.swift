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
//import Popover
import AVKit
import AVFoundation

protocol ExerciseDelegate: class {
    func confirmOutTestEntrance()
}

//var dateTestDaillyMisson : Date?

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
    var player : AVPlayer?
    var playerItem : AVPlayerItem?
    var isReapeat = false
    
    @IBAction func clickNext(_ sender: Any) {
        if player != nil {
            player?.pause()
            player = nil
            self.presenter?.exerciseEntity?.questions?[currentIndex - 1].numberClick = 0
        }
        if !isEnd {
            if self.currentIndex + 1 > numberQuestion {
                if let _param = self.paramSubmit {
                    _param.total_time = self.listAnswerQuestion.map{$0.time}.getSum()
                    self.presenter?.submitExercise(param: _param, isOut: false)
                }
            } else {
                self.currentIndex += 1
                lblIndexQuestion.text = "\(self.currentIndex)/\(numberQuestion)"
                clvQuestion.scrollToItem(at: IndexPath(row: self.currentIndex - 1, section: 0), at: .right, animated: true)
            }
        } else {
            if let _param = self.paramSubmit {
                _param.total_time = self.listAnswerQuestion.map{$0.time}.getSum()
                self.presenter?.submitExercise(param: _param, isOut: false)
            }
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
                btnNext.setTitle(LocalizableKey.time_end.showLanguage.uppercased(), for: .normal)
            } else {
                btnNext.setTitle(LocalizableKey.next.showLanguage.uppercased(), for: .normal)
            }
        }
    }
    
    var isEnd : Bool = false {
        didSet {
            vCountTime.stopTimer()
            btnNext.setTitle(LocalizableKey.time_end.showLanguage.uppercased(), for: .normal)
            self.vCountTime.isUserInteractionEnabled = false
            self.disableUserInteractionCell()
        }
    }
    
    var isPauseTime = false {
        didSet{
            if isPauseTime {
                btnNext.isUserInteractionEnabled = false
                clvQuestion.isUserInteractionEnabled = false
            } else {
                btnNext.isUserInteractionEnabled = true
                clvQuestion.isUserInteractionEnabled = true
            }
        }
    }
    
    override func setUpViews() {
        super.setUpViews()
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player, queue: .main) { [weak self] _ in
            self?.playerItem?.seek(to: CMTime.zero, completionHandler: nil)
            self?.isReapeat = true
        }
        btnNext.setTitle(LocalizableKey.next.showLanguage.uppercased(), for: .normal)
        clvQuestion.dataSource = self
        clvQuestion.delegate = self
        clvQuestion.registerXibCell(CellExercise.self)
        vCountTime.delegate = self
        self.presenter?.type = self.typeExercise
        switch typeExercise {
        case .dailyMissonExercise:
            self.presenter?.getDailyMisson()
        case .entranceExercise:
            self.presenter?.getViewEntranceTest()
        default:
            if self.presenter?.exerciseEntity == nil {
                self.presenter?.getViewExercise(id: self.idExercise)
            } else {
                self.parseAnswer()
                self.updateUI()
            }
             
        }
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
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
        if !isPauseTime {
            PopUpHelper.shared.showComfirmPopUp(message: LocalizableKey.popleaveHomeWork.showLanguage, titleYes: LocalizableKey.confirm.showLanguage.uppercased(), titleNo: LocalizableKey.cancel.showLanguage.uppercased(), complete: { [unowned self] in
                self.confirmOutExercise()
            })
        }
    }
    
    override func btnBackTapped() {
        if !isPauseTime {
            if self.currentIndex == 1 {
                PopUpHelper.shared.showComfirmPopUp(message: LocalizableKey.popleaveHomeWork.showLanguage, titleYes: LocalizableKey.confirm.showLanguage.uppercased(), titleNo: LocalizableKey.cancel.showLanguage.uppercased(), complete: { [unowned self] in
                    self.confirmOutExercise()
                })
            } else {
                if !isEnd {
                    self.currentIndex -= 1
                    lblIndexQuestion.text = "\(self.currentIndex)/\(numberQuestion)"
                    clvQuestion.scrollToItem(at: IndexPath(row: self.currentIndex - 1, section: 0), at: .left, animated: true)
                }
            }
        }
    }
    
    func confirmOutExercise(){
        if let _param = self.paramSubmit {
            _param.total_time = self.listAnswerQuestion.map{$0.time}.getSum()
            self.presenter?.submitExercise(param: _param, isOut: true)
        }
    }
}

extension NameExerciseViewController :NameExerciseViewProtocol{
    func suggestQuestionError() {
        PopUpHelper.shared.showError(message: LocalizableKey.diamod_not_enough.showLanguage) {
            
        }
    }
    
    func suggesQuestionSuccessed(indexPath: IndexPath, indexQuestion: IndexPath, isDiamond: Bool) {
        let infor = UserDefaultHelper.shared.loginUserInfo
        if let _infor = infor, let diamond = _infor.amountDiamond {
            _infor.amountDiamond = diamond - 1
            UserDefaultHelper.shared.loginUserInfo = _infor
        }
        
        NotificationCenter.default.post(name: NSNotification.Name.init("SuggestionQuestion"), object: nil, userInfo: ["isDiamond" : isDiamond])
        
        if let cell = clvQuestion.cellForItem(at: indexPath) as? CellExercise {
            cell.changeDataSource(index: indexQuestion)
        }
    }
    
    private func parseAnswer(){
        self.idExercise = self.presenter?.exerciseEntity?._id ?? "0"
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
    }
    
    private func updateUI() {
        self.setTitleNavigation(title: self.presenter?.exerciseEntity?.name ?? "")
        self.lblIndexQuestion.text = "1/\(self.numberQuestion)"
        self.vCountTime.setupTimeStartNow(min: self.currentTime)
    }
    
    func reloadView() {
        DispatchQueue.global().async {
            self.parseAnswer()
            DispatchQueue.main.async {
                self.updateUI()
                ProgressView.shared.hide()
                self.clvQuestion.reloadData()
            }
        }
    }
    
    func getExerciseFailed(error: APIError) {
        if typeExercise == .dailyMissonExercise {
            PopUpHelper.shared.showErrorDidNotRemoveView(message: LocalizableKey.the_dally_misson_tested.showLanguage) {
                self.pop(animated: true)
            }
        } else {
            PopUpHelper.shared.showErrorDidNotRemoveView(message: LocalizableKey.exercise_is_doing.showLanguage) {
                self.pop(animated: true)
            }
        }
    }
    
    func exitSuccessed() {
        self.exerciseDelegate?.confirmOutTestEntrance()
    }
    
    func searchVocabularySuccessed(wordEntity: WordExplainEntity, position: CGPoint,index: IndexPath) {
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.clvQuestion.frame.width, height: self.clvQuestion.frame.height)
    }
}
extension NameExerciseViewController: UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.presenter?.exerciseEntity?.questions?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let data = self.presenter?.exerciseEntity?.questions?[indexPath.row]{
            let cell = collectionView.dequeueCell(CellExercise.self, indexPath: indexPath)
            cell.callbackShowPopup = {[weak self] (fromView: UIView, point: CGPoint, word: WordExplainEntity) in
                let pointConvert = fromView.convert(point, to: self?.view ?? UIView())
                self?.showPopoverVocabulary(x: pointConvert.x, y: pointConvert.y, size: CGSize.zero, word: word)
            }
            cell.type = self.typeExercise
            cell.indexPath = indexPath
            cell.listAnswer = listAnswerQuestion[indexPath.row].answer ?? []
            cell.questionEntity = data
            cell.delegate = self
            return cell
        }
        return UICollectionViewCell()
    }
}

extension NameExerciseViewController : CellExerciseDelegate{
    
    func changeAnswer(idAnswer: Int?, valueAnswer: String?, indexPathRow: IndexPath, indexPath: IndexPath) {
//        self.listAnswerQuestion[indexPath.row].answer?[indexPathRow.row].option_id = idAnswer
//        self.listAnswerQuestion[indexPath.row].answer?[indexPathRow.row].value = valueAnswer
    }
    
    func showDetailVocubulary(word: WordExplainEntity) {
//        self.presenter?.gotoDetailVocabulary(idWord: word.id)
    }

    func suggestQuestion(id: String, indexPath: IndexPath, indexQuestion: IndexPath) {
        let isShowSuggestion = self.presenter?.exerciseEntity?.questions?[indexPath.row].answers?[indexQuestion.section].isShowSuggestQuestion ?? false
        if !isShowSuggestion {
            let numberDiamond = UserDefaultHelper.shared.loginUserInfo?.amountDiamond ?? 0
            if numberDiamond >= 1 {
                PopUpHelper.shared.showComfirmPopUp(message: LocalizableKey.minus_dianmod.showLanguage, titleYes: LocalizableKey.confirm.showLanguage.uppercased(), titleNo: LocalizableKey.cancel.showLanguage.uppercased(), height: 150, complete: {
                    self.presenter?.suggestQuestion(id: id,indexPath: indexPath, indexQuestion: indexQuestion, isDiamond: true)
                }, cancel: nil)
            } else {
                PopUpHelper.shared.showError(message: LocalizableKey.diamod_not_enough.showLanguage) {
                    
                }
            }
        } else {
            PopUpHelper.shared.showError(message: LocalizableKey.suggestion_one_choice.showLanguage) {
                
            }
        }
    }
    
    func searchVocabulary(word: String, position: CGPoint,index: IndexPath) {
        let id_dictionary = self.presenter?.exerciseEntity?.default_dict_id ?? "0"
        self.presenter?.searchVocabulary(word: word, id_dictionary: id_dictionary, position: position, index: index)
    }
        
    func clickAudio(indexPath: IndexPath) {
        var numberClick = self.presenter?.exerciseEntity?.questions?[indexPath.row].numberClick ?? 0
        numberClick += 1
        self.presenter?.exerciseEntity?.questions?[indexPath.row].numberClick = numberClick
        
        if let linkAudio = self.presenter?.exerciseEntity?.questions?[indexPath.row].link_audio, let url = URL(string: BASE_URL + linkAudio) {
            if numberClick == 1 {
                self.playerItem = AVPlayerItem(url: url)
                player = AVPlayer(playerItem: playerItem)
                try? AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [])
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
                            try? AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [])
                            player?.play()
                        }
                    }
                }
            }
        }
    }
}

extension NameExerciseViewController : TimeDelegate{
    func changeTime() {
        self.listAnswerQuestion[self.currentIndex - 1].time += 1000
    }
    
    func startTime() {
        isPauseTime = false
        if player != nil {
            player?.play()
        }
    }
    
    func endTime() {
        self.isEnd = true
        if player != nil {
            player?.pause()
            player = nil
            self.presenter?.exerciseEntity?.questions?[currentIndex - 1].numberClick = 0
        }
    }
    
    func pauseTime() {
        isPauseTime = true
        if player != nil {
            player?.pause()
        }
    }
}

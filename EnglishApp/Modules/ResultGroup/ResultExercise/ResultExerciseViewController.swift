//
//  ResultExerciseViewController.swift
//  EnglishApp
//
//  Created vinova on 6/25/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class ResultExerciseViewController: BaseViewController {
  

	var presenter: ResultExercisePresenterProtocol?
    
    @IBAction func clickNext(_ sender: Any) {
        let numberAnswer = self.presenter?.getNumberAnswer() ?? 0
        if index + 1 < numberAnswer {
            self.index += 1
            lblIndexQuestion.text = "\(index + 1)/\(numberAnswer)"
            self.clvQuestion.scrollToItem(at: IndexPath(row: self.index, section: 0), at: UICollectionView.ScrollPosition.right, animated: false)
            if index + 1 == (self.presenter?.getNumberAnswer() ?? 0) {
                btnNext.setTitle(LocalizableKey.time_end.showLanguage.uppercased(), for: .normal)
            }
        } else {
            if isHistory {
                let vc = self.navigationController?.viewControllers
                if (vc?.count ?? 0) > 2 {
                    if let view = vc?[(vc?.count ?? 3)-3] {
                        self.navigationController?.popToViewController(view, animated: true)
                    }
                } else {
                    self.pop(animated: true)
                }
            } else {
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
    }
    
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var lblIndexQuestion: UILabel!
    @IBOutlet weak var clvQuestion: UICollectionView!
    var index: Int = 0
    var tempIndex = 0
    var isHistory = false

    override func setUpViews() {
        super.setUpViews()
        
        self.tempIndex = index
        clvQuestion.registerXibCell(CellResultExercise.self)
        clvQuestion.delegate = self
        clvQuestion.dataSource = self
        btnNext.setTitle(LocalizableKey.next.showLanguage.uppercased(), for: .normal)
        lblIndexQuestion.text = "\(index + 1)/\(self.presenter?.getNumberAnswer() ?? 0)"
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.clvQuestion.scrollToItem(at: IndexPath(row: self.index, section: 0), at: UICollectionView.ScrollPosition.right, animated: false)
            if self.index + 1 == (self.presenter?.getNumberAnswer() ?? 0) {
                self.btnNext.setTitle(LocalizableKey.time_end.showLanguage.uppercased(), for: .normal)
            }
        }
    }
    
    override func btnBackTapped() {
        let numberAnswer = self.presenter?.getNumberAnswer() ?? 0
        if index != 0 && tempIndex + 1 != numberAnswer {
            self.index -= 1
            lblIndexQuestion.text = "\(index + 1)/\(self.presenter?.getNumberAnswer() ?? 0)"
            self.clvQuestion.scrollToItem(at: IndexPath(row: self.index, section: 0), at: UICollectionView.ScrollPosition.left, animated: false)
            btnNext.setTitle(LocalizableKey.next.showLanguage.uppercased(), for: .normal)
        } else {
            super.btnBackTapped()
        }
    }
    
    override func setUpNavigation() {
        super.setUpNavigation()
        self.tabBarController?.tabBar.isHidden = true
        setTitleNavigation(title: LocalizableKey.result_competion.showLanguage)
        addBackToNavigation()
        addButtonToNavigation(image: UIImage(named:"Material_Icons_white_chevron_left_Copy") ?? UIImage(), style: .right, action: #selector(deleteExercise))
    }
    
    @objc func deleteExercise(){
        PopUpHelper.shared.showComfirmPopUp(message: LocalizableKey.confirm_back_result.showLanguage, titleYes: LocalizableKey.confirm.showLanguage, titleNo: LocalizableKey.cancel.showLanguage.uppercased(), complete: {
            self.pop(animated: true)
        })
    }
}
extension ResultExerciseViewController : UICollectionViewDelegate{
    
}

extension ResultExerciseViewController : UICollectionViewDelegateFlowLayout{
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
extension ResultExerciseViewController: UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.presenter?.getNumberAnswer() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(CellResultExercise.self, indexPath: indexPath)
        cell.delegate = self
        cell.actionExplainExericse = {[weak self] (questionId,answerId) in
            self?.explainQuestion(questionId: questionId, answerId: answerId)
        }
        
        cell.actionRelatedGrammar = {[weak self] (questionId,answerId) in
            self?.seeRelatedGrammar(questionId: questionId, answerId: answerId)
        }
        cell.actionReportQuestion = {[weak self] (questionId,answerId) in
            self?.reportQuestion(questionId: questionId, answerId: answerId)
        }
        if let dataCell = self.presenter?.getAnswer(indexPath: indexPath){
            cell.dataCell = dataCell
        }
        return cell
    }
    
    func reportQuestion(questionId: Int, answerId: Int) {
        PopUpHelper.shared.showReportQuestion(cancel: {
            
        }) { [unowned self] (message) in
            self.presenter?.reportQuestion(questionDetailId: questionId, content: message ?? "")
        }
    }
    
    func seeRelatedGrammar(questionId: Int, answerId: Int) {
        let vc = RelatedGrammarRouter.createModule(id: questionId)
        self.push(controller: vc)
    }
    
    func explainQuestion(questionId: Int, answerId: Int) {
        self.gotoExplainQuestion(questionId: questionId)
    }
    
    func gotoExplainQuestion(questionId: Int) {
        guard let isUserPremium = UserDefaultHelper.shared.loginUserInfo?.isUserPremium else { return }
        if isUserPremium {
            let vc = ExplainExerciseGroupRouter.createModule(id: questionId)
            self.push(controller: vc)
        } else {
            PopUpHelper.shared.showUpdateFeature(completeUpdate: {[unowned self] in
                let vc = StoreViewController()
                self.push(controller: vc)
            }) {
                
            }
        }
    }
}

extension ResultExerciseViewController: ResultExerciseViewProtocol {
    func reportQuestionSuccessed() {
        PopUpHelper.shared.showThanks(completionYes: {
            
        })
    }
    func searchVocabularySuccessed(wordEntity: WordExplainEntity, position: CGPoint,index: IndexPath) {
        if let cell = self.clvQuestion.cellForItem(at: index) as? CellResultExercise{
            cell.setupPopOver(x: position.x, y: position.y, word: wordEntity)
        }
    }
}

extension ResultExerciseViewController : CellExerciseDelegate {
    
    func changeAnswer(idAnswer: Int, valueAnswer: String, indexPathRow: IndexPath, indexPath: IndexPath) {
        
    }
    
    func showDetailVocubulary(word: WordExplainEntity) {
        self.presenter?.gotoDetailVocabulary(idWord: word.id)
    }
    
    func suggestQuestion(id: String, indexPath: IndexPath, indexQuestion: IndexPath) {
        
    }
    
    func searchVocabulary(word: String, position: CGPoint, index: IndexPath) {
//        self.presenter?.searchVocabulary(word: word, position: position, index: index)
    }
    
    func clickAudio(indexPath: IndexPath) {
        
    }
}

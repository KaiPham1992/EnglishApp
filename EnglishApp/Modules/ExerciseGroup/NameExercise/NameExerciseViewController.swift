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


class NameExerciseViewController: BaseViewController, NameExerciseViewProtocol {

	var presenter: NameExercisePresenterProtocol?

    @IBAction func clickNext(_ sender: Any) {
        if !isEnd {
            if self.currentIndex + 1 >= 5 {
                self.isEnd = true
            }
            lblIndexQuestion.text = "\(self.currentIndex + 1)/6"
            self.currentIndex += 1
            clvQuestion.scrollToItem(at: IndexPath(row: self.currentIndex, section: 0), at: .right, animated: true)
            return
        }
        self.presenter?.gotoResult()
    }
    
    @IBAction func suggestResult(_ sender: Any) {
        PopUpHelper.shared.showSuggesstionResult(diamond: {
        
        }) {
        
        }
    }
    
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var lblIndexQuestion: UILabel!
    @IBOutlet weak var clvQuestion: UICollectionView!
    @IBOutlet weak var vCountTime: ViewTime!
    var currentIndex = 0
    var isEnd : Bool = false{
        didSet {
            btnNext.setTitle(LocalizableKey.time_end.showLanguage, for: .normal)
        }
    }
    
    
//    var isShowMore = true
    override func setUpViews() {
        super.setUpViews()
        clvQuestion.registerXibCell(CellExercise.self)
        clvQuestion.delegate = self
        clvQuestion.dataSource = self
        vCountTime.setupTime(min: 2)
        vCountTime.delegate = self
    }
    
    override func setUpNavigation() {
        super.setUpNavigation()
        self.tabBarController?.tabBar.isHidden = true
        setTitleNavigation(title: LocalizableKey.level_exercise.showLanguage)
        addBackToNavigation()
        addButtonToNavigation(image: UIImage(named:"Material_Icons_white_chevron_left_Copy") ?? UIImage(), style: .right, action: #selector(deleteExercise))
    }
    @objc func deleteExercise(){
        self.pop(animated: true)
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
         return 6
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(CellExercise.self, indexPath: indexPath)
        cell.delegate = self
        return cell
    }
}

extension NameExerciseViewController : CellExerciseDelegate{
    func showMoreResulr(result: String) {
        PopUpHelper.shared.showMorePopUp(content: result)
    }
    
    func showMoreQuestion(attributed: NSMutableAttributedString) {
        PopUpHelper.shared.showMorePopUpAttributed(attributed: attributed) { (text) in
            self.presenter?.gotoDetailVocabulary()
        }
    }
    func showDetailVocubulary(text: String) {
        self.presenter?.gotoDetailVocabulary()
    }
}

extension NameExerciseViewController : TimeDelegate{
    func startTime() {
        btnNext.isUserInteractionEnabled = true
    }
    
    func endTime() {
        self.isEnd = true
    }
}

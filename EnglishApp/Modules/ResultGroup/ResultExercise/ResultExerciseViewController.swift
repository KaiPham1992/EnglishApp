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

class ResultExerciseViewController: BaseViewController, ResultExerciseViewProtocol {

	var presenter: ResultExercisePresenterProtocol?
    @IBAction func clickNext(_ sender: Any) {
        let numberAnswer = self.presenter?.getNumberAnswer() ?? 0
        if index + 1 < numberAnswer {
            self.index += 1
            lblIndexQuestion.text = "\(index + 1)/\(numberAnswer)"
            self.clvQuestion.scrollToItem(at: IndexPath(row: self.index, section: 0), at: UICollectionView.ScrollPosition.right, animated: false)
        }
    }
    
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var lblIndexQuestion: UILabel!
    @IBOutlet weak var clvQuestion: UICollectionView!
    var index: Int = 0

    override func setUpViews() {
        super.setUpViews()
        clvQuestion.registerXibCell(CellResultExercise.self)
        clvQuestion.delegate = self
        clvQuestion.dataSource = self
        lblIndexQuestion.text = "\(index + 1)/\(self.presenter?.getNumberAnswer() ?? 0)"
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.clvQuestion.scrollToItem(at: IndexPath(row: self.index, section: 0), at: UICollectionView.ScrollPosition.right, animated: false)
        }
    }
    
    override func btnBackTapped() {
        if index != 0 {
            self.index -= 1
            lblIndexQuestion.text = "\(index + 1)/\(self.presenter?.getNumberAnswer() ?? 0)"
            self.clvQuestion.scrollToItem(at: IndexPath(row: self.index, section: 0), at: UICollectionView.ScrollPosition.left, animated: false)
        } else {
            super.btnBackTapped()
        }
    }
    
    override func setUpNavigation() {
        super.setUpNavigation()
        self.tabBarController?.tabBar.isHidden = true
        setTitleNavigation(title: LocalizableKey.name_exercise.showLanguage)
        addBackToNavigation()
        addButtonToNavigation(image: UIImage(named:"Material_Icons_white_chevron_left_Copy") ?? UIImage(), style: .right, action: #selector(deleteExercise))
    }
    
    @objc func deleteExercise(){
        PopUpHelper.shared.showComfirmPopUp(message: LocalizableKey.popleaveHomeWork.showLanguage, titleYes: LocalizableKey.confirm.showLanguage, titleNo: LocalizableKey.cancel.showLanguage, complete: {
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
        if let dataCell = self.presenter?.getAnswer(indexPath: indexPath){
            cell.dataCell = dataCell
        }
        return cell
    }
}

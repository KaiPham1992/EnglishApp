//
//  ChoiceExerciseViewController.swift
//  EnglishApp
//
//  Created vinova on 5/22/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit
import DropDown


class ChoiceExerciseViewController: BaseViewController {
    @IBOutlet weak var lbExerciseLevel: UILabel!
    
    @IBAction func clickChoiceType(_ sender: Any) {
        rotateImage()
        dropDown.show()
    }
    @IBOutlet weak var imgDrop: UIImageView!
    @IBOutlet weak var lbType: UILabel!
    @IBOutlet weak var tbvChoiceExercise: UITableView!
    
    var presenter: ChoiceExercisePresenterProtocol?
    let dropDown = DropDown()
    
    //to view choiceexercise or level exercise
    var type : Int = 0
    var categoryId: String  = "0"
    var studyPackId: Int?
    var offset = 0
    
    var level = 1 {
        didSet{
            self.presenter?.getViewChoiceExercise(typeTest: type, catelogyId: Int(categoryId) ?? 0, level: level, studyPackId: self.studyPackId, offset: self.offset)
        }
    }

    @IBOutlet weak var vLine: UIView!
    override func setUpViews() {
        super.setUpViews()
        tbvChoiceExercise.registerXibFile(CellChoiceExercise.self)
        tbvChoiceExercise.dataSource = self
        tbvChoiceExercise.delegate = self
        lbExerciseLevel.text = LocalizableKey.exercise_level.showLanguage
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.setupDropDown()
        }
        self.presenter?.getViewChoiceExercise(typeTest: type, catelogyId: Int(categoryId) ?? 0, level: level, studyPackId: self.studyPackId, offset: self.offset)
        
    }
    
    func rotateImage(){
        UIView.animate(withDuration: 0.2) {
            self.imgDrop.transform = self.imgDrop.transform.rotated(by: CGFloat(Double.pi))
        }
    }
    override func setUpNavigation() {
        super.setUpNavigation()
        self.tabBarController?.tabBar.isHidden = true
        addBackToNavigation()
        setTitleNavigation(title: LocalizableKey.choice_exercise.showLanguage)
    }
    func setupDropDown(){
        dropDown.anchorView = self.vLine
        dropDown.bottomOffset = CGPoint(x: 0, y: (self.vLine.frame.height + 5))
        dropDown.selectionBackgroundColor = .clear
        dropDown.backgroundColor = UIColor.white
        dropDown.width = self.vLine.frame.width
        
        dropDown.setupCornerRadius(0)
        dropDown.dataSource = ["Elementary","Intermediate","Advanced"]
        dropDown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
            return
        }
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.dropDown.hide()
            self.offset = 0
            self.level = index + 1
            self.lbType.text = item
            self.rotateImage()
        }
        dropDown.cancelAction = {[unowned self] in
            self.rotateImage()
        }
    }
}
extension ChoiceExerciseViewController : ChoiceExerciseViewProtocol {
    func reloadView() {
        tbvChoiceExercise.reloadData()
    }
}

extension ChoiceExerciseViewController : UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let row = self.presenter?.exerciseChoiceEntity?.exercises.count ?? 0
        if row == 0 {
            showNoData()
        } else {
            hideNoData()
        }
        return row
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(CellChoiceExercise.self, for: indexPath)
        cell.level = self.level
        if let dataCell = self.presenter?.exerciseChoiceEntity?.exercises[indexPath.row] {
            cell.name = dataCell.name ?? ""
        }
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let row = self.presenter?.exerciseChoiceEntity?.exercises.count ?? 0
        if row - 1 == indexPath.row {
            self.offset += limit
            self.presenter?.getViewChoiceExercise(typeTest: type, catelogyId: Int(categoryId) ?? 0, level: level, studyPackId: self.studyPackId, offset: self.offset)
        }
    }
}
extension ChoiceExerciseViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let id = self.presenter?.exerciseChoiceEntity?.exercises[indexPath.row]._id {
            self.presenter?.gotoExercise(id: id)
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}


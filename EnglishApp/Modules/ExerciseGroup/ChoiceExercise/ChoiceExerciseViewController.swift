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

enum TypeExerxcier {
    case choice
    case level
}


class ChoiceExerciseViewController: BaseViewController, ChoiceExerciseViewProtocol {
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
    var type : TypeExerxcier = .level

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
    }
    
    func rotateImage(){
        UIView.animate(withDuration: 0.2) {
            self.imgDrop.transform = self.imgDrop.transform.rotated(by: CGFloat(Double.pi))
        }
    }
    override func setUpNavigation() {
        super.setUpNavigation()
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
        dropDown.dataSource = ["1","2","3"]
        dropDown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
            return
        }
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.dropDown.hide()
            self.lbType.text = item
            self.rotateImage()
        }
        dropDown.cancelAction = {[unowned self] in
            self.rotateImage()
        }
    }
}
extension ChoiceExerciseViewController : UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(CellChoiceExercise.self, for: indexPath)
        return cell
    }
}
extension ChoiceExerciseViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}


//
//  CreateExerciseViewController.swift
//  EnglishApp
//
//  Created vinova on 5/22/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit
import DropDown


class CreateExerciseViewController: BaseViewController, CreateExerciseViewProtocol {

	var presenter: CreateExercisePresenterProtocol?

    @IBOutlet weak var edEnterExercise: UITextField!
    @IBOutlet weak var lbNameExercise: UILabel!
    @IBOutlet weak var tbvCreateExercise: UITableView!
    let dropDown = DropDown()
   
    override func setUpViews() {
        super.setUpViews()
        tbvCreateExercise.registerXibFile(CellCreateExercise.self)
        tbvCreateExercise.dataSource = self
        tbvCreateExercise.delegate = self
        lbNameExercise.text = LocalizableKey.name_exercise.showLanguage
        edEnterExercise.placeholder = LocalizableKey.enter_name_exercise.showLanguage
        DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
            self.setupDropDown()
        }
        
    }
    override func setUpNavigation() {
        super.setUpNavigation()
        self.tabBarController?.tabBar.isHidden = true
        addBackToNavigation()
        setTitleNavigation(title: LocalizableKey.create_exercise.showLanguage)
    }
    func setupDropDown(){
        
        dropDown.selectionBackgroundColor = .clear
        dropDown.backgroundColor = UIColor(red: 255/255, green: 211/255, blue: 17/255, alpha: 1)
        dropDown.width = 135
        
        dropDown.setupCornerRadius(0)
        dropDown.dataSource = ["1","2","3"]
        dropDown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
            return
        }
        
    }
}
extension CreateExerciseViewController : UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(CellCreateExercise.self, for: indexPath)
        cell.delegate = self
        cell.indexPath = indexPath
        return cell
    }
}
extension CreateExerciseViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
extension CreateExerciseViewController : ChoiceType{
    func choiceDrop(view: UIView, indexPath: IndexPath?) {
        dropDown.anchorView = view
        dropDown.bottomOffset = CGPoint(x: 0, y: (view.frame.height))
        
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.dropDown.hide()
            let cell = self.tbvCreateExercise.cellForRow(at: indexPath!) as! CellCreateExercise
            cell.setupTitle(title: item)
        }
        dropDown.cancelAction = {[unowned self] in
            let cell = self.tbvCreateExercise.cellForRow(at: indexPath!) as! CellCreateExercise
            cell.rotateImage()
            
        }
        
        dropDown.show()
    }
}

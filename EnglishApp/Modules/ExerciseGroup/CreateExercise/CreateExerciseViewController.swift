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

    @IBAction func doExercise(_ sender: Any) {
        PopUpHelper.shared.showUpdateFeature(completeUpdate: {
            self.presenter?.gotoExercise()
        }) {
            
        }
    }
    @IBOutlet weak var lblSum: UILabel!
    @IBOutlet weak var btnDoExercise: UIButton!
    @IBOutlet weak var edEnterExercise: UITextField!
    @IBOutlet weak var lbNameExercise: UILabel!
    @IBOutlet weak var tbvCreateExercise: UITableView!
    let dropDown = DropDown()
   
    override func setUpViews() {
        super.setUpViews()
        lblSum.text = "100/100 " + LocalizableKey.sentence.showLanguage
        tbvCreateExercise.registerXibFile(CellCreateExercise.self)
        tbvCreateExercise.dataSource = self
        tbvCreateExercise.delegate = self
        lbNameExercise.text = LocalizableKey.name_exercise.showLanguage
        edEnterExercise.placeholder = LocalizableKey.enter_name_exercise.showLanguage
        btnDoExercise.setTitle(LocalizableKey.do_exercise.showLanguage, for: .normal)
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
        
        dropDown.setupCornerRadius(2)
        dropDown.dataSource = ["Elementary","Intermediate","Advanced"]
        dropDown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
            return
        }
        
    }
}
extension CreateExerciseViewController : UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
       return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let row = self.presenter?.getNumberRow() ?? 0
        return row
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(CellCreateExercise.self, for: indexPath)
        cell.setupData(title: self.presenter?.getItemIndexPath(indexPath: indexPath) ?? "")
        cell.delegate = self
        cell.indexPath = indexPath
        return cell
    }
}
extension CreateExerciseViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.presenter?.gotoChoiceExercise()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
extension CreateExerciseViewController : ChoiceType{
    func choiceDrop(view: UIView, indexPath: IndexPath?) {
        dropDown.anchorView = view
        dropDown.bottomOffset = CGPoint(x: 0, y: (view.frame.height + 5))
        
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

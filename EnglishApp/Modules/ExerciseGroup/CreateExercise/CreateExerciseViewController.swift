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


class CreateExerciseViewController: BaseViewController {
   
	var presenter: CreateExercisePresenterProtocol?

    @IBAction func textNameExerciseChange(_ sender: Any) {
        self.presenter?.changeNameExercise(name: edEnterExercise.text ?? "")
    }
    
    @IBAction func doExercise(_ sender: Any) {
        self.view.endEditing(true)
        guard let listCategories = self.presenter?.createExerciseParam.categories else{ return }
        let sum = listCategories.map{$0.number_of_question ?? 0}.getSum()
        if sum > 100 {
            PopUpHelper.shared.showError(message: "Vui lòng nhập tổng số câu hỏi không vượt quá 100.") {
                
            }
        } else if sum < 100 {
            PopUpHelper.shared.showError(message: "Vui lòng nhập đủ 100 câu.") {
                
            }
        } else {
            if let _param = self.presenter?.createExerciseParam {
                self.presenter?.gotoCreateExercise(param: _param)
            }
        }
    }
    
    @IBOutlet weak var lblSum: UILabel!
    @IBOutlet weak var btnDoExercise: UIButton!
    @IBOutlet weak var edEnterExercise: UITextField!
    @IBOutlet weak var lbNameExercise: UILabel!
    @IBOutlet weak var tbvCreateExercise: UITableView!
    let dropDown = DropDown()
    var offset = 0
   
    override func setUpViews() {
        super.setUpViews()
        tbvCreateExercise.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
        self.presenter?.getListQuestionCatelogy(offset: offset)
        lblSum.text = "0/100 " + LocalizableKey.sentence.showLanguage
        tbvCreateExercise.registerXibFile(CellCreateExercise.self)
        tbvCreateExercise.dataSource = self
        tbvCreateExercise.delegate = self
        lbNameExercise.text = LocalizableKey.name_exercise.showLanguage
        edEnterExercise.placeholder = LocalizableKey.enter_name_exercise.showLanguage
        btnDoExercise.setTitle(LocalizableKey.do_exercise.showLanguage, for: .normal)
        btnDoExercise.backgroundColor = .gray
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
        dropDown.backgroundColor = .white
        dropDown.width = 135
        dropDown.setupCornerRadius(2)
        dropDown.cellNib = UINib(nibName: "CellDropDownQuestion", bundle: nil)
        dropDown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
            if let cell = cell as? CellDropDownQuestion {
                cell.lbAnswer.font = AppFont.fontRegular14
                cell.lbAnswer.text = item
            }
            return
        }
        dropDown.dataSource = ["Elementary","Intermediate","Advanced"]
    }
}

extension CreateExerciseViewController : CreateExerciseViewProtocol{
    
    func updateView(enableSubmit: Bool) {
        if enableSubmit {
            btnDoExercise.isUserInteractionEnabled = true
            btnDoExercise.backgroundColor = #colorLiteral(red: 1, green: 0.8274509804, blue: 0.06666666667, alpha: 1)
        } else {
            btnDoExercise.isUserInteractionEnabled = false
            btnDoExercise.backgroundColor = .gray
        }
    }
    
    func upgradeAccount() {
        PopUpHelper.shared.showUpdateFeature(completeUpdate: {
            self.presenter?.gotoStore()
        }) {

        }
    }
    
    func showSumQuestion(sum: Int) {
        lblSum.text = "\(sum)/100 " + LocalizableKey.sentence.showLanguage
        if sum == 0 {
            btnDoExercise.isUserInteractionEnabled = false
            btnDoExercise.backgroundColor = .gray
        }
    }
    
    func reloadView() {
        self.tbvCreateExercise.reloadData()
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
        if let dataCell = self.presenter?.getItemIndexPath(indexPath: indexPath) {
            cell.setupData(dataCell: dataCell)
        }
        cell.delegate = self
        cell.indexPath = indexPath
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let row = self.presenter?.getNumberRow() ?? 0
        if indexPath.row == row - 2 {
            self.offset += limit
            self.presenter?.getListQuestionCatelogy(offset: self.offset)
        }
    }
}
extension CreateExerciseViewController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

extension CreateExerciseViewController : ChoiceType{
    func choiceDrop(view: UIView, indexPath: IndexPath?) {
        self.view.endEditing(true)
        dropDown.anchorView = view
        dropDown.bottomOffset = CGPoint(x: 0, y: (view.frame.height + 5))
        
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.dropDown.hide()
            let cell = self.tbvCreateExercise.cellForRow(at: indexPath!) as! CellCreateExercise
            cell.setupTitle(title: item)
            print(index)
            self.presenter?.changeLevelParam(indexPath: indexPath ?? IndexPath(row: 0, section: 0), level: index + 1)
        }
        dropDown.cancelAction = {[unowned self] in
            let cell = self.tbvCreateExercise.cellForRow(at: indexPath!) as! CellCreateExercise
            cell.rotateImage()
        }
        dropDown.show()
    }
    
    func changeNumberQuestion(number: Int, indexPath: IndexPath?) {
        self.presenter?.changeNumberQuestion(indexPath: indexPath ?? IndexPath(row: 0, section: 0), number: number)
    }
}

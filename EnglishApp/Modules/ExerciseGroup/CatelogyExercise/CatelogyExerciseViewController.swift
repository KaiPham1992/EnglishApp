//
//  CatelogyExerciseViewController.swift
//  EnglishApp
//
//  Created Steve on 7/18/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class CatelogyExerciseViewController: ListManagerVC {

	var presenter: CatelogyExercisePresenterProtocol?
    
    var typeTest = 0
    var studyPackId : Int = 0
    
    override func setUpViews() {
        if typeTest == TypeExercise.level.rawValue {
            customTitle =  LocalizableKey.level_exercise.showLanguage
        }
        if typeTest == TypeExercise.practice.rawValue {
            customTitle = LocalizableKey.try_hard.showLanguage
        }
        showButtonBack = true
        super.setUpViews()
    }
    
    override func registerTableView() {
        super.registerTableView()
        self.tableView.registerXibFile(CellLevelExercise.self)
    }
    
    override func callAPI() {
        super.callAPI()
         self.presenter?.getListCatelogy(offset: self.offset)
    }
    override func cellForRowListManager(item: Any, _ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(CellLevelExercise.self, for: indexPath)
        let data = item as! SearchEntity
        cell.lblNameExercise.text = data.name&
        return cell
    }
    
    override func didSelectTableView(item: Any, indexPath: IndexPath) {
        let data = item as! SearchEntity
        let id = data._id ?? "0"
        self.presenter?.gotoChoiceExercise(type: typeTest, categoryId: id,studyPackId: self.studyPackId)
    }
}

extension CatelogyExerciseViewController: CatelogyExerciseViewProtocol {
    func reloadView(listData: [SearchEntity]) {
        initLoadData(data: listData)
    }
}

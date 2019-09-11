//
//  FindViewController.swift
//  EnglishApp
//
//  Created Kai Pham on 6/8/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class FindViewController: BaseViewController {

    @IBOutlet weak var viewDiamond: UIView!
    var presenter: FindPresenterProtocol?
    @IBOutlet weak var vAppSearch: AppSearchBar!
    @IBOutlet weak var tbResult: UITableView!
    @IBOutlet weak var lbNoResult: UILabel!
    @IBOutlet weak var lbFee: UILabel!
    
    var type : TypeViewSearch = .searchExercise

	override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func setTitleUI() {
        super.setTitleUI()
        hideTabbar()
        addBackToNavigation()
        setTitleNavigation(title: LocalizableKey.find.showLanguage)
        vAppSearch.setTitleAndPlaceHolder(placeHolder: LocalizableKey.findExcersise.showLanguage)
        vAppSearch.actionSearch = searchExercise
        configureTable()
        lbNoResult.text = "\(LocalizableKey.noResultFound.showLanguage)"
        lbFee.text = "\(LocalizableKey.feeFind.showLanguage)"
        
        if type == .searchExercise {
            viewDiamond.isHidden = false
        } else {
            viewDiamond.isHidden = true
        }
    }
    
    func searchExercise(text: String){
        if type == .searchExercise{
            self.presenter?.searchExercise(text: text)
        }
        if type == .searchTheory {
            self.presenter?.searchTheory(text: text)
        }
    }
    
    override func btnBackTapped() {
        showTabbar()
        self.pop()
    }
}
extension FindViewController: FindViewProtocol{
    func reloadView() {
        tbResult.reloadData()
    }
    
    func showErrorSearchFailed() {
        PopUpHelper.shared.showYesNo(message: self.presenter?.getMessageError() ?? "", completionNo: {
        }) {
            self.push(controller: StoreViewController())
        }
    }
}



extension FindViewController: UITableViewDelegate, UITableViewDataSource {
    func configureTable() {
        tbResult.delegate = self
        tbResult.dataSource = self
        tbResult.registerXibFile(FindCell.self)
        tbResult.separatorStyle = .none
        
        tbResult.estimatedRowHeight = 55
        tbResult.rowHeight = UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(FindCell.self, for: indexPath)
        if let textSearch = self.presenter?.getTextSearch(indexPath: indexPath){
            cell.lblSearch.attributedText = NSAttributedString(string: textSearch)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let row = self.presenter?.getNumberSearch() ?? 0
        if row == 0 {
            tbResult.isHidden = true
            return 0
        }
        tbResult.isHidden = false
        return row
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if type == .searchTheory {
            let idLesson = self.presenter?.getIdEntity(indexPath: indexPath) ?? ""
            self.presenter?.gotoTheoryDetail(idLesson: idLesson)
        }
        if type == .searchExercise {
            let idExercise = self.presenter?.searchRespone[indexPath.row]._id ?? "0"
            let typeValue = Int(self.presenter?.searchRespone[indexPath.row].type_test ?? "0") ?? 0
            var type : TypeDoExercise = .entranceExercise
            switch typeValue {
            case 5:
                type = TypeDoExercise.createExercise
            case 7:
                type = TypeDoExercise.levelExercise
            case 3:
                type = TypeDoExercise.practiceExercise
            case 6:
                type = TypeDoExercise.assignExercise
            case 2:
                type = TypeDoExercise.dailyMissonExercise
            case 1:
                type = TypeDoExercise.entranceExercise
            case 100:
                type = TypeDoExercise.competition
            default:
                break
            }
            let vc = ResultRouter.createModule(type: type, id: idExercise, isHistory: true)
            self.push(controller: vc)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

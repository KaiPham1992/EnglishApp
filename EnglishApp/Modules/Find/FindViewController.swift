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

    var presenter: FindPresenterProtocol?
    @IBOutlet weak var vAppSearch: AppSearchBar!
    @IBOutlet weak var tbResult: UITableView!
    @IBOutlet weak var lbNoResult: UILabel!
    
    var type : TypeViewSearch = .searchExercise
    var indexRow = 0

	override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setTitleUI() {
        super.setTitleUI()
        addBackToNavigation()
        setTitleNavigation(title: LocalizableKey.find.showLanguage)
        vAppSearch.setTitleAndPlaceHolder(placeHolder: LocalizableKey.findExcersise.showLanguage)
        vAppSearch.actionSearch = searchExercise
        configureTable()
        lbNoResult.attributedText = NSAttributedString(string: "\(LocalizableKey.noResultFound.showLanguage)")
    }
    
    func searchExercise(text: String){
        self.dismissKeyBoard()
        if type == .searchExercise{
            self.presenter?.searchExercise(text: text)
        }
        if type == .searchTheory {
            self.presenter?.searchTheory(text: text)
        }
    }
    
    override func btnBackTapped() {
        self.pop()
        self.dismissKeyBoard()
    }
    
    // MARK: - For check read or not
    private func changeStatusRow(index: IndexPath) {
        if let data = self.presenter?.searchExciseRespone[index.row] {
            data.isRead = true
            DispatchQueue.main.async {
                let cell = self.tbResult.cellForRow(at: index)
                cell?.backgroundColor = UIColor.white
            }
        }
    }
    
}
extension FindViewController: FindViewProtocol{
    func reloadView() {
        var row = 0
        if type == .searchTheory {
            row = self.presenter?.searchTheoryRespone.count ?? 0
        } else {
            row = self.presenter?.searchExciseRespone.count ?? 0
        }
        if row == 0 {
//            self.showNoData()
            tbResult.isHidden = true
        } else {
//            self.hideNoData()
            tbResult.isHidden = false
        }
        tbResult.reloadData()
    }
    
    func showErrorSearchFailed() {
        PopUpHelper.shared.showUpdateFeature(completeUpdate: { [unowned self] in
            self.push(controller: StoreViewController())
            }, completeCancel: nil)
    }
    
    func checkAmountSearchExerciseSuccessed() {
        let exercise = self.presenter?.searchExciseRespone[indexRow]
        let vc = ResultExerciseRouter.createModule(listAnswer: exercise?.questions ?? [], index: 0, isSearch: true)
        self.push(controller: vc)
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
        if type == .searchTheory {
            if let data = self.presenter?.searchTheoryRespone[indexPath.row].name?.htmlToString {
                cell.lbTitle.text = data
            }
        } else {
            if let data = self.presenter?.searchExciseRespone[indexPath.row] {
                if data.isRead {
                    cell.backgroundColor = UIColor.white
                } else {
                    cell.backgroundColor = AppColor.notificationNotRead
                }
                
                cell.lbTitle.text = data.name
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var row = 0
        if type == .searchTheory {
            row = self.presenter?.searchTheoryRespone.count ?? 0
        } else {
            row = self.presenter?.searchExciseRespone.count ?? 0
        }
        return row
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if type == .searchTheory {
            let idLesson = self.presenter?.searchTheoryRespone[indexPath.row]._id ?? "0"
            self.presenter?.gotoTheoryDetail(idLesson: idLesson)
        }
        
        if type == .searchExercise {
            let numberDiamond = UserDefaultHelper.shared.loginUserInfo?.amountDiamond ?? 0
            let numberHoney = UserDefaultHelper.shared.loginUserInfo?.amountHoney ?? 0
            if numberHoney < 5 && numberDiamond < 50 {
                PopUpHelper.shared.showYesNo(message: LocalizableKey.honey_diamond_not_enough.showLanguage, completionNo: nil) { [unowned self] in
                    let controller = StoreViewController()
                    self.push(controller: controller)
                }
            } else {
                PopUpHelper.shared.showYesNo(message: LocalizableKey.feeFind.showLanguage, completionNo: nil) {
                    [unowned self] in
                    self.indexRow = indexPath.row
                    self.changeStatusRow(index: indexPath)
                    self.presenter?.checkAmountSearchExercise()
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

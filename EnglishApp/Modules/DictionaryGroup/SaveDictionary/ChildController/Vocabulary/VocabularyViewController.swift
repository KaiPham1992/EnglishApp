//
//  VocabularyViewController.swift
//  EnglishApp
//
//  Created Steve on 7/28/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit
import XLPagerTabStrip

class VocabularyViewController: ListManagerVC {

	var presenter: VocabularyPresenterProtocol?
    var isDelete = false
    var actionDeleteFinish : (()->())?

    override func setUpViews() {
        showButtonBack = false
        super.setUpViews()
    }
    override func registerTableView() {
        super.registerTableView()
        tableView.registerXibFile(CellGrammar.self)
    }
    override func callAPI() {
        super.callAPI()
        self.presenter?.getListLikeVocab(offset: self.offset)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
//        self.presenter?.cancelDelete()
        actionDeleteFinish?()
    }

    func notifyDelete(){
        PopUpHelper.shared.showComfirmPopUp(message: LocalizableKey.cofirm_delete.showLanguage, titleYes: LocalizableKey.confirm.showLanguage.uppercased(), titleNo: LocalizableKey.cancel.showLanguage.uppercased()) { [unowned self] in
//            self.presenter?.confirmDelete()
        }
    }
    
    override func cellForRowListManager(item: Any, _ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = item as! WordLikeEntity
        let cell = tableView.dequeue(CellGrammar.self, for: indexPath)
        cell.indexPath = indexPath
        cell.setupTitle(title: data.word&)

        if isDelete {
            cell.setupDelete()
            cell.actionClick = {[weak self] (_) in
               data.isDelete = !data.isDelete
            }
        } else {
            cell.setupNoDelete()
        }
        
        return cell
    }
    
    override func didSelectTableView(item: Any, indexPath: IndexPath) {
        let data = item as! WordLikeEntity
        let vc = DetailLessonRouter.createModule(idVocabulary: Int(data.word_id ?? "0") ?? 0)
        self.push(controller: vc)
    }
}
extension VocabularyViewController : VocabularyViewProtocol{
    func reloadView(listResponse: [WordLikeEntity]) {
        initLoadData(data: listResponse)
    }
    
    func reloadViewAfterDelete(){
        isDelete = false
        tableView.reloadData()
        actionDeleteFinish?()
    }
}

extension VocabularyViewController: IndicatorInfoProvider{
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: LocalizableKey.vocabulary.showLanguage)
    }
}


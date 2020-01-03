//
//  NoteListViewController.swift
//  EnglishApp
//
//  Created Steve on 7/25/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit
import XLPagerTabStrip

class NoteListViewController: BaseTableViewController {

	var presenter: NoteListPresenterProtocol?
	
    @IBAction func addNote(_ sender: Any) {
        self.presenter?.gotoAddNote()
    }
    
    @IBOutlet weak var tbvNoteList: UITableView!
    
    var isDelete = false
    var actionDeleteFinish : (()->())?
    var listDelete : [Int] = []
    
    override func setUpViews() {
        isAddPullToFresh = false
        super.setUpViews()
        initTableView(tableView: tbvNoteList)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.callAPI()
    }
    
    override func registerXibFile() {
        super.registerXibFile()
        tbvNoteList.registerXibFile(CellGrammar.self)
    }
    
    override func callAPI() {
        super.callAPI()
        self.presenter?.getListNote(offset: self.offset)
    }
    
    func deleteNote(){
        let listNote = self.listData as! [NoteRespone]
        let listId = listNote.filter{$0.isDelete}.map{Int($0._id ?? "0")}.compactMap{$0}
        self.listDelete = listId
        if listDelete.count > 0 {
            self.notifyDelete()
        } else {
            self.reloadViewAfterDelete()
        }
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        self.cancelDelete()
        actionDeleteFinish?()
    }
    
    func cancelDelete() {
        let listVocabulary = self.listData as! [NoteRespone]
        for item in listVocabulary {
            item.isDelete = false
        }
        reloadViewAfterDelete()
    }
    
    override func cellForRowAt(item: Any, _ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = item as! NoteRespone
        let cell = tableView.dequeue(CellGrammar.self, for: indexPath)
        cell.indexPath = indexPath
        cell.setupTitleNote(title: data.name&)
        cell.setOneline()
        if isDelete {
            cell.setupDelete(isDelete: data.isDelete)
            cell.actionClick = {(index) in
                data.isDelete = !data.isDelete
            }
        } else {
            cell.setupNoDelete()
        }
        return cell
    }
    
    override func didSelectedRowAt(item: Any, indexPath: IndexPath) {
        if !isDelete {
            let data = item as! NoteRespone
            self.presenter?.gotoNote(idNote: data._id ?? "0")
        }
    }
    
    func notifyDelete(){
        PopUpHelper.shared.showComfirmPopUp(message: LocalizableKey.cofirm_delete.showLanguage, titleYes: LocalizableKey.confirm.showLanguage.uppercased(), titleNo: LocalizableKey.cancel.showLanguage.uppercased()) { [unowned self] in
            self.presenter?.confirmDelete(listId: self.listDelete)
        }
    }
    
    func reloadViewAfterDelete(){
        isDelete = false
        tbvNoteList.reloadData()
        actionDeleteFinish?()
    }
}

extension NoteListViewController : NoteListViewProtocol {
    func reloadView(listData: [NoteRespone]) {
        initLoadData(data: listData)
    }
    
    func deleteNoteSuccessed() {
        let listNote = self.listData as! [NoteRespone]
        self.listData = listNote.filter{!$0.isDelete}
        if self.listData.count == 0 {
            showNoData()
        }
        reloadViewAfterDelete()
    }
}

extension NoteListViewController : AddNoteDelegate{
    func addNoteSuccessed() {
        self.offset = 0
        callAPI()
    }
}

extension NoteListViewController: IndicatorInfoProvider{
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: LocalizableKey.note.showLanguage)
    }
}

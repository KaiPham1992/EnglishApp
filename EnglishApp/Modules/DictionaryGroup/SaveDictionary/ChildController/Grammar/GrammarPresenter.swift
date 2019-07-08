//
//  GrammarPresenter.swift
//  EnglishApp
//
//  Created vinova on 5/16/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class GrammarPresenter: GrammarPresenterProtocol, GrammarInteractorOutputProtocol {
   
    weak private var view: GrammarViewProtocol?
    var interactor: GrammarInteractorInputProtocol?
    private let router: GrammarWireframeProtocol
    var listRespone : [NoteRespone] = []
    var isLoadmore: Bool = true

    init(interface: GrammarViewProtocol, interactor: GrammarInteractorInputProtocol?, router: GrammarWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    
    func changeStatusNote(indexPath: IndexPath){
        listRespone[indexPath.row].isDelete = !listRespone[indexPath.row].isDelete
    }
    
    func deleteNote(){
        let listId = self.listRespone.filter{$0.isDelete}.map{Int($0._id ?? "0")}.compactMap{$0}
        self.interactor?.deleteNote(id: listId)
    }
    
    func deleteNoteSuccessed(){
        self.listRespone = self.listRespone.filter{$0.isDelete == false}
        self.view?.reloadViewAfterDelete()
    }
    
    func cancelDelete(){
        for index in 0..<listRespone.count{
            listRespone[index].isDelete = false
        }
        self.view?.reloadViewAfterDelete()
    }
    
    func gotoNote() {
        self.router.gotoNote()
    }
    
    func gotoAddNote() {
        self.router.gotoAddNote()
    }
    
    func gotoDetailVocabulary() {
        self.router.gotoDetailVocabulary()
    }
    
    func gotoDetailGrammar() {
        self.router.gotoDetailGrammar()
    }
    
    func getNumberRow() -> Int {
        return listRespone.count
    }
    
    func getItemIndexPath(indexPath: IndexPath) -> NoteRespone?{
        return listRespone[indexPath.row]
    }
    
    func getListNote(offset: Int) {
        if isLoadmore {
            self.interactor?.getListNote(offset: offset)
        }
    }
    
    func getListNoteSuccessed(listNote: [NoteRespone]) {
        if listNote.count < limit {
            isLoadmore = false
        }
        self.listRespone += listNote
        self.view?.reloadView()
    }
}

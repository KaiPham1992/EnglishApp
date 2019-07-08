//
//  GrammarInteractor.swift
//  EnglishApp
//
//  Created vinova on 5/16/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class GrammarInteractor: GrammarInteractorInputProtocol {
    
    weak var presenter: GrammarInteractorOutputProtocol?
    
    func getListNote(offset: Int) {
        ProgressView.shared.show()
        Provider.shared.saveAPIService.getListNote(offset: offset, success: { (listNote) in
            ProgressView.shared.hide()
            self.presenter?.getListNoteSuccessed(listNote: listNote)
        }) { (error) in
            ProgressView.shared.hide()
        }
    }
    func deleteNote(id: [Int]){
        ProgressView.shared.show()
        Provider.shared.saveAPIService.deleteNote(id: id, success: { (respone) in
            ProgressView.shared.hide()
            if let _ = respone {
                self.presenter?.deleteNoteSuccessed()
            }
        }) { (error) in
            ProgressView.shared.hide()
        }
    }
}

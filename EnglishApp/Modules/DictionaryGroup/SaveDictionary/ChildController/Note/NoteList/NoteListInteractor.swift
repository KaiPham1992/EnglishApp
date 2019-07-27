//
//  NoteListInteractor.swift
//  EnglishApp
//
//  Created Steve on 7/25/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class NoteListInteractor: NoteListInteractorInputProtocol {

    weak var presenter: NoteListInteractorOutputProtocol?
    
    func getListNote(offset: Int) {
        ProgressView.shared.show()
        Provider.shared.saveAPIService.getListNote(offset: offset, success: { (response) in
            ProgressView.shared.hide()
            if let _response = response {
                self.presenter?.getListNoteSuccessed(listNote: _response)
            }
            
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
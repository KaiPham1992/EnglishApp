//
//  DictionaryInteractor.swift
//  EnglishApp
//
//  Created vinova on 5/15/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class DictionaryInteractor: DictionaryInteractorInputProtocol {

    weak var presenter: DictionaryInteractorOutputProtocol?
    
//    func getListDictionary() {
//        ProgressView.shared.show()
//        Provider.shared.findAPIService.getListDictionary(success: { (response) in
//            ProgressView.shared.hide()
//            if let _response = response {
//                self.presenter?.getListDictionarySuccessed(listDictionary: _response.dictionaries ?? [])
//            }
//        }) { (error) in
//            ProgressView.shared.hide()
//        }
//    }
    
    func lookWordOnline(dictionary_id: Int, word: String) {
        ProgressView.shared.show()
        Provider.shared.findAPIService.lookupWordOnline(dictionary_id: dictionary_id, word: word, success: { (response) in
            ProgressView.shared.hide()
            if let _response = response {
                self.presenter?.lookupWordOnlineSuccessed(response: _response)
            }
        }) { (error) in
            
            ProgressView.shared.hide()
        }
    }
}

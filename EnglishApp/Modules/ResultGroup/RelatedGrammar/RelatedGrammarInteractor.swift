//
//  RelatedGrammarInteractor.swift
//  EnglishApp
//
//  Created Steve on 7/29/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class RelatedGrammarInteractor: RelatedGrammarInteractorInputProtocol {

    weak var presenter: RelatedGrammarInteractorOutputProtocol?
    
    func getListRelatedLesson(id: Int, offset: Int) {
        Provider.shared.resultAPIService.getRelatedLesson(id: id, offset: offset, success: { (response) in
            if let _response = response {
                self.presenter?.getListRelatedLessonSuccessed(response: _response)
            }
        }) { (error) in
        }
    }
}

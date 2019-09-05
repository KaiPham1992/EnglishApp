//
//  ResultInteractor.swift
//  EnglishApp
//
//  Created vinova on 5/23/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class ResultInteractor: ResultInteractorInputProtocol {

    weak var presenter: ResultInteractorOutputProtocol?
    func getViewResult(id: String) {
        ProgressView.shared.show()
        Provider.shared.resultAPIService.getViewTestResultProfile(id: id, success: { (respone) in
            ProgressView.shared.hide()
            if let _respone = respone {
                self.presenter?.getViewTestResultSuccessed(respone: _respone)
            }
        }) { (error) in
            ProgressView.shared.hide()
//            if let _error = error {
//                if (_error.message ?? "") == "COMPETITION IS DOING" {
//                    self.presenter?.competitionIsDoing()
//                }
//            }
        }
    }
    
    func getViewResultUserCompetition(idCompetition: String) {
        if let id = Int(idCompetition){
            ProgressView.shared.show()
            Provider.shared.resultAPIService.getResultUser(idCompetition: id, success: { (respone) in
                ProgressView.shared.hide()
                if let _respone = respone, _respone._id != nil {
                    self.presenter?.getViewTestResultSuccessed(respone: _respone)
                } else {
                    self.presenter?.usetDontJoindCompetition()
                }
            }) { (error) in
                ProgressView.shared.hide()
                if let _error = error {
                    if (_error.message ?? "") == "COMPETITION IS DOING" {
                        self.presenter?.competitionIsDoing()
                    }
                }
            }
        }
    }
}

//
//  StudyPackDetailPresenter.swift
//  EnglishApp
//
//  Created by Henry on 7/17/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import UIKit

class StudyPackDetailPresenter: StudyPackDetailPresenterProtocol, StudyPackDetailInteractorOutputProtocol {
    func upgradeProduct(productID: String, transactionId: String) {
        ProgressView.shared.show()
        Provider.shared.productAPIService.upgradeProduc(productID: productID, transactionId: transactionId, success: { (success) in
            ProgressView.shared.hide()
            guard let success = success else {return}
            
            self.view?.didUpgrade(info: success)
        }) { (error) in
            ProgressView.shared.hide()
            guard let error = error else {return}
//            self.view?.didUpgrade(error: error)
        }
    }
    
    
    weak private var view: StudyPackDetailViewProtocol?
    var interactor: StudyPackDetailInteractorInputProtocol?
    private let router: StudyPackDetailWireframeProtocol
    
    init(interface: StudyPackDetailViewProtocol, interactor: StudyPackDetailInteractorInputProtocol?, router: StudyPackDetailWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    
}

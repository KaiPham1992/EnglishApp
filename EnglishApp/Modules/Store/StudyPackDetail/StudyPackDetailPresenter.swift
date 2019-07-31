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
    func upgradeProduct(productID: String) {
        Provider.shared.productAPIService.upgradeProduc(productID: productID, success: { (success) in
            guard let success = success else {return}
            self.view?.didUpgrade(info: success)
        }) { (error) in
            guard let error = error else {return}
            self.view?.didUpgrade(error: error)
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

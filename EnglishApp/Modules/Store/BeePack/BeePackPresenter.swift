//
//  BeePackPresenter.swift
//  EnglishApp
//
//  Created Kai Pham on 5/20/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class BeePackPresenter: BeePackPresenterProtocol, BeePackInteractorOutputProtocol {

    weak private var view: BeePackViewProtocol?
    var interactor: BeePackInteractorInputProtocol?
    private let router: BeePackWireframeProtocol

    init(interface: BeePackViewProtocol, interactor: BeePackInteractorInputProtocol?, router: BeePackWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    func upgradeProduct(productID: String) {
        Provider.shared.productAPIService.upgradeProduc(productID: productID, success: { (success) in
            guard let success = success else {return}
            self.view?.didUpgrade(info: success)
        }) { (error) in
            guard let error = error else {return}
            self.view?.didUpgrade(error: error)
        }
    }

}

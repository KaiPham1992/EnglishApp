//
//  StudyPackDetailProtocols.swift
//  EnglishApp
//
//  Created by Henry on 7/17/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation

//MARK: Wireframe -
protocol StudyPackDetailWireframeProtocol: class {
    
}
//MARK: Presenter -
protocol StudyPackDetailPresenterProtocol: class {
    
    var interactor: StudyPackDetailInteractorInputProtocol? { get set }
    func upgradeProduct(productID: Int)
}

//MARK: Interactor -
protocol StudyPackDetailInteractorOutputProtocol: class {
    
    /* Interactor -> Presenter */
}

protocol StudyPackDetailInteractorInputProtocol: class {
    
    var presenter: StudyPackDetailInteractorOutputProtocol?  { get set }
    
    /* Presenter -> Interactor */
}

//MARK: View -
protocol StudyPackDetailViewProtocol: class {
    
    var presenter: StudyPackDetailPresenterProtocol?  { get set }
    
    /* Presenter -> ViewController */
    func didUpgrade()
}

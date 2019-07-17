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
    
    weak private var view: StudyPackDetailViewProtocol?
    var interactor: StudyPackDetailInteractorInputProtocol?
    private let router: StudyPackDetailWireframeProtocol
    
    init(interface: StudyPackDetailViewProtocol, interactor: StudyPackDetailInteractorInputProtocol?, router: StudyPackDetailWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    
}

//
//  StudyPackDetailRouter.swift
//  EnglishApp
//
//  Created by Henry on 7/17/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit
class StudyPackDetailRouter: StudyPackDetailWireframeProtocol {
    
    weak var viewController: UIViewController?
    
    static func createModule(product: ProductEntity) -> UIViewController {
        // Change to get view from storyboard if not using progammatic UI
        let view = StudyPackDetailViewController.initFromNib()
        let interactor = StudyPackDetailInteractor()
        let router = StudyPackDetailRouter()
        let presenter = StudyPackDetailPresenter(interface: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        view.product = product
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
}

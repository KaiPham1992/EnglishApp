//
//  StudyPackRouter.swift
//  EnglishApp
//
//  Created Kai Pham on 5/20/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class StudyPackRouter: StudyPackWireframeProtocol {

    weak var viewController: UIViewController?

    static func createModule() -> StudyPackViewController {
        // Change to get view from storyboard if not using progammatic UI
        let view = StudyPackViewController.initFromNib()
        let interactor = StudyPackInteractor()
        let router = StudyPackRouter()
        let presenter = StudyPackPresenter(interface: view, interactor: interactor, router: router)

        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view

        return view
    }
}

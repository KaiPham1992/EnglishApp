//
//  CompetitionRouter.swift
//  EnglishApp
//
//  Created Kai Pham on 5/13/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class CompetitionRouter: CompetitionWireframeProtocol {

    weak var viewController: UIViewController?

    static func createModule() -> UIViewController {
        // Change to get view from storyboard if not using progammatic UI
        let view = CompetitionViewController(nibName: nil, bundle: nil)
        let interactor = CompetitionInteractor()
        let router = CompetitionRouter()
        let presenter = CompetitionPresenter(interface: view, interactor: interactor, router: router)

        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view

        return view
    }
    
    static func createModule(type: ResultCompetition = .competition, date: String = "") -> UIViewController {
        // Change to get view from storyboard if not using progammatic UI
        let view = CompetitionViewController(nibName: nil, bundle: nil)
        view.type = type
        view.date = date
        let interactor = CompetitionInteractor()
        let router = CompetitionRouter()
        let presenter = CompetitionPresenter(interface: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
}

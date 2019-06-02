//
//  DetailPackRouter.swift
//  EnglishApp
//
//  Created Kai Pham on 6/1/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class DetailPackRouter: DetailPackWireframeProtocol {

    weak var viewController: UIViewController?

    static func createModule() -> UIViewController {
        // Change to get view from storyboard if not using progammatic UI
        let view = DetailPackViewController(nibName: nil, bundle: nil)
        let interactor = DetailPackInteractor()
        let router = DetailPackRouter()
        let presenter = DetailPackPresenter(interface: view, interactor: interactor, router: router)

        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view

        return view
    }
}
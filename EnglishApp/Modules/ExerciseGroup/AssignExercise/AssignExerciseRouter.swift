//
//  AssignExerciseRouter.swift
//  EnglishApp
//
//  Created Steve on 7/18/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class AssignExerciseRouter: AssignExerciseWireframeProtocol {

    weak var viewController: UIViewController?

    static func createModule() -> UIViewController {
        // Change to get view from storyboard if not using progammatic UI
        let view = AssignExerciseViewController(nibName: nil, bundle: nil)
        let interactor = AssignExerciseInteractor()
        let router = AssignExerciseRouter()
        let presenter = AssignExercisePresenter(interface: view, interactor: interactor, router: router)

        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view

        return view
    }
}

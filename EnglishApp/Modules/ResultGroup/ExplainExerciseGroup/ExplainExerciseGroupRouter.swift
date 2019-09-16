//
//  ExplainExerciseGroupRouter.swift
//  EnglishApp
//
//  Created Steve on 7/29/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class ExplainExerciseGroupRouter: ExplainExerciseGroupWireframeProtocol {

    weak var viewController: UIViewController?

    static func createModule(id: Int) -> ExplainExerciseGroupViewController {
        // Change to get view from storyboard if not using progammatic UI
        let view = ExplainExerciseGroupViewController(nibName: nil, bundle: nil)
        view.id = id
        let interactor = ExplainExerciseGroupInteractor()
        let router = ExplainExerciseGroupRouter()
        let presenter = ExplainExerciseGroupPresenter(interface: view, interactor: interactor, router: router)

        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view

        return view
    }
}

//
//  HistoryExerciseRouter.swift
//  EnglishApp
//
//  Created vinova on 5/30/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class HistoryExerciseRouter: HistoryExerciseWireframeProtocol {

    weak var viewController: UIViewController?

    static func createModule() -> HistoryExerciseViewController {
        // Change to get view from storyboard if not using progammatic UI
        let view = HistoryExerciseViewController.initFromNib()
        let interactor = HistoryExerciseInteractor()
        let router = HistoryExerciseRouter()
        let presenter = HistoryExercisePresenter(interface: view, interactor: interactor, router: router)

        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view

        return view
    }
    
    func gotoHistoryDate(){
        let vc = HistoryExerciseDateRouter.createModule()
        self.viewController?.push(controller: vc,animated: true)
    }
}

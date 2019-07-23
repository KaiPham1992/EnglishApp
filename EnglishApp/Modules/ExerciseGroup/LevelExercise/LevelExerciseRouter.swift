//
//  LevelExerciseRouter.swift
//  EnglishApp
//
//  Created vinova on 5/22/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class LevelExerciseRouter: LevelExerciseWireframeProtocol {

    weak var viewController: UIViewController?

    static func createModule() -> UIViewController {
        // Change to get view from storyboard if not using progammatic UI
        let view = LevelExerciseViewController.initFromNib()
        let interactor = LevelExerciseInteractor()
        let router = LevelExerciseRouter()
        let presenter = LevelExercisePresenter(interface: view, interactor: interactor, router: router)

        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view

        return view
    }
    
//    static func createModule(type: Int = 0) -> UIViewController {
//        // Change to get view from storyboard if not using progammatic UI
//        let view = LevelExerciseViewController.initFromNib()
//        view.type = type
//        let interactor = LevelExerciseInteractor()
//        let router = LevelExerciseRouter()
//        let presenter = LevelExercisePresenter(interface: view, interactor: interactor, router: router)
//
//        view.presenter = presenter
//        interactor.presenter = presenter
//        router.viewController = view
//
//        return view
//    }
    func gotoCatelogy(studyPackId: Int){
        let vc = CatelogyExerciseRouter.createModule(typeTest: TypeExercise.level.rawValue,studyPackId: studyPackId)
        self.viewController?.push(controller: vc)
    }
    
    func gotoChoiceExercise(type: Int, id: String) {
        let vc = ChoiceExerciseRouter.createModule(type: type, categoryId: id)
        self.viewController?.push(controller: vc,animated: true)
    }
}

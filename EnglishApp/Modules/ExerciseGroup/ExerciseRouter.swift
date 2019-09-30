//
//  ExerciseRouter.swift
//  EnglishApp
//
//  Created vinova on 5/21/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class ExerciseRouter: ExerciseWireframeProtocol {
    
    weak var viewController: UIViewController?
    var date : String = ""

    static func createModule(isShowTabbar: Bool = true,date: String = "") -> UIViewController {
        // Change to get view from storyboard if not using progammatic UI
        let view = ExerciseViewController.initFromNib()
        view.isShowTabbar = isShowTabbar
        let interactor = ExerciseInteractor()
        let router = ExerciseRouter()
        router.date = date
        let presenter = ExercisePresenter(interface: view, interactor: interactor, router: router)

        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view

        return view
    }
    
    func gotoCreateExercise(){
        let vc = CreateExerciseRouter.createModule()
        vc.hidesBottomBarWhenPushed = true
        self.viewController?.push(controller: vc,animated: true)
    }
    func gotoLevelExercise(){
        let vc = LevelExerciseRouter.createModule()
        vc.hidesBottomBarWhenPushed = true
        self.viewController?.push(controller: vc,animated: true)
    }
    func gotoPracticeExercise() {
        let vc = CatelogyExerciseRouter.createModule(typeTest: TypeExercise.practice.rawValue)
        vc.hidesBottomBarWhenPushed = true
        self.viewController?.push(controller: vc,animated: true)
    }
    func gotoAssignExercise() {
        let vc = AssignExerciseRouter.createModule()
        vc.hidesBottomBarWhenPushed = true
        self.viewController?.push(controller: vc,animated: true)
    }
    func gotoHistoryCreateExercise() {
        let vc = HistoryListExerciseRouter.createModule(date: date,type_test: TypeDoExercise.createExercise)
        vc.hidesBottomBarWhenPushed = true
        self.viewController?.push(controller: vc)
    }
    
    func gotoHistoryLevelExercise() {
        let vc = HistoryListExerciseRouter.createModule(date: date,type_test: TypeDoExercise.levelExercise)
        vc.hidesBottomBarWhenPushed = true
        self.viewController?.push(controller: vc)
    }
    
    func gotoHistoryPracticeExercise() {
        let vc = HistoryListExerciseRouter.createModule(date: date,type_test: TypeDoExercise.practiceExercise)
        vc.hidesBottomBarWhenPushed = true
        self.viewController?.push(controller: vc)
    }
    
    func gotoHistoryAssignExercise() {
        let vc = HistoryListExerciseRouter.createModule(date: date,type_test:  TypeDoExercise.assignExercise)
        vc.hidesBottomBarWhenPushed = true
        self.viewController?.push(controller: vc)
    }
    
}

//
//  CommentProtocols.swift
//  EnglishApp
//
//  Created vinova on 5/18/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import Foundation

//MARK: Wireframe -
protocol CommentWireframeProtocol: class {

}
//MARK: Presenter -
protocol CommentPresenterProtocol: class {

    var interactor: CommentInteractorInputProtocol? { get set }
    func getComment(idLesson: String)
    func numberParent() -> Int?
    func numberChildren(section: Int) -> Int?
    func getParentComment(section: Int) -> ParentComment?
    func getChildrenComment(indexPath: IndexPath) -> ChildrenComment?
    func addComment(idLesson: Int, content: String)
}

//MARK: Interactor -
protocol CommentInteractorOutputProtocol: class {

    /* Interactor -> Presenter */
    
    func getCommentSuccessed(respone: CommentEntity)
}

protocol CommentInteractorInputProtocol: class {

    var presenter: CommentInteractorOutputProtocol?  { get set }
    func getComment(idLesson: String)
    func addComment(idLesson: Int, content: String)

    /* Presenter -> Interactor */
}

//MARK: View -
protocol CommentViewProtocol: class {

    var presenter: CommentPresenterProtocol?  { get set }
    func reloadView()

    /* Presenter -> ViewController */
}

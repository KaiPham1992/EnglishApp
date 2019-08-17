//
//  CommentPresenter.swift
//  EnglishApp
//
//  Created vinova on 5/18/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class CommentPresenter: CommentPresenterProtocol, CommentInteractorOutputProtocol {
   
    weak private var view: CommentViewProtocol?
    var interactor: CommentInteractorInputProtocol?
    private let router: CommentWireframeProtocol
    private var commentEntity: CommentEntity?
    var indexSection: Int?
    var isLoadmore = true

    init(interface: CommentViewProtocol, interactor: CommentInteractorInputProtocol?, router: CommentWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    
    func getComment(idLesson: String,offset: Int) {
        if isLoadmore {
            self.interactor?.getComment(idLesson: idLesson,offset: offset)
        }
        
    }
    
    func addCommentSuccessed(respone: ParentComment) {
        if commentEntity == nil {
            commentEntity = CommentEntity()
            commentEntity?.data.append(respone)
        } else {
            if let _index = self.indexSection {
                self.commentEntity?.data[_index].children.append(respone)
                self.indexSection = nil
            } else {
                self.commentEntity?.data.append(respone)
                self.indexSection = nil
            }
        }
        self.view?.reloadView()
    }
    
    func getCommentSuccessed(respone: CommentEntity) {
        if respone.data.count < limit {
            isLoadmore = false
        }
        if self.commentEntity == nil {
            self.commentEntity = respone
        } else {
            self.commentEntity?.data += respone.data
        }
        self.view?.reloadView()
    }
    
    func numberParent() -> Int?{
        return commentEntity?.data.count
    }
    
    func numberChildren(section: Int) -> Int?{
        return commentEntity?.data[section].children.count
    }
    
    func getParentComment(section: Int) -> ParentComment?{
        return commentEntity?.data[section]
    }
    
    func getChildrenComment(indexPath: IndexPath) -> ParentComment? {
        return commentEntity?.data[indexPath.section].children[indexPath.row]
    }
    
    func addComment(idLesson: Int, content: String,idParent: Int?,indexSection: Int?) {
        self.indexSection = indexSection
        self.interactor?.addComment(idLesson: idLesson, content: content,idParent: idParent)
    }
}

//
//  CommentInteractor.swift
//  EnglishApp
//
//  Created vinova on 5/18/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class CommentInteractor: CommentInteractorInputProtocol {

    weak var presenter: CommentInteractorOutputProtocol?
    
    func getComment(idLesson: String,offset: Int) {
        ProgressView.shared.show()
        Provider.shared.theoryAPIService.getComment(idLesson: idLesson,offset: offset, success: { (listComment) in
            ProgressView.shared.hide()
            if let _lisComment = listComment {
                self.presenter?.getCommentSuccessed(respone: _lisComment)
            }
        }) { (error) in
            ProgressView.shared.hide()
        }
    }
    
    func addComment(idLesson: Int, content: String,idParent: Int?) {
        Provider.shared.theoryAPIService.addComment(idLesson: idLesson, content: content, idParent: idParent, success: { (respone) in
            if let _respone = respone {
                self.presenter?.addCommentSuccessed(respone: _respone)
            }
        }) { (error) in
            
        }
    }
}

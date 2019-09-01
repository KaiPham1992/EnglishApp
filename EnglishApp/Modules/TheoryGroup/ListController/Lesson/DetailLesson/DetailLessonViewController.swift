//
//  DetailLessonViewController.swift
//  EnglishApp
//
//  Created vinova on 5/18/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit


enum DetailLessonVocabulary{
    case detailLesson
    case vocabulary
}
class DetailLessonViewController: BaseViewController {

    @IBOutlet weak var lbContent: UILabel!
    var presenter: DetailLessonPresenterProtocol?
    var type : DetailLessonVocabulary = .detailLesson
    var lesson: ItemLesson?
    var idLesson : String = "0"
    var callbackCallAgainAPI : (()->())?
    var isClickLikeImage = false
    var vocabulary : WordExplainEntity?
    var idVocabulary : Int?
    
    var isLike = 0 {
        didSet{
            self.btnLike.setBackgroundImage(isLike == 0 ? UIImage(named:"Material_Icons_white_favorite") : #imageLiteral(resourceName: "Material_Icons_white_favorite-1") , for: .normal)
        }
    }
    
    var viewMessage = ViewMessage(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
    
    override func setUpViews() {
        super.setUpViews()
        
        if let _lesson = lesson {
            idLesson = _lesson._id ?? "0"
        }
        if idLesson != "0" {
            self.presenter?.getLessonDetail(lesson_id: Int(self.idLesson) ?? 0)
        }
        
        if let _ = self.vocabulary {
            reloadView()
        }
        
        if let _idVocabulary = idVocabulary {
            self.presenter?.getViewVocabulary(wordId: _idVocabulary)
        }
    }
    
    override func btnBackTapped() {
        if isClickLikeImage {
            self.callbackCallAgainAPI?()
        }
        super.btnBackTapped()
    }
    
    override func setUpNavigation() {
        super.setUpNavigation()
        addBackToNavigation()
        if type == .detailLesson{
            viewMessage.action = { [unowned self] in
                self.gotoComment()
            }
            addTwoViewToNavigation(view1: viewMessage, image1: nil,action1: nil, view2: nil, image2: UIImage(named:"Material_Icons_white_favorite")!, action2: #selector(clickHeart))
            viewMessage.isHidden = true
        } else {
            addButtonLikeToNavigation(image: UIImage(named:"Material_Icons_white_favorite")!, actionSelector: #selector(clickHeart))
             setTitleNavigation(title: LocalizableKey.vocabularyDetail.showLanguage)
        }
        btnLike.isHidden = true
        
    }
    
    func gotoComment() {
        guard let isUserPremium = UserDefaultHelper.shared.loginUserInfo?.isUserPremium else { return }
        if isUserPremium {
            self.push(controller: CommentRouter.createModule(id: self.idLesson),animated: true)
        } else {
            PopUpHelper.shared.showUpdateFeature(completeUpdate: {[unowned self] in
                let vc = StoreViewController()
                self.push(controller: vc)
            }) {
                
            }
        }
    }
    
    @objc func clickHeart(){
        if type == .detailLesson {
            isClickLikeImage = true
            isLike = isLike == 0 ? 1 : 0
        } else {
            isClickLikeImage = true
            isLike = isLike == 0 ? 1 : 0
        }
        self.presenter?.likeLesson(idLesson: Int(self.idLesson) ?? 0 ,idWord: self.vocabulary != nil ? self.vocabulary?.id : self.presenter?.vocabulary?.id , isFavorite: self.isLike)
    }
}

extension DetailLessonViewController:DetailLessonViewProtocol{
    func reloadView() {
        if type == .detailLesson {
            setTitleNavigation(title: self.presenter?.getTitle() ?? "")
            if let attribute = self.presenter?.getContentLesson(){
                self.lbContent.attributedText = attribute
            }
            if let comment = self.presenter?.getNumberComment(){
                self.viewMessage.setupNumber(number: comment)
            } else {
                self.viewMessage.setupNumber(number: 0)
            }
            
            if let _ = self.presenter?.getToggleLike() {
                self.isLike = 1
                self.btnLike.setBackgroundImage(#imageLiteral(resourceName: "Material_Icons_white_favorite-1"), for: .normal)
            } else {
                self.isLike = 0
                self.btnLike.setBackgroundImage(UIImage(named:"Material_Icons_white_favorite")!, for: .normal)
            }
            viewMessage.isHidden = false
        } else {
            if let vocabulary = self.vocabulary {
                setTitleNavigation(title: vocabulary.word)
                self.lbContent.attributedText = vocabulary.explain.html2Attributed
                if vocabulary.is_favorite {
                    self.isLike = 1
                    self.btnLike.setBackgroundImage(#imageLiteral(resourceName: "Material_Icons_white_favorite-1"), for: .normal)
                } else {
                    self.isLike = 0
                    self.btnLike.setBackgroundImage(UIImage(named:"Material_Icons_white_favorite")!, for: .normal)
                }
            } else {
                self.lbContent.attributedText = self.presenter?.vocabulary?.explain.html2Attributed
                if (self.presenter?.vocabulary?.is_favorite ?? false) {
                    self.isLike = 1
                    self.btnLike.setBackgroundImage(#imageLiteral(resourceName: "Material_Icons_white_favorite-1"), for: .normal)
                } else {
                    self.isLike = 0
                    self.btnLike.setBackgroundImage(UIImage(named:"Material_Icons_white_favorite")!, for: .normal)
                }
            }
        }
        btnLike.isHidden = false
    }
}

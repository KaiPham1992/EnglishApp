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
import WebKit

enum DetailLessonVocabulary{
    case detailLesson
    case vocabulary
}
class DetailLessonViewController: BaseViewController {

    @IBOutlet weak var webView: WKWebView!
    var presenter: DetailLessonPresenterProtocol?
    var type : DetailLessonVocabulary = .detailLesson
    var lesson: ItemLesson?
    var idLesson : String = "0"
    var callbackCallAgainAPI : (()->())?
    var isClickLikeImage = false
    var vocabulary : WordExplainEntity?
    var idVocabulary : Int?
    var font = """
    <style>
    @font-face
    {
        font-family: 'Comfortaa';
        font-weight: normal;
        src: url(Comfortaa-Regular.ttf);
    }
    @font-face
    {
        font-family: 'Comfortaa';
        font-weight: bold;
        src: url(Comfortaa-Bold.ttf);
    }
    </style>
    """
    var isLike = 0 {
        didSet{
            self.btnLike.setBackgroundImage(isLike == 0 ? UIImage(named:"Material_Icons_white_favorite") : #imageLiteral(resourceName: "Material_Icons_white_favorite-1") , for: .normal)
        }
    }
    
    var showProgressView : Bool = true
    
    var viewMessage = ViewMessage(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
    
    override func setUpViews() {
        super.setUpViews()
        webView.navigationDelegate = self
        webView.scrollView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if showProgressView {
            ProgressView.shared.show()
            self.showProgressView = false
        }
        
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
        if UserDefaultHelper.shared.loginUserInfo?.email == emailDefault {
            let vc = LoginRouter.createModule()
            vc.callBackLoginSuccessed = {[unowned self] in
                self.comment()
            }
            self.present(controller: vc, animated: true)
        } else {
            self.comment()
        }
    }
    
    private func comment(){
        guard let isUserPremium = UserDefaultHelper.shared.loginUserInfo?.isUserPremium else { return }
        if isUserPremium {
            self.push(controller: CommentRouter.createModule(id: self.idLesson),animated: true)
        } else {
            PopUpHelper.shared.showUpdateFeature(completeUpdate: {[unowned self] in
                let vc = StudyPackDetailRouter.createModule(id: "-1")
                self.push(controller: vc)
            }) {
                
            }
        }
    }
    
    @objc func clickHeart(){
        if UserDefaultHelper.shared.loginUserInfo?.email != emailDefault {
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
}

extension DetailLessonViewController : UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return nil
    }
}

extension DetailLessonViewController : WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
    }
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
         let jscript = "var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);"
           webView.evaluateJavaScript(jscript)
    }
}

extension DetailLessonViewController:DetailLessonViewProtocol{
    func reloadView() {
        if type == .detailLesson {
            setTitleNavigation(title: self.presenter?.lessonDetail?.name ?? "")
            if let htmlString = self.presenter?.self.lessonDetail?.content{
                let htmlStringAdvanced = font + #"<span style="font-family: 'Comfortaa'; font-weight: Regular; font-size: 14; color: black">"# + htmlString + #"</span>"#
                webView.loadHTMLString(htmlStringAdvanced, baseURL: Bundle.main.bundleURL)
            }
            if let comment = self.presenter?.lessonDetail?.unread_comments{
                self.viewMessage.setupNumber(number: comment)
            } else {
                self.viewMessage.setupNumber(number: 0)
            }
            
            if let _ = self.presenter?.lessonDetail?.is_favorite {
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
                let htmlString = font + #"<span style="font-family: 'Comfortaa'; font-weight: Regular; font-size: 14; color: black">"# + (self.presenter?.vocabulary?.explain ?? "") + #"</span>"#
                webView.loadHTMLString(htmlString, baseURL: Bundle.main.bundleURL)
                if vocabulary.is_favorite {
                    self.isLike = 1
                    self.btnLike.setBackgroundImage(#imageLiteral(resourceName: "Material_Icons_white_favorite-1"), for: .normal)
                } else {
                    self.isLike = 0
                    self.btnLike.setBackgroundImage(UIImage(named:"Material_Icons_white_favorite")!, for: .normal)
                }
            } else {
                let htmlString = font + #"<span style="font-family: 'Comfortaa'; font-weight: Regular; font-size: 14; color: black">"# + (self.presenter?.vocabulary?.explain ?? "") + #"</span>"#
                webView.loadHTMLString(htmlString, baseURL: Bundle.main.bundleURL)
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

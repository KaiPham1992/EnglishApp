//
//  CommentQuestionViewController.swift
//  EnglishApp
//
//  Created Steve on 8/3/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit
import XLPagerTabStrip
import IQKeyboardManagerSwift

class CommentQuestionViewController: BaseViewController {

	var presenter: CommentQuestionPresenterProtocol?
    
    @IBAction func sendMessage(_ sender: Any) {
        let content = tfEnterComment.text ?? ""
        if content != "" {
            self.presenter?.addComment(idLesson: Int(self.idQuestion ?? "0") ?? 0, content: content,idParent: self.idParent,indexSection: self.indexSection)
            self.tfEnterComment.text = ""
            self.tfEnterComment.endEditing(true)
        }
    }
    
    @IBOutlet weak var bottomViewComment: NSLayoutConstraint!
    @IBOutlet weak var tfEnterComment: UITextField!
    @IBOutlet weak var viewComment: UIView!
    @IBOutlet weak var tbvComment: UITableView!
    
    var idQuestion: String?
    var idParent: Int?
    var indexSection : Int?
    var offset = 0
    
    override func setUpViews() {
        super.setUpViews()
        IQKeyboardManager.shared.disabledDistanceHandlingClasses  = [CommentQuestionViewController.self]
        IQKeyboardManager.shared.disabledToolbarClasses = [CommentQuestionViewController.self]
        addKeyboardNotification()
        tbvComment.registerXibFile(CellComment.self)
        tbvComment.registerXibFile(CellHeaderComment.self)
        tbvComment.delegate = self
        tbvComment.dataSource = self
        self.presenter?.getComment(idLesson: idQuestion&, offset: offset)
        tbvComment.keyboardDismissMode = .onDrag
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func setUpNavigation() {
        super.setUpNavigation()
        addBackToNavigation()
        setTitleNavigation(title: LocalizableKey.comment.showLanguage)
    }
    
    @objc func handleKeyboard(_ notification: NSNotification) {
        let isKeyboardShowing = notification.name ==  UIResponder.keyboardWillShowNotification
        guard let rect = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else{
            return
        }
        let keyboardRect = rect.cgRectValue
        if isKeyboardShowing {
            bottomViewComment.constant = -(keyboardRect.height  - view.safeAreaInsets.bottom)
            hideNoData()
        } else {
            bottomViewComment.constant = 0
            if (self.presenter?.commentEntity?.data.count ?? 0) == 0 {
                showNoData()
            }
        }
        
        let timeAnination = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSNumber)?.doubleValue ?? 0
        UIView.animate(withDuration: timeAnination, delay: 0, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
        
    }
}

extension CommentQuestionViewController: CommentQuestionViewProtocol{
    func reloadView() {
        self.idParent = nil
        self.indexSection = nil
        if (self.presenter?.commentEntity?.data.count ?? 0) == 0 {
            showNoData()
        } else{
            hideNoData()
        }
        tbvComment.reloadData()
    }
}

extension CommentQuestionViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter?.numberChildren(section: section) ?? 0
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        let row = self.presenter?.numberParent() ?? 0
        return row
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(CellComment.self, for: indexPath)
        cell.indexPath = indexPath
        if let dataCell = self.presenter?.getChildrenComment(indexPath: indexPath){
            cell.setupCellChildren(comment: dataCell)
        }
        cell.actionReply = { [weak self] (index: IndexPath) in
            if let id = self?.presenter?.getParentComment(section: index.section)?._id {
                self?.idParent = Int(id) ?? 0
                self?.indexSection = index.section
            }
            self?.tfEnterComment.becomeFirstResponder()
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeue(CellHeaderComment.self, for: IndexPath(row: 0, section: section))
        cell.indexSection = section
        cell.delegate = self
        
        if let dataCell = self.presenter?.getParentComment(section: section){
            cell.setupCellParent(comment: dataCell)
        }
        return cell.contentView
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let row = self.presenter?.numberParent() ?? 0
        if section == row - 1 {
            self.offset += limit
            self.presenter?.getComment(idLesson: idQuestion&,offset: self.offset)
        }
    }
}

extension CommentQuestionViewController : IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: LocalizableKey.comment.showLanguage)
    }
}

extension CommentQuestionViewController: ActionReplyComment{
    func replyHeader(indexSection: Int) {
        if let id = self.presenter?.getParentComment(section: indexSection)?._id {
            self.idParent = Int(id) ?? 0
            self.indexSection = indexSection
        }
        self.tfEnterComment.becomeFirstResponder()
    }
}

extension CommentQuestionViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001
    }
}

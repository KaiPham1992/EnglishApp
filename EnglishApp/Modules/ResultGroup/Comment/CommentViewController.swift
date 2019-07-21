//
//  CommentViewController.swift
//  EnglishApp
//
//  Created vinova on 5/18/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit
import XLPagerTabStrip

class CommentViewController: BaseViewController {

    @IBAction func sendMessage(_ sender: Any) {
        let content = tfEnterComment.text ?? ""
        if content != "" {
            self.presenter?.addComment(idLesson: Int(self.idLesson ?? "0") ?? 0, content: content,idParent: self.idParent,indexSection: self.indexSection)
            self.tfEnterComment.text = ""
            self.tfEnterComment.endEditing(true)
        }   
    }
    
    @IBOutlet weak var bottomViewComment: NSLayoutConstraint!
    @IBOutlet weak var tfEnterComment: UITextField!
    @IBOutlet weak var viewComment: UIView!
    @IBOutlet weak var tbvComment: UITableView!
    var presenter: CommentPresenterProtocol?
    var idLesson: String?
    var idParent: Int?
    var indexSection : Int?

    override func setUpViews() {
        super.setUpViews()
        addKeyboardNotification()
        tbvComment.registerXibFile(CellComment.self)
        tbvComment.registerXibFile(CellHeaderComment.self)
        tbvComment.delegate = self
        tbvComment.dataSource = self
        self.presenter?.getComment(idLesson: idLesson&)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func setUpNavigation() {
        super.setUpNavigation()
        addBackToNavigation()
        setTitleNavigation(title: LocalizableKey.comment.showLanguage)
    }
    
    @objc func keyboardShow(_ notification: NSNotification) {
        if let keyboard = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if #available(iOS 11.0, *) {
                UIView.animate(withDuration: 0.2) {
                    self.bottomViewComment.constant = keyboard.height - self.view.safeAreaInsets.bottom
                    self.view.layoutIfNeeded()
                }
            } else {
                UIView.animate(withDuration: 0.2) {
                    self.bottomViewComment.constant = keyboard.height
                    self.view.layoutIfNeeded()
                }
            }
        }
    }
    
    @objc func keyboardHide(_ notification: NSNotification) {
        bottomViewComment.constant = 0
    }
}

extension CommentViewController: CommentViewProtocol{
    func reloadView() {
        self.idParent = nil
        self.indexSection = nil
        tbvComment.reloadData()
    }
}

extension CommentViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter?.numberChildren(section: section) ?? 0
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.presenter?.numberParent() ?? 0
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
}

extension CommentViewController: ActionReplyComment{
    func replyHeader(indexSection: Int) {
        if let id = self.presenter?.getParentComment(section: indexSection)?._id {
            self.idParent = Int(id) ?? 0
            self.indexSection = indexSection
        }
        self.tfEnterComment.becomeFirstResponder()
    }
}

extension CommentViewController : UITableViewDelegate{
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

//
//  SaveDictionaryViewController.swift
//  EnglishApp
//
//  Created vinova on 5/16/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit
import XLPagerTabStrip

class SaveDictionaryViewController: PageViewController,SaveDictionaryViewProtocol {
    
    var presenter: SaveDictionaryPresenterProtocol?

	override func viewDidLoad() {
        super.viewDidLoad()
        addBackToNavigation()
        setTitleNavigation(title: LocalizableKey.saved.showLanguage)
        addButtonImageToNavigation(image: UIImage(named:"Material_Icons_white_chevron_left_Copy-1")!, style: .right, action: #selector(clickButtonRight))
        self.edgesForExtendedLayout = UIRectEdge.bottom
    }
    
    @objc func clickButtonRight(){
        if let controller = self.viewControllers[self.currentIndex] as? GrammarViewController {
            addButtonTextToNavigation(title: "\(LocalizableKey.done.showLanguage)", style: .right, action: #selector(clickFinish), textColor: .black)
            controller.actionDeleteFinish = actionReloadFinish
            controller.isDelete = true
            controller.reloadView()
            return
        }
        if let controller = self.viewControllers[self.currentIndex] as? NoteListViewController {
            addButtonTextToNavigation(title: "Xong", style: .right, action: #selector(clickFinish), textColor: .black)
            controller.actionDeleteFinish = actionReloadFinish
            controller.isDelete = true
            controller.reloadView()
            return
        }
        if let controller = self.viewControllers[self.currentIndex] as? VocabularyViewController {
            addButtonTextToNavigation(title: "Xong", style: .right, action: #selector(clickFinish), textColor: .black)
            controller.actionDeleteFinish = actionReloadFinish
            controller.isDelete = true
            controller.tableView.reloadData()
            return
        }
    }
    
    @objc func clickFinish(){
        if let controller = self.viewControllers[self.currentIndex] as? GrammarViewController {
            controller.deleteGrammar()
            return
        }
        
        if let controller = self.viewControllers[self.currentIndex] as?  NoteListViewController {
            controller.deleteNote()
            return
        }
    }
    
    func actionReloadFinish(){
        addButtonImageToNavigation(image: UIImage(named:"Material_Icons_white_chevron_left_Copy-1")!, style: .right, action: #selector(clickButtonRight))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        return [GrammarRouter.createModule(type:.vocabulary),VocabularyRouter.createModule(),NoteListRouter.createModule()]
    }

}


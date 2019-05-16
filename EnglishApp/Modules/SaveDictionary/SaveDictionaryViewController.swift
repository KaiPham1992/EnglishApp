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
        addButtonImageToNavigation(image: #imageLiteral(resourceName: "ic_settings"), style: .right, action: #selector(clickButtonRight))
    }
    @objc func clickButtonRight(){
        
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        return [GrammarRouter.createModule(),GrammarRouter.createModule()]
    }

}


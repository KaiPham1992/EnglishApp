//
//  QADetailViewController.swift
//  EnglishApp
//
//  Created Kai Pham on 5/13/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class QADetailViewController: BaseViewController, QADetailViewProtocol {

	var presenter: QADetailPresenterProtocol?
    
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbTime: UILabel!
    @IBOutlet weak var lbContent: UITextView!
    var id: Int = 0

	override func viewDidLoad() {
        super.viewDidLoad()
        fillData(qa: self.qa)
    }
    
    override func setUpNavigation() {
        super.setUpNavigation()
        
        addBackToNavigation()
        setTitleNavigation(title: LocalizableKey.titleQA.showLanguage)
    }
    
    var qa: QAEntity?
    
    private func fillData(qa: QAEntity?) {
        guard let qa = qa else { return }
        
        lbTitle.text = qa.title
        lbContent.text = qa.content
        lbTime.text =  qa.date?.toString(dateFormat: AppDateFormat.hhmmddmmyyy)
    }

}

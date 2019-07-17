//
//  StudyPackDetailViewController.swift
//  EnglishApp
//
//  Created by Henry on 7/17/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

class StudyPackDetailViewController: BaseViewController, StudyPackDetailViewProtocol {

    var presenter: StudyPackDetailPresenterProtocol?
    @IBOutlet weak var btnUpgrade: UIButton!
    @IBOutlet weak var webView: UIWebView!
    
    var product = ProductEntity()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayData()
    }

    @IBAction func btnUpgradeTapped(){
        
    }
    
    override func setUpNavigation() {
        super.setUpNavigation()
        addBackToNavigation()
        setTitleNavigation(title: product.name ?? "")
    }
    
    func displayData(){
        if let htmlString = product.content{
            webView.loadHTMLString(htmlString, baseURL: nil)
        }
        btnUpgrade.setTitle(LocalizableKey.upgrade.showLanguage, for: .normal)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

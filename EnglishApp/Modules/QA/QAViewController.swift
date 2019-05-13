//
//  QAViewController.swift
//  EnglishApp
//
//  Created Kai Pham on 5/13/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class QAViewController: BaseViewController, QAViewProtocol {

	var presenter: QAPresenterProtocol?
    @IBOutlet weak var tbHistory: UITableView!
    @IBOutlet weak var lbWhatQa: UILabel!
    @IBOutlet weak var lbMessage: UILabel!
    @IBOutlet weak var lbOlderQA: UILabel!
    @IBOutlet weak var tfQuestion: UITextField!
    
    var listHistory = [QAEntity]() {
        didSet {
            tbHistory.reloadData()
        }
    }
    
    override func setTitleUI() {
        super.setTitleUI()
        
        lbWhatQa.text = LocalizableKey.whatQA.showLanguage
        lbMessage.text = LocalizableKey.messageQA.showLanguage
        tfQuestion.placeholder = LocalizableKey.enterQA.showLanguage
        lbOlderQA.text = LocalizableKey.qAOlder.showLanguage
    }
    
    override func setUpNavigation() {
        super.setUpNavigation()
        addBackToNavigation()
        setTitleNavigation(title: LocalizableKey.titleQA.showLanguage)
    }
	override func viewDidLoad() {
        super.viewDidLoad()
        configureTable()
        
        listHistory = QAEntity.toArray()
    }
    
    @IBAction func btnSearchTapped() {
        
    }

}


extension QAViewController: UITableViewDelegate, UITableViewDataSource {
    func configureTable() {
        tbHistory.delegate = self
        tbHistory.dataSource = self
        tbHistory.registerXibFile(QACell.self)
        tbHistory.separatorStyle = .none
        
        tbHistory.estimatedRowHeight = 55
        tbHistory.rowHeight = UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(QACell.self, for: indexPath)
        cell.qa = listHistory[indexPath.item]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listHistory.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

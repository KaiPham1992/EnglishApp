//
//  GrammarViewController.swift
//  EnglishApp
//
//  Created vinova on 5/16/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit
import XLPagerTabStrip

enum TypeSave{
    case grammar
    case vocabulary
    case note
}

class GrammarViewController: UIViewController, GrammarViewProtocol {

    @IBOutlet weak var tbvGrammar: UITableView!
    var presenter: GrammarPresenterProtocol?
    var type : TypeSave = .grammar

	override func viewDidLoad() {
        super.viewDidLoad()
        tbvGrammar.registerXibFile(CellGrammar.self)
        tbvGrammar.dataSource = self
        tbvGrammar.delegate = self
    }
}
extension GrammarViewController : UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(CellGrammar.self, for: indexPath)
        return cell
    }
}
extension GrammarViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
extension GrammarViewController: IndicatorInfoProvider{
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        if type == .grammar {
            return IndicatorInfo(title: LocalizableKey.grammar.showLanguage)
        }
        if type == .note{
            return IndicatorInfo(title: LocalizableKey.note.showLanguage)
        }
        return IndicatorInfo(title: LocalizableKey.vocabulary.showLanguage)
    }
}
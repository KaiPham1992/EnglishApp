//
//  NoteViewController.swift
//  EnglishApp
//
//  Created vinova on 5/17/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit
import XLPagerTabStrip

class NoteViewController: UIViewController, NoteViewProtocol {

    @IBOutlet weak var tbvNote: UITableView!
    var presenter: NotePresenterProtocol?

	override func viewDidLoad() {
        super.viewDidLoad()
        tbvNote.registerXibFile(CellGrammar.self)
        tbvNote.dataSource = self
        tbvNote.delegate = self
    }
}
extension NoteViewController : UITableViewDataSource{
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
extension NoteViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
extension NoteViewController: IndicatorInfoProvider{
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: LocalizableKey.note.showLanguage)
    }
}

//
//  ResultViewController.swift
//  EnglishApp
//
//  Created vinova on 5/23/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit
import XLPagerTabStrip
import SDWebImage

class ResultViewController: BaseViewController {

    @IBAction func backHome(_ sender: Any) {
//        if type != .history {
//            NotificationCenter.default.post(name: NSNotification.Name.init("TestEntranceComplete"), object: [HomeViewController.self])
//        }
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblPoint: UILabel!
    @IBOutlet weak var imgAVT: UIImageView!
    @IBOutlet weak var vInfo: UIView!
    @IBOutlet weak var heightTableView: NSLayoutConstraint!
    @IBOutlet weak var trailingStackView: NSLayoutConstraint!
    @IBOutlet weak var leadingStackView: NSLayoutConstraint!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var viewRank: ViewPoint!
    @IBOutlet weak var btnBackHome: UIButton!
    @IBOutlet weak var lblTimeDoExercise: UILabel!
    @IBOutlet weak var lblPointSum: UILabel!
    @IBOutlet weak var tbvResult: UITableView!
    @IBOutlet weak var viewLevel: ViewPoint!
    var type : TypeDoExercise = .dailyMissonExercise
    var presenter: ResultPresenterProtocol?
    var id: String = "1"
    var isHistory : Bool = false

    override func setUpViews() {
        super.setUpViews()
        viewRank.imgView.image = #imageLiteral(resourceName: "ic_kimcuong")
        viewLevel.imgView.image = #imageLiteral(resourceName: "ic_gold")
        viewRank.lblTitle.text = LocalizableKey.diamond.showLanguage
        viewLevel.lblTitle.text  = LocalizableKey.levelUp.showLanguage
        
        if type ==  .levelExercise || type == .practiceExercise || type == .createExercise || type == .assignExercise || type == .dailyMissonExercise {
            viewRank.isHidden = true
            self.presenter?.getViewResult(id: id)
        }
        
//        if type == .resultCompetion {
//            viewRank.isHidden = false
        //            leadingStackView.constant = 28
        //            trailingStackView.constant = 28
//            self.presenter?.getViewResultUserCompetition(idCompetition: self.id)
//        }
    
        tbvResult.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
        tbvResult.registerXibFile(CellResult.self)
        tbvResult.dataSource = self
        tbvResult.delegate = self
        btnBackHome.setTitle(LocalizableKey.back_gome.showLanguage.uppercased(), for: .normal)
        lblPointSum.text = LocalizableKey.sum_point.showLanguage
        lblTimeDoExercise.text = LocalizableKey.time_do_exercise.showLanguage
        self.edgesForExtendedLayout = UIRectEdge.bottom
    }
    
    override func setUpNavigation() {
        super.setUpNavigation()
        addBackToNavigation()
//        if type == .dailyMissonExercise {
//            setTitleNavigation(title: LocalizableKey.dailyMissionTitle.showLanguage)
//        }
//
        if type ==  .levelExercise || type == .practiceExercise || type == .createExercise || type == .assignExercise || type == .dailyMissonExercise {
//            viewRank.isHidden = true
//            self.presenter?.getViewResult(id: id)
            setTitleNavigation(title: LocalizableKey.result.showLanguage)
        }
//        if type == .result || type == .history{
//            setTitleNavigation(title: LocalizableKey.result.showLanguage)
//        } else {
//            setTitleNavigation(title: LocalizableKey.result_competion.showLanguage)
//        }
    }
    
    override func btnBackTapped() {
//        if type != .history {
//            NotificationCenter.default.post(name: NSNotification.Name.init("TestEntranceComplete"), object: [HomeViewController.self])
//        }
        if isHistory {
            super.btnBackTapped()
        } else {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
}

extension ResultViewController: ResultViewProtocol{
    func reloadView() {
        self.tbvResult.reloadData()
        imgAVT.sd_setImage(with: URL(string: BASE_URL_IMAGE + (self.presenter?.getImageProfile() ?? "")), completed: nil)
        lblPoint.text = self.presenter?.getTotalPoint()&
        lblTime.text = self.presenter?.getTotalTime()&
//        if type == .result || type == .resultExercise || type == .history{
//            viewRank.setupNumber(number: "+ \(self.presenter?.getAmountDiamond() ?? "0") \(LocalizableKey.point.showLanguage)")
//        }
        viewLevel.setupNumber(number: "+ \(self.presenter?.getAmoutRank() ?? "0") \(LocalizableKey.point.showLanguage)")
    }
}

extension ResultViewController : UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let row = self.presenter?.getNumberQuestion() ?? 0
        return row
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(CellResult.self, for: indexPath)
        cell.indexPath = indexPath
        if let dataCell = self.presenter?.getPointQuestion(indexPath: indexPath){
            if dataCell > 0 {
                cell.setupData(isTrue: true, point: String(dataCell))
            } else if dataCell < 0 {
                cell.setupData(isTrue: false, point: String(dataCell))
            } else {
                cell.setupDataDefault(point: String(dataCell))
            }
        }
        
        heightTableView.constant = tbvResult.contentSize.height
        return cell
    }
}
extension ResultViewController : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let question = self.presenter?.getListAnswer() {
            self.presenter?.gotoResultQuestion(listAswer: question, index: indexPath.row)
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}

extension ResultViewController: IndicatorInfoProvider{
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: LocalizableKey.individual.showLanguage)
    }
}

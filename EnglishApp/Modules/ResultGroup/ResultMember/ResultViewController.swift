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
        if type == .entranceExercise {
            NotificationCenter.default.post(name: NSNotification.Name.init("TestEntranceComplete"), object: [HomeViewController.self], userInfo: ["isOut":self.isOut])
        }
//        self.navigationController?.popToRootViewController(animated: true)
        
        (self.tabBarController as! MainTabbar).gotoHome()
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBOutlet weak var lblDontJoinCompetition: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
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
    var isOut = false

    override func setUpViews() {
        super.setUpViews()

        viewRank.imgView.image = #imageLiteral(resourceName: "ic_kimcuong")
        viewLevel.imgView.image = #imageLiteral(resourceName: "ic_gold")
        viewRank.lblTitle.attributedText =  NSAttributedString(string: LocalizableKey.diamond.showLanguage)
        viewLevel.lblTitle.attributedText = NSAttributedString(string: LocalizableKey.point_level.showLanguage)
        if type ==  .levelExercise || type == .practiceExercise || type == .createExercise || type == .assignExercise || type == .dailyMissonExercise || type == .entranceExercise {
            viewRank.isHidden = false
            self.presenter?.getViewResult(id: id)
        }
        
        if type == .competition {
            self.presenter?.getViewResultUserCompetition(idCompetition: id)
        }
    
        tbvResult.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
        tbvResult.registerXibFile(CellResult.self)
        tbvResult.dataSource = self
        tbvResult.delegate = self
        btnBackHome.setTitle(LocalizableKey.back_gome.showLanguage.uppercased(), for: .normal)
        lblPointSum.attributedText = NSAttributedString(string: LocalizableKey.sum_point.showLanguage)
        lblTimeDoExercise.attributedText = NSAttributedString(string: LocalizableKey.time_do_exercise.showLanguage)
        self.edgesForExtendedLayout = UIRectEdge.bottom
    }
    
    override func setUpNavigation() {
        super.setUpNavigation()
        addBackToNavigation()
        if type ==  .levelExercise || type == .practiceExercise || type == .createExercise || type == .assignExercise || type == .dailyMissonExercise || type == .entranceExercise {
            setTitleNavigation(title: LocalizableKey.result_competion.showLanguage)
        }
    }
    
    override func btnBackTapped() {
        if type == .entranceExercise{
             NotificationCenter.default.post(name: NSNotification.Name.init("TestEntranceComplete"), object: [HomeViewController.self], userInfo: ["isOut":self.isOut])
        }
        if isHistory {
            super.btnBackTapped()
        } else {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
}

extension ResultViewController: ResultViewProtocol{
    func competitionIsDoing() {
        lblDontJoinCompetition.text = LocalizableKey.fight_is_doing_result.showLanguage
        scrollView.isHidden = true
        btnBackHome.isHidden = true
    }
    
    func usetDontJoindCompetition() {
        lblDontJoinCompetition.text = LocalizableKey.you_dont_joined_competition.showLanguage
        scrollView.isHidden = true
        btnBackHome.isHidden = true
    }
    
    func reloadView() {
        DispatchQueue.main.async {
            self.scrollView.isHidden = false
            self.btnBackHome.isHidden = false
            self.lblDontJoinCompetition.text = ""
            self.imgAVT.sd_setImage(with: URL(string: BASE_URL_IMAGE + (self.presenter?.getImageProfile() ?? "")), placeholderImage: UIImage(named: "ic_avatar_default")!, completed: nil)
            self.lblPoint.attributedText =  NSAttributedString(string: self.presenter?.getTotalPoint() ?? "0")
            self.lblTime.attributedText =  NSAttributedString(string: self.presenter?.getTotalTime() ?? "")
            self.viewRank.setupNumber(number: "+ \(self.presenter?.getAmountDiamond() ?? "0") \(LocalizableKey.point.showLanguage)")
            self.viewLevel.setupNumber(number: "+ \(self.presenter?.getAmoutRank() ?? "0") \(LocalizableKey.point.showLanguage)")
            self.tbvResult.reloadData()
            if self.type == .entranceExercise {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                    PopUpHelper.shared.showUpdateFeature(completeUpdate: { [unowned self] in
                        let vc = StoreViewController()
                        self.push(controller: vc)
                    }, completeCancel: {
                        
                    })
                })
            }
        }
        
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
            self.presenter?.gotoResultQuestion(listAswer: question, index: indexPath.row, isHistory: self.isHistory)
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

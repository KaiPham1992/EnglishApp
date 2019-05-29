//
//  NameExerciseViewController.swift
//  EnglishApp
//
//  Created vinova on 5/23/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class NameExerciseViewController: BaseViewController, NameExerciseViewProtocol {

	var presenter: NameExercisePresenterProtocol?

    @IBAction func clickMore(_ sender: Any) {
        if isShowMore {
            btnMore.setTitle("An bot", for: .normal)
            UIView.animate(withDuration: 0.1) {
                self.lbDetailQuestion.numberOfLines = 0
                self.heightScrollView.constant = self.vProfile.frame.size.height + self.heightTB + 20
                self.view.layoutIfNeeded()
            }
        } else {
            btnMore.setTitle("Xem them", for: .normal)
            UIView.animate(withDuration: 0.1) {
                self.lbDetailQuestion.numberOfLines = 8
                self.heightScrollView.constant = self.vProfile.frame.size.height + self.heightTB + 20
                self.view.layoutIfNeeded()
            }
        }
        self.isShowMore = !isShowMore
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.heightScrollView.constant = self.vProfile.frame.size.height + self.tbvNameExercise.contentSize.height + 20
    }
    
    @IBOutlet weak var btnMore: UIButton!
    @IBOutlet weak var heightMore: NSLayoutConstraint!
    @IBOutlet weak var lbDetailQuestion: UILabel!
    @IBOutlet weak var vProfile: UIView!
    @IBOutlet weak var heightScrollView: NSLayoutConstraint!
    @IBOutlet weak var tbvNameExercise: UITableView!
    var heightTB : CGFloat = 0
    let listQuestion : [String] = ["dasghdasjkdhasjdhasjdasjdhasdhasjkdhajksdhajskdhajks","czxnbcnmxzbcxzbcnxzbcmnzxbcmnzxbcmnzbczmnbcmnzxbcmznxbcmnxz","1","4","5","6","dasdasdasdasdasdasdasd","8","9","10","dasghdasjkdhasjdhasjdasjdhasdhasjkdhajksdhajskdhajks","czxnbcnmxzbcxzbcnxzbcmnzxbcmnzxbcmnzbczmnbcmnzxbcmznxbcmnxz","1","4","5","6","dasdasdasdasdasdasdasd","8","9","10","dasghdasjkdhasjdhasjdasjdhasdhasjkdhajksdhajskdhajks","czxnbcnmxzbcxzbcnxzbcmnzxbcmnzxbcmnzbczmnbcmnzxbcmznxbcmnxz","1","4","5","6","dasdasdasdasdasdasdasd","8","9","10"]
    var isShowMore = true
    override func viewDidLoad() {
        super.viewDidLoad()
        tbvNameExercise.registerXibFile(CellQuestion.self)
        tbvNameExercise.dataSource = self
        tbvNameExercise.delegate = self
        lbDetailQuestion.text = "In my opinion, the Internet is a very fast and convenient way for me to get information. I can also communicate with my friends and relatives by means of e-mail or chatting. However, I don't use the Internet very often because I don't have much time. For me, the Internet is a wonderful invention of modern life. It makes our world a small village.In the writer's opinion,In my opinion, the Internet is a very fast and convenient way for me to get information. I can also communicate with my friends and relatives by means of e-mail or chatting. However, I don't use the Internet very often because I don't have much time. For me, the Internet is a wonderful invention of modern life. It makes our world a small village.In the writer's opinion "
        DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
            let number = "In my opinion, the Internet is a very fast and convenient way for me to get information. I can also communicate with my friends and relatives by means of e-mail or chatting. However, I don't use the Internet very often because I don't have much time. For me, the Internet is a wonderful invention of modern life. It makes our world a small village.In the writer's opinion,In my opinion, the Internet is a very fast and convenient way for me to get information. I can also communicate with my friends and relatives by means of e-mail or chatting. However, I don't use the Internet very often because I don't have much time. For me, the Internet is a wonderful invention of modern life. It makes our world a small village.In the writer's opinion ".getHeightLabel(width: self.lbDetailQuestion.frame.width, font: AppFont.fontRegular14)
            if number > 8 {
                self.heightMore.constant = 24
            } else {
                self.heightMore.constant = 0
            }
        }
        
    }
    override func setUpNavigation() {
        super.setUpNavigation()
        setTitleNavigation(title: LocalizableKey.level_exercise.showLanguage)
        addBackToNavigation()
    }
    
}
extension NameExerciseViewController : UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(CellQuestion.self, for: indexPath)
        cell.setupData(title: listQuestion[indexPath.row])
        heightTB = tableView.contentSize.height
        heightScrollView.constant = vProfile.frame.height + heightTB + 20
        return cell
    }
}
extension NameExerciseViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //show popup suggestion result
//        PopUpHelper.shared.showSuggesstionResult(diamond: {
//
//        }) {
//
//        }
        //show pop update account
        PopUpHelper.shared.showUpdateAccount {
            
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

//
//  ViewComment.swift
//  EnglishApp
//
//  Created by vinova on 5/18/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import UIKit


class ViewComment: BaseViewXib{
    
    @IBAction func replyComment(_ sender: Any) {
        actionReply?()
    }
    
    var actionReply : (() -> ())?
    
    @IBOutlet weak var lblWait: UILabel!
    @IBOutlet weak var imgAVT: UIImageView!
    @IBOutlet weak var lblNameUser: UILabel!
    @IBOutlet weak var lblContent: UILabel!
    @IBOutlet weak var lblTimeCreate: UILabel!
    override func setUpViews() {
        super.setUpViews()
    }
    
    func setupViewChildren(data: ChildrenComment){
        imgAVT.sd_setImage(with: URL(string: BASE_URL_IMAGE + data.attach_img_src&), placeholderImage: #imageLiteral(resourceName: "avatarDefautl"), completed: nil)
        lblTimeCreate.text = data.created_date?.toString(dateFormat: AppDateFormat.commahhmmaddMMMyy)
        lblContent.attributedText = NSAttributedString(string: data.content ?? "")
        lblNameUser.attributedText = NSAttributedString(string: data.fullname ?? "")
        if let status = data.status {
            lblWait.isHidden = status == "1" ? false  : true
        }
    }
    
    func setupViewParent(data: ParentComment){
        imgAVT.sd_setImage(with: URL(string:  BASE_URL_IMAGE + data.attach_img_src&), placeholderImage: #imageLiteral(resourceName: "avatarDefautl"), completed: nil)
        lblTimeCreate.text = data.created_date?.toString(dateFormat: AppDateFormat.commahhmmaddMMMyy)
        lblContent.attributedText = NSAttributedString(string: data.content ?? "")
        lblNameUser.attributedText = NSAttributedString(string: data.fullname ?? "")
        if let status = data.status {
            lblWait.isHidden = status == "1" ? false : true
        }
    }
}

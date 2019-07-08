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
        
    }
    
    @IBOutlet weak var imgAVT: UIImageView!
    @IBOutlet weak var lblNameUser: UILabel!
    @IBOutlet weak var lblContent: UILabel!
    @IBOutlet weak var lblTimeCreate: UILabel!
    override func setUpViews() {
        super.setUpViews()
    }
    
    func setupViewChildren(data: ChildrenComment){
        lblTimeCreate.text = data.created_date
        lblContent.text = data.content
    }
    
    func setupViewParent(data: ParentComment){
        lblTimeCreate.text = data.created_date
        lblContent.text = data.content
    }
}

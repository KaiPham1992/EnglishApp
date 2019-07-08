//
//  CellComment.swift
//  EnglishApp
//
//  Created by vinova on 5/18/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

class CellComment: UITableViewCell {

    @IBOutlet weak var viewComment: ViewComment!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    func setupCellChildren(comment: ChildrenComment){
        viewComment.setupViewChildren(data: comment)
    }
}

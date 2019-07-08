//
//  CellHeaderComment.swift
//  EnglishApp
//
//  Created by vinova on 5/20/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

class CellHeaderComment: UITableViewCell {

    @IBOutlet weak var viewComment: ViewComment!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    func setupCellParent(comment: ParentComment){
        viewComment.setupViewParent(data: comment)
    }
    
}

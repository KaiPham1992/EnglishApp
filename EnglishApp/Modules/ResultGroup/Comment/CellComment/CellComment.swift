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
    
    var actionReply :((_ index: IndexPath)->())?
    var indexPath: IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        viewComment.actionReply = {[weak self] in
            self?.actionReply?(self?.indexPath ?? IndexPath(row: 0, section: 0))
        }
    }
    
    func setupCellChildren(comment: ParentComment){
        viewComment.setupViewParent(data: comment)
    }
}

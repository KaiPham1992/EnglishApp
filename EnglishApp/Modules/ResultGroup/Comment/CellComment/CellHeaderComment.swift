//
//  CellHeaderComment.swift
//  EnglishApp
//
//  Created by vinova on 5/20/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

protocol ActionReplyComment : class{
    func replyHeader(indexSection: Int)
}

class CellHeaderComment: UITableViewCell {

    @IBOutlet weak var viewComment: ViewComment!
    var indexSection: Int?
    weak var delegate: ActionReplyComment?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        
        viewComment.actionReply = {
            self.delegate?.replyHeader(indexSection: self.indexSection ?? 0)
        }
        
    }
    func setupCellParent(comment: ParentComment){
        viewComment.setupViewParent(data: comment)
    }
    
}

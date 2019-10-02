//
//  HomeRecentlyCell.swift
//  EnglishApp
//
//  Created by Kai Pham on 5/18/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

class HomeRecentlyCell: BaseTableCell {

    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbContent: UILabel!
    
    var actity: Acitvity? {
        didSet {
            guard let activity = actity else { return }
            lbContent.attributedText = NSAttributedString(string: activity.content ?? "")
            lbTitle.attributedText = NSAttributedString(string: activity.fullName ?? "")
            imgIcon.sd_setImage(with: activity.urlAvatar, placeholderImage: #imageLiteral(resourceName: "ic_avatar_default"))
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}

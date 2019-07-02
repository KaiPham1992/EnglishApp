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
            lbContent.text = activity.content
            lbTitle.text = activity.title
            imgIcon.sd_setImage(with: activity.urlAvatar, placeholderImage: AppImage.imgPlaceHolder)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}

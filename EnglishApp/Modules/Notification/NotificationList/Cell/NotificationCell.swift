//
//  NotificationCell.swift
//  EnglishApp
//
//  Created by Kai Pham on 6/2/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

class NotificationCell: BaseTableCell {
    
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbContent: UILabel!
    @IBOutlet weak var lbDate: UILabel!
    
    var notification: NotificationEntity? {
        didSet {
            guard let notification = notification else { return }
            lbTitle.text = notification.title
            lbContent.text = notification.content
            lbDate.text = notification.createTime?.toString(dateFormat: AppDateFormat.hhmmddmmyyy)
            
            self.backgroundColor = notification.isRead == true ? .white: AppColor.notificationNotRead
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func changeColor() {
        self.backgroundColor = .white
    }
}

//
//  PackageCell.swift
//  EnglishApp
//
//  Created by Henry on 9/16/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit
class PackageCell: BaseTableCell {
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbTime: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        lbTime.textColor = AppColor.bdbdbdGray
    }
}

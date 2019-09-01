//
//  MoreDictionaryCell.swift
//  EnglishApp
//
//  Created by vinova on 5/15/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

class MoreDictionaryCell: UITableViewCell {

    @IBOutlet weak var heightBtnChocie: NSLayoutConstraint!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var btnChoice: RatioButton!
    @IBOutlet weak var lblTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    var isDownloaded : Bool = false
    var actionCell : ((_ idDownloaded: Bool)->())?
    var actionSetDefaultDictionary : ((_ isChoice: Bool) -> ())?
    @IBAction func clickAction(_ sender: Any) {
        actionCell?(isDownloaded)
    }
    
    @IBAction func setDefaultDictionary(_ sender: Any) {
        actionSetDefaultDictionary?(btnChoice.isChocie)
    }
    
    func hideBtnDelete() {
        indicator.startAnimating()
        btnDelete.isHidden  = true
    }
    
    func setupCell(isDownloaded: Bool, title: String, isDefault: Bool, idDownloading : Bool){
        self.isDownloaded = isDownloaded
        lblTitle.text = title
//        btnDelete.isHidden = false
        if !idDownloading {
            indicator.stopAnimating()
            btnDelete.isHidden = false
            btnChoice.isHidden = false
            if isDownloaded {
                heightBtnChocie.constant = 24
                btnDelete.setBackgroundImage(#imageLiteral(resourceName: "Material_Icons_black_delete"), for: .normal)
                btnChoice.isHidden = false
                btnChoice.isChocie = isDefault
            } else {
                heightBtnChocie.constant = 0
                btnDelete.setBackgroundImage(#imageLiteral(resourceName: "ic_download_button"), for: .normal)
                btnChoice.isHidden = true
            }
        } else {
            indicator.startAnimating()
            btnChoice.isHidden = true
            btnDelete.isHidden = true
        }
    }
}

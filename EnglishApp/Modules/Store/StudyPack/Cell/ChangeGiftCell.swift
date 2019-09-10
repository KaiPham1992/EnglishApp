//
//  ChangeGiftCell.swift
//  EnglishApp
//
//  Created by Kai Pham on 6/2/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

protocol ChangeGiftCellDelegate {
    func btnHoneyTapped(index: Int)
    func btnDiamondTapped(index: Int)
}

class ChangeGiftCell: BaseTableCell {
    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbContent: UILabel!
    @IBOutlet weak var lbCountHoney: UILabel!
    @IBOutlet weak var lbCountDiamon: UILabel!
    @IBOutlet weak var btnHoney: UIButton!
    @IBOutlet weak var btnDiamond: UIButton!
    
    var delegate: ChangeGiftCellDelegate?
    var product: ProductEntity? {
        didSet {
            guard let product = product else { return }
            
            imgIcon.sd_setImage(with: product.urlAvatar, placeholderImage: AppImage.imgPlaceHolder)
            
            lbTitle.attributedText = NSAttributedString(string: product.name&)
            lbContent.text = product.content?.htmlToString
            lbCountHoney.text = product.amountHoney& + " \(LocalizableKey.boxHoneyTitle.showLanguage.lowercased())"
            lbCountDiamon.text = product.amountDiamond& + " \(LocalizableKey.diamond.showLanguage.lowercased())"
            btnHoney.isUserInteractionEnabled = true
            btnDiamond.isUserInteractionEnabled = true
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // -- MARK: - ACTION
    
    @IBAction func btnDiamondTapped() {
        delegate?.btnDiamondTapped(index: btnDiamond.tag)
    }
    
    @IBAction func btnHoneyTapped() {
        delegate?.btnHoneyTapped(index: btnHoney.tag)
    }
    
    
}

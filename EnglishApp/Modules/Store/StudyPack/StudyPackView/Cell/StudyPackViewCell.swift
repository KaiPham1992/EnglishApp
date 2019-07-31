//
//  StudyPackViewCell.swift
//  EnglishApp
//
//  Created by Kai Pham on 5/21/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit
import SDWebImage

protocol StudyPackViewCellDelegate: class {
    func btnDetailTapped(index: Int)
}

class StudyPackViewCell: UICollectionViewCell {
    
//    @IBOutlet weak var lbPackageName: UILabel!
//    @IBOutlet weak var lbDetail: UILabel!
//    @IBOutlet weak var vPreviewAll: InfoPackView!
//    @IBOutlet weak var vDoAll: InfoPackView!
//    @IBOutlet weak var vCanComment: InfoPackView!
//    @IBOutlet weak var vCanCreateWork: InfoPackView!
//    @IBOutlet weak var vWorkDependOnLevel: InfoPackView!
//    @IBOutlet weak var tvDetails: UITextView!
    @IBOutlet weak var imgLogo: UIImageView!
    
//    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var btnDetail: UIButton!
//    @IBOutlet weak var lbName: UILabel!
    
    var product = ProductEntity()
    weak var delegate: StudyPackViewCellDelegate?

    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
//        vPreviewAll.setTitleImage(title: "Xem tất cả bài giảng", image: AppImage.imgTickGreen)
//        vDoAll.setTitleImage(title: "Được làm tất cả bài tập", image: AppImage.imgTickGreen)
//        vCanComment.setTitleImage(title: "Nhìn được bình luận", image: AppImage.imgTickGreen)
//        vCanCreateWork.setTitleImage(title: "Tạo được bài tập", image: AppImage.imgTickGreen)
//        vWorkDependOnLevel.setTitleImage(title: "Bài tập cho theo cấp độ", image: AppImage.imgCloseRed)
    }
    
    func getData(product: ProductEntity){
        self.product = product
        displayData()
    }
//    func displayData(){
//        lbPackageName.text = product.name
//        if let amountHoney = product.amountHoney{
//            lbDetail.text = "\(amountHoney) \(LocalizableKey.boxHoney.showLanguage) - \(product.durationAmount&) \(product.durationUnit&) \(LocalizableKey.YEAR.showLanguage)"
//        }
//        if let amountDiamond = product.amountDiamond{
//            lbDetail.text = "\(amountDiamond) \(LocalizableKey.diamond.showLanguage) - \(product.durationAmount&) \(product.durationUnit&) \(LocalizableKey.YEAR.showLanguage)"
//        }
//        imgIcon.sd_setImage(with: product.urlAvatar, placeholderImage: AppImage.imgPlaceHolder)
//        print(product.content)
//        tvDetails.attributedText = product.content?.htmlToAttributedString
//    }
    func setUpView(){
    }
    
    func displayData(){
        imgLogo.sd_setImage(with: product.urlAvatar, placeholderImage: AppImage.imgPlaceHolder)
//        btnDetail.setTitle(LocalizableKey.detail.showLanguage, for: .normal)
    }
    @IBAction func btnDetailTapped() {
        delegate?.btnDetailTapped(index: btnDetail.tag)
    }

}

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
    func btnDetailTapped()
}

class StudyPackViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lbPackageName: UILabel!
    @IBOutlet weak var lbDetail: UILabel!
    @IBOutlet weak var vPreviewAll: InfoPackView!
    @IBOutlet weak var vDoAll: InfoPackView!
    @IBOutlet weak var vCanComment: InfoPackView!
    @IBOutlet weak var vCanCreateWork: InfoPackView!
    @IBOutlet weak var vWorkDependOnLevel: InfoPackView!
    
    @IBOutlet weak var imgIcon: UIImageView!
    
    var product = ProductEntity()
    weak var delegate: StudyPackViewCellDelegate?

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        vPreviewAll.setTitleImage(title: "Xem tất cả bài giảng", image: AppImage.imgTickGreen)
        vDoAll.setTitleImage(title: "Được làm tất cả bài tập", image: AppImage.imgTickGreen)
        vCanComment.setTitleImage(title: "Nhìn được bình luận", image: AppImage.imgTickGreen)
        vCanCreateWork.setTitleImage(title: "Tạo được bài tập", image: AppImage.imgTickGreen)
        vWorkDependOnLevel.setTitleImage(title: "Bài tập cho theo cấp độ", image: AppImage.imgCloseRed)
    }
    
    func getData(product: ProductEntity){
        self.product = product
        displayData()
    }
    func displayData(){
        lbPackageName.text = product.name
        if let amountHoney = product.amountHoney{
            lbDetail.text = "\(amountHoney) hũ mật ong - \(product.durationAmount&) \(product.durationUnit& == "YEAR" ? "NĂM" : "MONTH")"
        }
        if let amountDiamond = product.amountDiamond{
            lbDetail.text = "\(amountDiamond) kim cương - \(product.durationAmount&) \(product.durationUnit& == "YEAR" ? "NĂM" : "MONTH")"
        }
        imgIcon.sd_setImage(with: product.urlAvatar, placeholderImage: AppImage.imgPlaceHolder)
    }
    @IBAction func btnDetailTapped() {
        delegate?.btnDetailTapped()
    }

}

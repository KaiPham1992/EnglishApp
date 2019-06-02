//
//  StudyPackViewCell.swift
//  EnglishApp
//
//  Created by Kai Pham on 5/21/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

protocol StudyPackViewCellDelegate: class {
    func btnDetailTapped()
}

class StudyPackViewCell: UICollectionViewCell {
    
    @IBOutlet weak var vPreviewAll: InfoPackView!
    @IBOutlet weak var vDoAll: InfoPackView!
    @IBOutlet weak var vCanComment: InfoPackView!
    @IBOutlet weak var vCanCreateWork: InfoPackView!
    @IBOutlet weak var vWorkDependOnLevel: InfoPackView!
    
    weak var delegate: StudyPackViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        
        vPreviewAll.setTitleImage(title: "Xem tất cả bài giảng", image: AppImage.imgTickGreen)
        vDoAll.setTitleImage(title: "Được làm tất cả bài tập", image: AppImage.imgTickGreen)
        vCanComment.setTitleImage(title: "Nhìn được bình luận", image: AppImage.imgTickGreen)
        vCanCreateWork.setTitleImage(title: "Tạo được bài tập", image: AppImage.imgTickGreen)
        vWorkDependOnLevel.setTitleImage(title: "Bài tập cho theo cấp độ", image: AppImage.imgCloseRed)
    }
    
    @IBAction func btnDetailTapped() {
        delegate?.btnDetailTapped()
    }

}

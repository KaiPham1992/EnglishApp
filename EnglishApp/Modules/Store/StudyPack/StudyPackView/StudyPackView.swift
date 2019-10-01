//
//  StudyPackView.swift
//  EnglishApp
//
//  Created by Kai Pham on 5/21/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

protocol StudyPackViewDelegate: class {
    func btnDetailTapped(index: Int)
}

class StudyPackView: BaseViewXib {
    @IBOutlet weak var cvStudyPack: UICollectionView!
    var listProduct = [ProductEntity]()
    weak var delegate: StudyPackViewDelegate?
    override func setUpViews() {
        super.setUpViews()
        configureCollection()
        
    }
    func getData(listProduct: [ProductEntity]){
        self.listProduct = listProduct
        cvStudyPack.reloadData()
    }
}

extension StudyPackView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, StudyPackViewCellDelegate {
    func configureCollection() {
        cvStudyPack.delegate = self
        cvStudyPack.dataSource = self
        
        if let layout = cvStudyPack.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = 0
            layout.scrollDirection = .horizontal
        }
        
        cvStudyPack.registerXibCell(StudyPackViewCell.self)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(StudyPackViewCell.self, indexPath: indexPath)
        cell.delegate = self
        cell.getData(product: listProduct[indexPath.row])
        cell.btnDetail.tag = indexPath.row
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listProduct.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10 
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.cvStudyPack.frame.height * (157 / 215)
        return CGSize(width: width, height: cvStudyPack.frame.height)
    }

    func btnDetailTapped(index: Int) {
        delegate?.btnDetailTapped(index: index)
    }
    
}

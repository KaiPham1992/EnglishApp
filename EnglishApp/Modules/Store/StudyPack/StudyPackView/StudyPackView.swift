//
//  StudyPackView.swift
//  EnglishApp
//
//  Created by Kai Pham on 5/21/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit

class StudyPackView: BaseViewXib {
    @IBOutlet weak var cvStudyPack: UICollectionView!
    
    override func setUpViews() {
        super.setUpViews()
        configureCollection()
    }
}

extension StudyPackView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func configureCollection() {
        cvStudyPack.delegate = self
        cvStudyPack.dataSource = self
        
        if let layout = cvStudyPack.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumLineSpacing = 8
            layout.minimumInteritemSpacing = 8
            layout.scrollDirection = .horizontal
        }
        
        cvStudyPack.registerXibCell(StudyPackViewCell.self)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(StudyPackViewCell.self, indexPath: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.cvStudyPack.frame.width / 2.5
        return CGSize(width: width, height: cvStudyPack.frame.height)
    }
}

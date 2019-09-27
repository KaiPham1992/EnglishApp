//
//  ViewFillQuestion.swift
//  EnglishApp
//
//  Created by vinova on 6/24/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import UIKit

protocol TextViewChangeHeightDelegate : class{
    func distanceChange(distance: CGFloat)
    func textChanged(text: String, index: Int)
}


class ViewFillQuestion : BaseViewXib {
    
    @IBOutlet weak var lblNumberQuestion: UILabel!
    @IBOutlet weak var tvContent: UITextView!
    weak var delegate: TextViewChangeHeightDelegate?
    
    var tagView : Int = 0 {
        didSet{
            lblNumberQuestion.text = "\(tagView):"
        }
    }
    
    var content : String = "" {
        didSet{
            tvContent.text = content
        }
    }
    
    var oldHeight : CGFloat = 40
    
    override func setUpViews() {
        super.setUpViews()
        tvContent.delegate = self
    }
    
    
    func setupTag(tag: Int){
        self.tagView = tag
    }
    
    func adjustHeight(){
        print(UIScreen.main.bounds.width)
        oldHeight = self.tvContent.frame.height + 9
        let fixedWidth = self.tvContent.frame.width
        let newSize = self.tvContent.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        self.tvContent.frame.size.height = newSize.height
    }
}

extension ViewFillQuestion : UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        self.adjustHeight()
        delegate?.textChanged(text: textView.text, index: self.tagView)
        delegate?.distanceChange(distance: self.tvContent.frame.height + 9 - oldHeight)
    }
}

//
//  AppTextView.swift
//  Ipos
//
//  Created by Kai Pham on 4/19/19.
//  Copyright © 2019 edward. All rights reserved.
//


import Foundation

import UIKit

class AppTextView: UIView {
    
    let maxTextCount = 250
    let viewContain: UIView = {
        let view = UIView()
        view.setBorder(borderWidth: 1, borderColor: AppColor.lineNavigationBar, cornerRadius: 5)
        return view
    }()
    
    lazy var tvInput: UITextView = {
        let tv              = UITextView()
        tv.font             = AppFont.fontRegular14
        tv.delegate         = self
        tv.backgroundColor = .clear
        return tv
    }()
    
    let lbTitle: UILabel = {
        let lb              = UILabel()
        lb.font             = AppFont.fontRegular14
        lb.textColor        = AppColor.black
        lb.numberOfLines    = 0
        
        return lb
    }()
    
    let lbPlaceHolder: UILabel = {
        let lb              = UILabel()
        lb.font             = AppFont.fontRegular14
        lb.textColor        = AppColor.black.withAlphaComponent(0.5)
        lb.numberOfLines    = 0
        
        return lb
    }()
    
    //---
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    func setupViews() {
        addSubview(lbTitle)
        addSubview(viewContain)
        viewContain.addSubview(tvInput)
        viewContain.addSubview(lbPlaceHolder)
        
        lbTitle.anchor(self.topAnchor, left: self.leftAnchor, right: self.rightAnchor, topConstant: 0, leftConstant: 0, rightConstant: 0, heightConstant: 20)
        
        //-- view contain
        viewContain.anchor(lbTitle.bottomAnchor, left: lbTitle.leftAnchor, bottom: self.bottomAnchor, right: lbTitle.rightAnchor, topConstant: 4, leftConstant: 0, bottomConstant: 0, rightConstant: 0)
        
        //tfInput
        tvInput.anchor(viewContain.topAnchor, left: viewContain.leftAnchor, bottom: viewContain.bottomAnchor, right: viewContain.rightAnchor, topConstant: 16, leftConstant: 16, bottomConstant: 20, rightConstant: 16, widthConstant: 0, heightConstant: 0)
        tvInput.contentInset = UIEdgeInsets(top: -7, left: 0, bottom: 0, right: 0 )
        
        lbPlaceHolder.anchor(tvInput.topAnchor, left: tvInput.leftAnchor, bottom: nil, right: tvInput.rightAnchor, topConstant: 0, leftConstant: 3, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
    
}

extension AppTextView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        lbPlaceHolder.isHidden = !textView.text.cutWhiteSpace().isValidEmpty()
        
        if !textView.text.cutWhiteSpace().isValidEmpty() {
            lbPlaceHolder.isHidden = true
            viewContain.backgroundColor = AppColor.f1f1f1
        } else {
            lbPlaceHolder.isHidden = false
            viewContain.backgroundColor = .white
        }
    }
    
    func setPlaceHolder(placeHolder: String) {
        lbPlaceHolder.text = placeHolder
    }
    
    func hidePlaceHolder() {
        lbPlaceHolder.isHidden = true
    }
    
    func showPlaceholder() {
        lbPlaceHolder.isHidden = false
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        hidePlaceHolder()
        return true
    }
    
    func setTitleAndPlaceHolder(title: String? = nil, placeHolder: String? = nil) {
        if title != nil {
            self.lbTitle.text = title
        }
        
        if placeHolder != nil {
            self.lbPlaceHolder.text = placeHolder
        }
    }
    
}

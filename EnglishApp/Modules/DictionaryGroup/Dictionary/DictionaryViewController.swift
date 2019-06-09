//
//  DictionaryViewController.swift
//  EnglishApp
//
//  Created vinova on 5/15/19.
//  Copyright © 2019 demo. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit
import DropDown

class DictionaryViewController: BaseViewController, DictionaryViewProtocol {

    @IBOutlet weak var imgPolygon: UIImageView!
    @IBOutlet weak var lblDictionary: UILabel!
    @IBOutlet weak var viewDictionary: UIView!
    @IBOutlet weak var tfSearch: TextFieldBee!
    
    var presenter: DictionaryPresenterProtocol?
    let dropDownDictionary = DropDown()
    let dropDownSearch = DropDown()

    @IBAction func clickDictionary(_ sender: Any) {
        if dropDownDictionary.isHidden {
            self.rotateImage()
            dropDownDictionary.show()
        }
    }
    override func setUpViews() {
        super.setUpViews()
        tfSearch.offset
        self.tabBarController?.tabBar.isHidden = true
        lblDictionary.text = LocalizableKey.vietnamese_to_english.showLanguage
        DispatchQueue.main.asyncAfter(deadline: .now()+0.2) {
            self.setupDropDown()
        }
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            self.getData()
        }
    }
    
    

    override func setUpNavigation() {
        super.setUpNavigation()
        addBackToNavigation()
        setTitleNavigation(title: LocalizableKey.dictionaty.showLanguage)
        addButtonToNavigation(image: UIImage(named: "ic_settings")!, style: .right, action: #selector(clickButtonRight) )
    }
    
    @objc func clickButtonRight(){
        self.push(controller: MoreDictionaryRouter.createModule(),animated: true)
    }
    
    private func getData(){
        dropDownDictionary.dataSource = [LocalizableKey.vietnamese_to_english.showLanguage,LocalizableKey.english_to_english.showLanguage,LocalizableKey.english_to_vietnamese.showLanguage,LocalizableKey.japanese_to_vietnamese.showLanguage]
//        dropDownDictionary.show()
//        dropDownSearch.dataSource = ["a","b","c"]
//        dropDownSearch.show()
    }
    
    func setupDropDown(){
        //dropdownDictionary
        dropDownDictionary.anchorView = self.viewDictionary
        dropDownDictionary.backgroundColor = UIColor(red: 32/255, green: 181/255, blue: 85/255, alpha: 1)
//        dropDownDictionary.backgroundColor = UIColor.white
        dropDownDictionary.width = self.viewDictionary.frame.width
        dropDownDictionary.bottomOffset = CGPoint(x: 0, y: (viewDictionary.frame.height))
        dropDownDictionary.setupCornerRadius(0)
        dropDownDictionary.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
            return
        }
        // Action triggered on selection
        dropDownDictionary.selectionAction = { [unowned self] (index: Int, item: String) in
            self.lblDictionary.text = item
            self.rotateImage()
            self.dropDownDictionary.hide()
            
        }
        
        dropDownDictionary.cancelAction = { [unowned self] in
            self.rotateImage()
        }
        
        //dropdownSearch
        dropDownSearch.anchorView = self.tfSearch
        dropDownSearch.backgroundColor = UIColor.white
        dropDownSearch.width = self.tfSearch.frame.width
        dropDownSearch.bottomOffset = CGPoint(x: 0, y: (tfSearch.frame.height))
        dropDownSearch.setupCornerRadius(0)
        dropDownSearch.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
            return
        }
        // Action triggered on selection
        dropDownSearch.selectionAction = { [unowned self] (index: Int, item: String) in
            self.dropDownSearch.hide()
        }
    }
    
    func rotateImage(){
        UIView.animate(withDuration: 0.2) {
            self.imgPolygon.transform = self.imgPolygon.transform.rotated(by: CGFloat(Double.pi))
        }
    }
}
